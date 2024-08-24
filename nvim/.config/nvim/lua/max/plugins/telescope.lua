return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {"natecraddock/telescope-zf-native.nvim", build = "make"}
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            extensions = {
                ["zf-native"] = {
                    file = {
                        enable = true,
                        highlight_results = true,
                        match_filename = true
                    }
                }
            }
        })

        -- Load the zf-native extension
        telescope.load_extension("zf-native")

        -- set keymaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>",
                   {desc = "Fuzzy find_files in cwd"})
        keymap.set("n", "<leader>tg", "<cmd>Telescope git_files<cr>",
                   {desc = "Fuzzy find git_files"})
        keymap.set("n", "<leader>tr", "<cmd>Telescope live_grep<cr>",
                   {desc = "Fuzzy live_grep in files"})
        keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>",
                   {desc = "Fuzzy find open buffers"})
        keymap.set("n", "<leader>td", "<cmd>Telescope file_browser<cr>",
                   {desc = "Fuzzy file_browser"})
    end
}
