# Rediseño de ITeP: De YAML flat a modelo relacional

## Contexto

ITeP maneja proyectos LaTeX académicos. Toda la información de un proyecto vive en un `config.yaml` por proyecto, causando duplicación masiva cuando el mismo curso se imparte en múltiples ciclos, los mismos libros se usan en múltiples cursos, o la misma institución tiene múltiples cursos.

### Decisiones tomadas

1. **DB como fuente completa** — config.yaml se reduce a un puntero. La DB es la fuente de verdad.
2. **SQLAlchemy** como ORM (sin Django). DB en `~/.config/itep/itep.db`.
3. **Symlinks derivados** — se computan en runtime desde relaciones en la DB + templates en models.py.
4. **Schedule fijo por curso** — la distribución de semanas no cambia entre instancias del mismo curso.
5. **Tablas separadas** para lecture_instance y general_project (sin tabla base compartida).
6. **general_project y main_topic separados** (relación 1:1) — no todos los main_topics tienen proyecto.

---

## Esquema propuesto (SQLAlchemy)

### Capa 1: Datos de referencia (preloaded, rara vez cambian)

```
institution
├── id (PK)
├── short_name        # "UCR", "UFide", "UCIMED" (unique)
├── full_name         # "Universidad de Costa Rica"
├── cycle_weeks       # 18
├── cycle_name        # "Semestre"
└── moodle_url        # "mv.mediacionvirtual.ucr.ac.cr"

main_topic
├── id (PK)
├── name              # "Mecánica Clásica"
├── code              # "10MC" (unique)
└── ddc_mds           # "531" (Dewey Decimal)
```

### Capa 2: Entidades maestras (datos reutilizables)

```
author
├── id (PK)
├── first_name
├── last_name
├── alias
├── affiliation
├── created_at, updated_at
└── UNIQUE(first_name, last_name)

book
├── id (PK)
├── name
├── year
└── edition

book_author
├── id (PK)
├── book_id (FK → book)
├── author_id (FK → author)
├── author_type        # "author", "editor", "translator", etc.
├── first_author       # bool
└── UNIQUE(book_id, author_id, author_type)

topic
├── id (PK)
├── main_topic_id (FK → main_topic)
├── name              # "Cinemática"
└── serial_number     # orden dentro del main_topic

content
├── id (PK)
├── topic_id (FK → topic)
├── chapter_number
├── section_number
├── name
├── first_page, last_page
└── first_exercise, last_exercise (nullable)

book_content
├── book_id (FK → book)
└── content_id (FK → content)
```

### Capa 3: Template de curso (reutilizable entre ciclos)

```
course
├── id (PK)
├── institution_id (FK → institution)
├── code              # "FS0121"
├── name              # "Física General I"
├── lectures_per_week # 3
└── hours_per_lecture  # 2

course_content
├── id (PK)
├── course_id (FK → course)
├── content_id (FK → content)
└── lecture_week       # semana en que se imparte (fijo)
    CHECK(lecture_week <= course.institution.cycle_weeks)

evaluation_template
├── id (PK)
├── institution_id (FK → institution)
├── name              # "Parcial", "Quiz"
└── template_file     # path a template LaTeX

item
├── id (PK)
├── name
├── template_file
├── taxonomy_level    # Bloom: "Recordar", "Comprender", etc.
└── taxonomy_domain   # "Información", "Procedimiento Mental", etc.

evaluation_item
├── id (PK)
├── evaluation_id (FK → evaluation_template)
├── item_id (FK → item)
├── total_amount
└── points_per_item

course_evaluation
├── id (PK)
├── course_id (FK → course)
├── evaluation_id (FK → evaluation_template)
├── serial_number     # "Parcial 1", "Parcial 2"
├── percentage        # 0.0 - 1.0
└── evaluation_week
    CHECK(course.institution == evaluation.institution)
    CHECK(percentage BETWEEN 0 AND 1)
```

### Capa 4: Instancias de proyecto (reemplazan ProjectStructure)

Dos tablas independientes, sin tabla base compartida.

```
lecture_instance
├── id (PK)
├── course_id (FK → course)       # code y name vienen del course
├── year
├── cycle                         # 1-3
├── first_monday                  # para computar fechas concretas
├── abs_parent_dir                # path local del filesystem
├── abs_src_dir                   # path a templates LaTeX locales
├── created_at
├── last_modification
└── version
    # root dir se deriva: "{institution.short_name}-{course.code}"
    # topics/books vienen de course → course_content → content → topic/book

general_project
├── id (PK)
├── main_topic_id (FK → main_topic, UNIQUE)  # relación 1:1
├── abs_parent_dir                # path local del filesystem
├── abs_src_dir                   # path a templates LaTeX locales
├── created_at
├── last_modification
└── version
    # code y name se derivan de main_topic.code y main_topic.name
    # root dir se deriva: "{main_topic.code}-{main_topic.name}"

general_project_book
├── general_project_id (FK → general_project)
└── book_id (FK → book)

general_project_topic
├── general_project_id (FK → general_project)
└── topic_id (FK → topic)
```

### Diagrama de relaciones

```
┌──────────────┐
│  institution │
└──────┬───────┘
       │
  ┌────┴──────────────┐
  ▼                   ▼
┌────────┐    ┌────────────────┐
│ course │    │ eval_template  │
└───┬────┘    └────────────────┘
    │
    ├────────────────────────┐
    ▼                        ▼
┌──────────────┐    ┌────────────────┐
│course_content│    │course_evaluation│
└──────┬───────┘    └────────────────┘
       │
       ▼
┌─────────┐    ┌──────┐    ┌────────────┐    ┌─────────────────┐
│ content │───▶│topic │───▶│ main_topic │◄───│ general_project │
└────┬────┘    └──────┘    └────────────┘    └────────┬────────┘
     │                                           ┌────┴────┐
book_content                                     ▼         ▼
     │                                    gp_topic    gp_book
┌────▼───┐    ┌────────┐
│  book  │◄───│ author │ (via book_author)
└────────┘    └────────┘

┌────────────────────┐
│ lecture_instance    │──── FK → course
└────────────────────┘
```

---

## Cómo cambia cada componente

### config.yaml → puntero mínimo

```yaml
# Antes: ~100 líneas con toda la info duplicada
# Después:
project_type: lecture  # o "general"
project_id: 42
```

Todo lo demás se lee de la DB. El archivo sirve como marcador "esta carpeta es un proyecto ITeP".

### structure.py → se retira gradualmente

Los dataclasses (`ProjectStructure`, `Admin`, `Evaluation`, `WeekDay`, etc.) se reemplazan por modelos SQLAlchemy. La lógica de input (FieldSpec) se adapta para poblar modelos SQLAlchemy en vez de dataclasses.

Clases que permanecen:
- `ConfigType`, `Institution`, `GeneralDirectory` (enums)
- `ConfigData` — helper para resolver symlinks (no es persistencia)
- `ProjectModel` (en models.py) — template de estructura de directorios y reglas de symlinks

### models.py (GeneralProject/LectureProject) → se mantienen

Definen templates de filesystem (tree, links), no datos. Siguen en Python code.

### ioconfig.py → se simplifica

`save_config()` escribe solo `{project_type, project_id}`.
`load_config()` lee el project_id y consulta la DB.

### links.py → consulta la DB

`relink` lee project_id del config.yaml, consulta la DB para obtener topics/books/paths, y aplica las reglas de symlinks desde models.py.

### create.py → escribe a la DB

En vez de construir un `ProjectStructure` y serializar a YAML:
1. Selecciona o crea Course (lecture) / main_topic (general) en la DB
2. Crea un `lecture_instance` o `general_project` en la DB
3. Crea directorios y symlinks
4. Escribe config.yaml mínimo

### manager.py → CRUD sobre la DB

Las operaciones de gestión (update, clone cycle, etc.) operan sobre la DB.

---

## Flujo de creación de proyecto (nuevo)

```
Usuario ejecuta `inittex`
  │
  ├─ Selecciona project_type (general/lecture)
  │
  ├─ Si lecture:
  │   ├─ Selecciona Institution (de la DB)
  │   ├─ Selecciona Course existente o crea uno nuevo
  │   │   └─ Si nuevo: ingresa code, name, lectures_per_week
  │   │       selecciona topics, books, define schedule (course_content)
  │   │       define evaluations (course_evaluation)
  │   ├─ Ingresa year, cycle, first_monday
  │   └─ → Crea lecture_instance en DB
  │
  ├─ Si general:
  │   ├─ Selecciona main_topic existente
  │   ├─ Selecciona topics y books para este proyecto
  │   └─ → Crea general_project en DB + general_project_book + general_project_topic
  │
  ├─ Crea directorios (desde ProjectModel.tree)
  ├─ Crea symlinks (derivados de DB + ProjectModel.links)
  └─ Escribe config.yaml con {project_type, project_id}
```

## Flujo de clonación de ciclo (habilitado por DB, solo lecture)

```
Usuario ejecuta `inittex --clone <project_id>`
  │
  ├─ Lee lecture_instance existente de la DB
  ├─ Hereda course_id (y con él: topics, books, schedule, evaluations)
  ├─ Pregunta: year, cycle, first_monday
  ├─ Crea nueva lecture_instance en DB
  ├─ Crea directorios y symlinks
  └─ Escribe config.yaml
```

---

## Nueva dependencia en pyproject.toml

```toml
dependencies = ["appdirs", "bibtexparser", "click", "pyyaml", "sqlalchemy"]
```

## DB location

```python
from appdirs import user_data_dir
DB_PATH = Path(user_data_dir("itep")) / "itep.db"
```

## Archivos a modificar/crear

| Archivo | Acción |
|---------|--------|
| `src/itep/database.py` | Reescribir: Django → SQLAlchemy models + engine/session setup |
| `src/itep/structure.py` | Retirar dataclasses reemplazados por SQLAlchemy. Mantener enums y ConfigData |
| `src/itep/ioconfig.py` | Simplificar: config.yaml = puntero a project_id |
| `src/itep/create.py` | Adaptar: escribir a DB en vez de construir ProjectStructure |
| `src/itep/links.py` | Adaptar: leer de DB en vez de config.yaml |
| `src/itep/manager.py` | Implementar: CRUD sobre la DB |
| `src/itep/models.py` | Mantener: templates de filesystem |
| `src/itep/defaults.py` | Agregar DB_PATH |
| `pyproject.toml` | Agregar sqlalchemy a dependencies |
| `tests/` | Nuevos tests para modelos SQLAlchemy y operaciones CRUD |

## Verificación

1. Crear la DB con `Base.metadata.create_all(engine)` y verificar que las tablas se crean
2. Seed de datos de referencia (institutions, main_topics)
3. CRUD: crear Course, crear lecture_instance, crear general_project, consultar relaciones
4. `inittex`: crear un proyecto lecture y verificar que la DB y el filesystem son consistentes
5. `relink`: reconstruir symlinks desde la DB
6. Test de clonación: clonar un lecture_instance a nuevo ciclo
