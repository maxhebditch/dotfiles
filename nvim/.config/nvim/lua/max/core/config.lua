local global = vim.g
local vo = vim.opt

-- Editor options
-- -- Mouse Support
vo.mouse = "a"
-- -- uses the clipboard register for all operations except yank.
vo.clipboard = "unnamedplus"
-- -- Don't use opt file
vo.swapfile = false
-- Sets the character encoding used inside Vim.
vo.encoding = "UTF-8"

-- Appearance
-- -- Show line numbers
vo.number = true
-- -- Add a cursor line
vo.cursorline = true
-- -- Show syntax highlighting
vo.syntax = "on"
-- -- Show the line and column number of the cursor position, separated by a comma.
vo.ruler = true
-- -- When on, the title of the window will be set to the value of 'titlestring'
vo.title = true
-- -- Term gui colors
vo.termguicolors = true

-- Behaviour
-- -- Autocomplete option
vo.completeopt = 'menuone,noinsert,noselect'
-- -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
vo.wildmenu = true

-- -- Copy indent from current line when starting a new line.
vo.autoindent = true
-- -- Smart indent
vo.smartindent = true
-- -- Number of spaces to use for each step of (auto)indent.
vo.shiftwidth = 4
-- -- Number of spaces that a <Tab> in the file counts for.
vo.tabstop = 4

-- -- When on a buffer becomes hidden when it is |abandon|ed
vo.hidden = true
-- -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
vo.ttimeoutlen = 0
-- -- When a bracket is inserted, briefly jump to the matching one.
vo.showmatch = true
-- -- Wrap on word boundary
vo.linebreak = true
-- -- When nonempty, shows the effects 
vo.inccommand = "split"

-- -- Faster scrolling
vo.lazyredraw = true
-- -- Disable login screen
vo.shortmess:append "sI"

-- keys
-- -- set leader
global.mapleader = " "

-- -- keyboard mappings
-- -- -- Compile LaTeX
vim.api.nvim_set_keymap('n', '<leader>cl', ':lua CompileLatex()<CR>',
                        {noremap = true, silent = true, desc = "Compile Latex"})

function CompileLatex()
    local filename = vim.fn.expand('%')
    local command = 'tectonic ' .. filename

    local output = vim.fn.system(command)
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
        print("LaTeX compilation successful")
    else
        print("LaTeX compilation failed")
        print(output)
    end
end
