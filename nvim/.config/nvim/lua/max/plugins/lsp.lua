return {
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end
    }, {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", -- Python
                    "svelte", -- Svelte
                    "tsserver", -- JavaScript and TypeScript
                    "bashls", -- Bash
                    "tailwindcss", -- Tailwind CSS
                    "cssls", -- CSS
                    "jsonls" -- JSON
                }
            })
        end
    }, {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Python
            lspconfig.pyright.setup({capabilities = capabilities})

            -- Svelte
            lspconfig.svelte.setup({capabilities = capabilities})

            -- JavaScript and TypeScript
            lspconfig.tsserver.setup({capabilities = capabilities})

            -- Bash
            lspconfig.bashls.setup({capabilities = capabilities})

            -- Tailwind CSS
            lspconfig.tailwindcss.setup({capabilities = capabilities})

            -- CSS
            lspconfig.cssls.setup({capabilities = capabilities})

            -- JSON
            lspconfig.jsonls.setup({capabilities = capabilities})

            -- Global mappings
            vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                           {desc = "Show hover information"})
            vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition,
                           {desc = "Go to definition"})
            vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation,
                           {desc = "Go to implementation"})
            vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references,
                           {desc = "Show references"})
            vim.keymap.set('n', '<leader>cs', vim.lsp.buf.rename,
                           {desc = "Rename symbol"})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
                           {desc = "Show code actions"})
            vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float,
                           {desc = "Show line diagnostics"})
        end
    }, {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                }),
                sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
            })
        end
    }
}
