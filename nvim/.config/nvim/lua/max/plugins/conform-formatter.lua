return {
    "stevearc/conform.nvim",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local conform = require("conform")

        -- Function to find Prettier
        local function find_prettier()
            local prettier_path = vim.fn.system("which prettier"):gsub("\n", "")
            if vim.fn.executable(prettier_path) == 1 then
                return prettier_path
            else
                return nil
            end
        end

        -- Function to find Prettier Svelte plugin
        local function find_svelte_plugin()
            local possible_paths = {
                vim.fn.expand(
                    "~/.npm-global/lib/node_modules/prettier-plugin-svelte"),
                vim.fn
                    .expand(
                    "~/.local/share/npm/lib/node_modules/prettier-plugin-svelte"),
                "/usr/local/lib/node_modules/prettier-plugin-svelte"
            }
            for _, path in ipairs(possible_paths) do
                if vim.fn.filereadable(path) == 1 then
                    return path
                end
            end
            return nil
        end

        local prettier_path = find_prettier()
        local svelte_plugin_path = find_svelte_plugin()

        conform.setup({
            formatters = {
                svelte_fmt = {
                    command = prettier_path,
                    args = function(ctx)
                        local args = {"--stdin-filepath", "$FILENAME"}
                        if svelte_plugin_path then
                            table.insert(args, 1, svelte_plugin_path)
                            table.insert(args, 1, "--plugin")
                        end
                        return args
                    end,
                    stdin = true
                },
                latex_fmt = {
                    command = "latexindent-linux",
                    args = {"-w", "$FILENAME"},
                    stdin = false
                }
            },
            formatters_by_ft = {
                javascript = {"prettier"},
                typescript = {"prettier"},
                javascriptreact = {"prettier"},
                typescriptreact = {"prettier"},
                css = {"prettier"},
                html = {"prettier"},
                json = {"prettier"},
                yaml = {"prettier"},
                markdown = {"prettier"},
                python = {"ruff_fix", "ruff_format", "ruff_organize_imports"},
                svelte = {"svelte_fmt"},
                latex = {"latex_fmt"},
                tex = {"latex_fmt"},
                lua = {"lua-format"}
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000
            }
        })

        vim.keymap.set({"n", "v"}, "<leader>ff", function()
            conform.format(
                {lsp_fallback = true, async = false, timeout_ms = 1000})
        end, {desc = "Format file or range (in visual mode)"})
    end
}
