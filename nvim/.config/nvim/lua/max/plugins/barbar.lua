return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            auto_hide = 1,
            icons = {
                filetype = {enabled = false},
                -- Disable buffer icons
                buffer_index = false,
                buffer_number = false,
                button = false,
                -- Disable separator icons
                separator = {left = '', right = ''}
            }
        },

        config = function(_, opts)
            require('barbar').setup(opts)

            local highlight_groups = {
                BufferCurrent = {bg = "#e6e9ef", fg = "#4c4f69"},
                BufferCurrentIndex = {bg = "#e6e9ef", fg = "#1e66f5"},
                BufferCurrentMod = {bg = "#e6e9ef", fg = "#df8e1d"},
                BufferCurrentSign = {bg = "#e6e9ef", fg = "#1e66f5"},
                BufferCurrentTarget = {bg = "#e6e9ef", fg = "#d20f39"},

                BufferVisible = {bg = "#e6e9ef", fg = "#4c4f69"},
                BufferVisibleIndex = {bg = "#e6e9ef", fg = "#1e66f5"},
                BufferVisibleMod = {bg = "#e6e9ef", fg = "#df8e1d"},
                BufferVisibleSign = {bg = "#e6e9ef", fg = "#1e66f5"},
                BufferVisibleTarget = {bg = "#e6e9ef", fg = "#d20f39"},

                BufferInactive = {bg = "#bcc0cc", fg = "#9ca0b0"},
                BufferInactiveIndex = {bg = "#bcc0cc", fg = "#9ca0b0"},
                BufferInactiveMod = {bg = "#bcc0cc", fg = "#df8e1d"},
                BufferInactiveSign = {bg = "#bcc0cc", fg = "#1e66f5"},
                BufferInactiveTarget = {bg = "#bcc0cc", fg = "#d20f39"},
                BufferTabpages = {bg = "#bcc0cc", fg = "#bcc0cc"},
                BufferTabpage = {bg = "#bcc0cc", fg = "#1e66f5"}
            }

            for group, colors in pairs(highlight_groups) do
                vim.api.nvim_set_hl(0, group, colors)
            end

            -- Debugging: Print all highlight groups and their settings
            vim.api.nvim_create_user_command('DebugBarbarHighlights',
                                             function()
                for group, _ in pairs(highlight_groups) do
                    local hl = vim.api.nvim_get_hl(0, {name = group})
                    print(group .. ': ' .. vim.inspect(hl))
                end
            end, {})
        end
    }
}
