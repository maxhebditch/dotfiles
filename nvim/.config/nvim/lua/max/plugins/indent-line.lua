return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│" -- Thinner character for indent lines
            },
            scope = {enabled = true}
        },
        config = function(_, opts)
            local highlight = {
                "RainbowCyan", "RainbowRed", "RainbowYellow", "RainbowBlue",
                "RainbowOrange", "RainbowGreen", "RainbowViolet"
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowCyan",
                                    {fg = "#179299", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowRed",
                                    {fg = "#dc8a78", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowYellow",
                                    {fg = "#df8e1d", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowBlue",
                                    {fg = "#7287fd", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowOrange",
                                    {fg = "#fe640b", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowGreen",
                                    {fg = "#40a02b", blend = 90})
                vim.api.nvim_set_hl(0, "RainbowViolet",
                                    {fg = "#8839ef", blend = 90})
            end)
            require("ibl").setup(vim.tbl_deep_extend("force", opts, {
                indent = {highlight = highlight}
            }))
        end
    }
}
