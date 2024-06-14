# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import os
import subprocess
# from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key
from libqtile.config import Match, Screen
from libqtile.lazy import lazy
# from libqtile.utils import guess_terminal

# elParaguayo
# from brightnesscontrol import BrightnessControl
# bc = BrightnessControl()


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

# @hook.subscribe.startup
# def dbus_register():
#     id = os.environ.get('DESKTOP_AUTOSTART_ID')
#     if not id:
#         return
#     subprocess.Popen(['dbus-send',
#                       '--session',
#                       '--print-reply',
#                       '--dest=org.gnome.SessionManager',
#                       '/org/gnome/SessionManager',
#                       'org.gnome.SessionManager.RegisterClient',
#                       'string:qtile',
#                       'string:' + id])


mod = "mod4"
fn = "XF86ModeLock"
# terminal = guess_terminal()
terminal = "alacritty"
myBrowser = "firefox"
myFileBrowser = "nautilus"
edge = "microsoft-edge-stable"

# NORD      NORMAL    BRIGHT   DIM
nordColor = {
    'black':            '#3b4252',
    'bright_black':     '#4c566a',
    'dim_black':        '#373e4d',
    'red':              '#bf615a',
    'bright_red':       '#bf616a',
    'dim_red':          '#94545d',
    'green':            '#a3be8c',
    'bright_green':     '#a3be8c',
    'dim_green':        '#809575',
    'yellow':           '#ebcb8b',
    'bright_yellow':    '#ebcb8b',
    'dim_yellow':       '#b29e75',
    'blue':             '#81a1c1',
    'bright_blue':      '#81a1c1',
    'dim_blue':         '#68809a',
    'magenta':          '#b48ead',
    'bright_magenta':   '#b48ead',
    'dim_magenta':      '#8c738c',
    'cyan':             '#88c0d0',
    'bright_cyan':      '#8fbcbb',
    'dim_cyan':         '#6d96a5',
    'white':            '#e5e9f0',
    'bright_white':     '#eceff4',
    'dim_white':        '#aeb3bb',
}

keys = [
    Key([mod], "s",
        lazy.spawn("spotify-launcher"),
        desc="spotify for linux"
        ),
    Key([mod], "j",
        lazy.spawn("alacritty -e 'java -jar ~/Downloads/firmador.jar'"),
        desc="Firmador digital"
        ),
    Key([mod], "d",
        lazy.spawn("evince"),
        desc="PDF Reader"
        ),
    Key([mod], "i",
        lazy.spawn("inkscape"),
        desc="Inkscape"
        ),
    Key([mod], "b",
        lazy.spawn(myBrowser),
        desc="Firefox"
        ),
    Key([mod], "f",
        lazy.spawn(myFileBrowser),
        desc="GUI file browser"
        ),
    Key([mod, "shift"], "c",
        lazy.spawn("firefox https://calendar.google.com"),
        desc="Calendar"
        ),
    Key([mod], "p",
        lazy.spawn("alacritty -e 'python'"),
        desc="python"
        ),
    Key([mod], "e",
        lazy.spawn(edge),
        desc="GUI file browser"
        ),
    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
        ),
    # A list of available commands that can be bound to keys can be found
    # at  https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc="Move focus down"
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc="Move focus up"
        ),
    Key([mod], "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
        ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
        ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        desc="Grow window up"
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
        ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
        ),
    Key([mod], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
        ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    Key([mod], "c",
        lazy.spawn("loffice --calc"),
        desc="open libre office calc"
        ),
    Key([mod], "w",
        lazy.spawn("loffice --writer"),
        desc="open libre office writer"
        ),
    Key([mod], "z",
        lazy.spawn("zotero"),
        desc="open zotero"
        ),
    Key([], "Print",
        lazy.spawn("gnome-screenshot"),
        desc="Save screenshot to Pictures"
        ),
    Key([mod], "Print",
        lazy.spawn("gnome-screenshot -acf /tmp/test && cat /tmp/test | xclip -i -selection clipboard -target image/png"),
        desc="Save screenshot to clipboard"
        ),
    Key(["control"], "Print",
        lazy.spawn("gnome-screenshot -a"),
        desc="Save screenshot to Pictures"
        ),
    Key([mod, "control"], "Print",
        lazy.spawn("gnome-screenshot -i"),
        desc="Save screenshot to Pictures"
        ),
    Key([mod], "q",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([mod, "control"], "r",
        lazy.reload_config(),
        desc="Reload the config"
        ),
    Key([mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
        ),
    Key([mod], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc="Restart Qtile"
        ),
    Key([mod], "0",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout."
        ),
    Key([], "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s +5%")
        # lazy.function(bc.brightness_up)
        ),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 5%-")
        # lazy.function(bc.brightness_down)
        ),
    Key([], "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle")
        ),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("amixer -q set Master 5%-")
        ),
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -q set Master 5%+")
        ),
    Key([mod, "shift"], "o",
        lazy.spawn("xrandr --output HDMI-1 --off")
        ),
    Key([mod, "control"], "o",
        lazy.spawn("xrandr --output HDMI-1 --mode 1024x768 --right-of eDP-1"),
        lazy.spawn("nitrogen --restore"),
        desc="Set new monitor"
        ),
    Key([mod], "o",
        lazy.spawn("xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1"),
        lazy.spawn("nitrogen --restore"),
        desc="Set new monitor"
        ),
    Key([mod, "shift"], "r",
        lazy.spawn("nitrogen --restore")
        )
]

groups = [
    Group(i) for i in "123456789"
]


for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}"
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            Key([mod, "control"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )

groups.append(
    ScratchPad(
        'scratchpad', [
            DropDown('yad', terminal + ' -e yad --calendar'),
            DropDown('zen', terminal + ' -e zenity --calendar'),
            DropDown('cal', "gnome-calendar")
        ]
    )
)

layouts_theme = {
        "border_width": 2,
        "margin": 5,
        "border_focus": nordColor["red"],
        "border_normal": nordColor["dim_blue"]
        # "border_focus": "e1acff",
        # "border_normal": "1D2330"
    }

layouts = [
    layout.Columns(**layouts_theme),
    layout.Max(**layouts_theme),
    layout.MonadTall(**layouts_theme),
    # Try more layouts by unleashing below layouts.
    layout.Stack(num_stacks=2),
    layout.Bsp(),
    layout.Matrix(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    layout.VerticalTile(),
    layout.Zoomy(),
]

widget_defaults = dict(
    font="inconsolata nerd font",
    foreground=nordColor["dim_black"],
    fontsize=20,
    padding=6,
    )


extension_defaults = widget_defaults.copy()


def setBatteryIcon():
    icon = {
        "10": "",
        "20": "",
        "30": "",
        "40": "",
        "50": "",
        "60": "",
        "70": "",
        "80": "",
        "90": "",
        "100": "",
    }
    perc = 0.53
    option = str( int( perc * 100 - perc * 100 % 10 + 10 ) )
    str = icon[option]
    return str


CLI = widget.CurrentLayoutIcon()


GB = widget.GroupBox(
    disable_drag = True,
    inactive = nordColor["dim_cyan"],
    active = nordColor["white"],
    highlight_method = "block", # 'border', 'block', 'text', or 'line'
    # highlight_color = ['000000', nordColor["red"]],
    other_current_screen_border = nordColor["bright_green"],
    other_screen_border = nordColor["dim_green"],
    this_current_screen_border = nordColor["bright_blue"],
    this_screen_border = nordColor["dim_blue"],
)


GB2 = widget.GroupBox(
    disable_drag=True,
    inactive=nordColor["dim_cyan"],
    active=nordColor["white"],
    highlight_method="block",  # 'border', 'block', 'text', or 'line'
    # highlight_color = ['000000', nordColor["red"]],
    other_current_screen_border=nordColor["bright_green"],
    other_screen_border=nordColor["dim_green"],
    this_current_screen_border=nordColor["bright_blue"],
    this_screen_border=nordColor["dim_blue"],
)


prompt = widget.Prompt()
#             padding = -600,
#         ),


KBly = widget.KeyboardLayout(
            background = nordColor["red"],
            # foreground = nordColor["white"],
            # fmt = 'Keyboard: {}',
            padding = 5,
            option = None,
            display_map = {"latam":"ES","us intl":"US"},
            configured_keyboards = ["latam","us intl"]
        )


clock = widget.Clock(
            format="%d/%m %a %I:%M",
            background = nordColor["bright_yellow"],
            mouse_callbacks={"Button1": lazy.group['scratchpad'].dropdown_toggle('zen')},
        )


netW = widget.Net(
            # format="{interface}:{down}↓↑{up}",
            format="{down:.2e}↓",
            # foreground=nordColor["white"],
            background=nordColor["green"],
        )


MemG = widget.MemoryGraph(
            background=nordColor["green"],
            type='line',
            line_width=2,
            margin_x=0,
            margin_y=0,
            border_width=1,
            frequency=0.1,
            graph_color=nordColor["magenta"]
        )


bat = widget.Battery(
            background = nordColor["magenta"],
            # foreground = nordColor["white"],
            empty_char="",
            discharge_char="",
            charge_char="",
            full_char="",
            unknown_char="",
            low_foreground=nordColor["red"],
            low_percentage=0.2,
            format="{percent:2.0%}{char}",
        )


quickE = widget.QuickExit(
            background=nordColor["bright_black"],
            default_text="⏻",
            countdown_format="{}s",
            padding=7
        )


WdwName = widget.WindowName(
            empty_group_string="                               ",
            width=300,
            markup=False,
            # padding = 300,
            scroll=True,
        )


sysTray = widget.Systray(
            background=nordColor["blue"],
        )


mySpace = widget.Sep(
    padding=520,
    linewidth=0
)


screens = [
    Screen(
        top=bar.Bar(
            widgets=[
                CLI,
                GB,
                prompt,
                mySpace,
                KBly,
                clock,
                netW,
                MemG,
                sysTray,
                bat,
                quickE
                ],
            size=22,
            opacity=0.95,
            background=nordColor["black"]
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=[
                CLI,
                GB2,
                KBly,
                clock,
                netW,
                MemG,
                bat,
                quickE,
                prompt
                ],
            size=22,
            opacity=0.95,
            background=nordColor["black"]
        ),
    )
]


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()
         ),
    Drag([mod], "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()
         ),
    Click([mod], "Button2",
          lazy.window.bring_to_front()
          ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
