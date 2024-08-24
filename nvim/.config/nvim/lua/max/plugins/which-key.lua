return {
    {
        "folke/which-key.nvim",
        dependencies = {'echasnovski/mini.icons'},
        event = "VeryLazy",
        opts = {
            plugins = {
                marks = true,
                registers = true,
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true
                }
            },
            window = { -- Changed from 'win' to 'window'
                border = "single",
                position = "bottom",
                margin = {1, 0, 1, 0},
                padding = {1, 2, 1, 2},
                winblend = 0
            },
            layout = {
                height = {min = 4, max = 25},
                width = {min = 20, max = 50},
                spacing = 3,
                align = "center"
            }
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.add({
                {"<leader>t", group = "telescope"},
                {"<leader>c", group = "code"},
                {"<leader>f", group = "formatting"},
                {"<leader>g", group = "git"},
                {"<leader>gh", desc = 'git hunk actions'},
                {"<leader>gf", desc = 'git file actions'},
                {"<leader>gb", desc = 'git blame'}
            })
        end
    }
}
