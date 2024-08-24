return {
    {
        'tpope/vim-fugitive',
        config = function()
            local keymap = vim.keymap
            keymap.set("n", "<leader>gc", ":Git commit | startinsert<CR>",
                       {desc = "Git commit"})
        end
    }
}
