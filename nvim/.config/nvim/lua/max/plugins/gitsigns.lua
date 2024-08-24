return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs = {
                add = {text = "+"},
                change = {text = "*"},
                delete = {text = "-"},
                topdelete = {text = "‾"},
                changedelete = {text = "~"},
                untracked = {text = "<"}
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {interval = 1000, follow_files = true},
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>ghs', gitsigns.stage_hunk,
                    {desc = 'Stage hunk'})
                map('n', '<leader>ghr', gitsigns.reset_hunk,
                    {desc = 'Reset hunk'})
                map('n', '<leader>ghu', gitsigns.undo_stage_hunk,
                    {desc = 'Undo stage hunk'})
                map('n', '<leader>ghv', gitsigns.preview_hunk,
                    {desc = 'Preview hunk'})
                map('n', '<leader>ghv', gitsigns.next_hunk, {desc = 'Next hunk'})
                map('n', '<leader>ghp', gitsigns.prev_hunk,
                    {desc = 'Previous hunk'})
                map('n', '<leader>gfs', gitsigns.stage_buffer,
                    {desc = 'Stage buffer'})
                map('n', '<leader>gfr', gitsigns.reset_buffer,
                    {desc = 'Reset buffer'})
                map('n', '<leader>gba',
                    function() gitsigns.blame_line {full = true} end,
                    {desc = 'Blame line'})
                map('n', '<leader>gbl', gitsigns.toggle_current_line_blame,
                    {desc = 'Toggle blame line'})
            end
        })
    end
}
