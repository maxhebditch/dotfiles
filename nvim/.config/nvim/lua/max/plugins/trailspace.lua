return {
    {
        "echasnovski/mini.trailspace",
        version = false,
        config = function()
            require('mini.trailspace').setup({
                -- Highlight group for trailing whitespace
                highlight = {group = "ErrorMsg"}
            })

            -- Set up custom highlight
            vim.api.nvim_set_hl(0, "MiniTrailspace", {bg = "#DF8E1D"})

            -- Add keymap for MiniTrailspace.trim()
            vim.keymap.set('n', '<leader>fw',
                           function()
                require('mini.trailspace').trim()
            end, {desc = "Trim trailing whitespace"})
        end
    }
}
