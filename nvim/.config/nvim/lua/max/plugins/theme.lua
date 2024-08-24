return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "latte", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha"
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                barbar = true,
                markdown = true,
                rainbow_delimiters = true,
                which_key = true,
                mini = {enabled = true, indentscope_color = ""}
            },
            transparent_background = false,
            show_end_of_buffer = false, -- show the '~' characters after the end of buffers
            term_colors = false,
            styles = {
                comments = {"italic"},
                conditionals = {"italic"},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {}
            },
            color_overrides = {latte = {surface1 = '#bcc0cc'}},
            custom_highlights = function(colors)
                return {
                    LineNr = {fg = colors.overlay1},
                    CursorLineNr = {fg = colors.text, style = {"bold"}},
                    Structure = {fg = colors.overlay1},
                    String = {fg = colors.pink, style = {"bold", "italic"}},
                    Constant = {fg = colors.lavender},
                    Function = {style = {"bold"}},
                    Statement = {style = {"bold"}},
                    Identifier = {style = {"bold"}}
                }
            end
        })

        -- setup must be called before loading
        vim.cmd("colorscheme catppuccin")
    end
}
