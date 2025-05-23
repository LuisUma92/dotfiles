vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("i", "<C-e>", "<Esc>")

-- Personal remaps
vim.keymap.set("n","<C-b>", ":b#<CR>")
vim.keymap.set("n", "<leader>ws", ":w<CR>:so<CR>", {desc = "save and source"})
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", {desc = "save from insert mode"})

-- Primeagen: move selected 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")
-- cursor at center
vim.keymap.set("n","<C-j>","<C-d>zz")
vim.keymap.set("n","<C-k>","<C-u>zz")
vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","Nzzzv")
-- paste without loosing what it pasted
vim.keymap.set("x", "<leader>p", "\"_dP")
-- copy into system
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
-- replace the word where you where
vim.keymap.set("n", "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
  )

-- Telescope remaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs',
  function()
    builtin.grep_string({search = vim.fn.input("Grep > ")})
  end)

-- dwnzed buffers remaps
vim.keymap.set('n', '<leader>bD', function() closeAllBuffers() end, { desc = '[B]uffer [D]elete all but current' })

vim.keymap.set('n', '<leader>bd', ':bdelete<cr>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = '[B]uffer [P]revious' })

-- LuaSnips
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-i>",
  function() ls.expand() end, {silent = true}
  )
vim.keymap.set({"i", "s"}, "<S-Tab>",
  function() ls.jump( 1) end, {silent = true}
  )
vim.keymap.set({"i", "s"}, "<C-Tab>",
  function() ls.jump(-1) end, {silent = true}
  )
-- vim.keymap.set({"i", "s"}, "<M-Tab>", function()
-- 	if ls.choice_active() then
--     s.change_choice(1)
-- 	end
-- end, {silent = true})

-- Harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>",
  function()
    toggle_telescope(harpoon:list())
  end,
  { desc = "Open harpoon window" })
--vim.keymap.set("n", "<C-e>",
--   function() 
--     harpoon.ui:toggle_quick_menu(harpoon:list())
--   end)

vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-u>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<M-n>", function() harpoon:list():next() end)

-- Remove file from harpoon list
-- vim


-- Undo tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Git: tpope/fugitive
vim.keymap.set('n', '<leader>gl', vim.cmd.Git)


-- Castle inkscape
vim.keymap.set("i", "<C-f>", function ()
  local current_line_number = vim.fn.line('.')
  local current_line = vim.fn.getline('.')
  local root_directory = vim.b.vimtex.root

  local command = string.format(
    "inkscape-figures create \"%s\" \"%s/figures\"",
    current_line,
    root_directory
  )

  local output = vim.fn.systemlist(command)
  local output_line_count = #output

  -- Replace the current line with the first line of the output
  vim.fn.setline(current_line_number, output[1])

  -- Insert the remaining lines of the output below the current line
  for i =2,  #output do
    vim.fn.append(current_line_number + i -2, output[i])
  end
  vim.fn.cursor(current_line_number + output_line_count, 0)
  vim.api.nvim_command('write')
  end,
  {silent = true}
)
vim.keymap.set("n", "<C-f>", function ()
  local root_directory = vim.b.vimtex.root
  local command = string.format(
    "inkscape-figures edit \"%s/figures/\"", -- > /dev/null 2>&1 &",
    root_directory
  )

  vim.fn.system(command)
  vim.cmd('redraw!')
   end,
  {silent = true}
)
-- Nori insert 
vim.keymap.set("i", "<C-p>",
  function ()
    local root_directory = vim.b.vimtex_root
    local command =  string.format(
      "silent exec '!nori insert \"%s\"/res/'",
      root_directory
    )
    vim.api.nvim_command(command)
    vim.cmd('redraw!')
  end,
  {silent = true}
)

-- Define a function to execute the command with the current highlighted line in netrw
function OpenWithZathura()
  -- Get the current line under the cursor
  local line_number = vim.fn.line('.')

  -- Construct the command with the current line number
  local command = string.format(":!zathura %d", line_number)
  -- Execute the command
  vim.cmd(command)
end


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- \(\SI{1.35}{cm}\)
-- \(\SI{1.35}{m/s}\)
-- \(\SI{135}{m/s}\)
-- \(\SI{2.45}{m/2}\)

-- Define a function to wrap selected text with \(\SI{...}{...}\)
function WrapSelectedTextWithMath(SI)
  -- Get the visual selection range
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  -- Get the selected text
  local selected_text = vim.api.nvim_buf_get_text(
      0,
      start_pos[2]-1,
      start_pos[3]-1,
      end_pos[2]-1,
      end_pos[3],
      {})
  local text_before = vim.api.nvim_buf_get_text(
      0,
      start_pos[2]-1,
      0,
      start_pos[2]-1,
      start_pos[3]-1,
      {})
  local text_after = vim.api.nvim_buf_get_text(
      0,
      end_pos[2]-1,
      end_pos[3],
      end_pos[2]-1,
      -1,
      {})

  local words = {}
  local i = 1

  for word in string.gmatch(selected_text[1], "(%w+)") do
    words[i] = word
    i = i + 1
  end

  if i == 4 then
    if string.find(words[2], "%a") == nil then
      words[1] = words[1] .. "." .. words[2]
      words[2] = words[3]
    else
      words[2] = words[2] .. "/" .. words[3]
    end
  elseif i == 5 then
    words[1] = words[1] .. "." .. words[2]
    words[2] = words[3] .. "/" .. words[4]
  end
  -- Replace the selected text with \(\SI{...}{...}\)
  local wrapped_text
  if SI == true then
    wrapped_text = text_before[1] .. "\\(\\SI{" .. words[1] .. "}{" .. words[2] .."}\\)" .. text_after[1]
  else 
    wrapped_text = text_before[1] .. "\\(" .. selected_text[1] .."\\)" .. text_after[1]
  end 
  -- local end_col = math.min(end_pos[3], #selected_text[#selected_text] + 1)
  -- Replace the selected text with the wrapped text
  vim.api.nvim_buf_set_text(0, start_pos[2] - 1, 0, end_pos[2], 0, {})
  
  local end_col =  #wrapped_text
  -- vim.api.nvim_buf_set_text(
  vim.api.nvim_buf_set_lines(
  0,
  start_pos[2]-1,
  -- 0,
  start_pos[2]-1,
  -- end_col,
  false,
  {wrapped_text}
  )
  -- Adjust the cursor position
  -- vim.fn.cursor(start_pos[2], start_pos[3] + 5)
end

-- Define the key mapping for the function
vim.keymap.set('v', '<leader>i', ':lua WrapSelectedTextWithMath(true)<CR>')
vim.keymap.set('v', '<leader>m', ':lua WrapSelectedTextWithMath(false)<CR>')

-- Define the key mapping
vim.api.nvim_set_keymap('n', '<leader>z', ':lua OpenWithZathura()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>c', function ()
  local line = vim.api.nvim_get_current_line()
  local filename = line:match("{(.-)}")
  if filename then
    local file = io.open(filename, "w")
    if file then
      file:close()
      print("Created file: " .. filename)
    else
      print("Error: Could not create file")
    end
  else
    print("No text found inside")
  end
end
)
