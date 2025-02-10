return {
    {
        "nvim-tree/nvim-tree.lua",
        enabled = true,
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local api = require("nvim-tree.api")

            -- Disable netrw (nvim built in file explorer)
            -- vim.g.loaded_netrw = 1
            -- vim.g.loaded_netrwPlugin = 1

            -- Optionally enabled 24-bit colour
            vim.opt.termguicolors = true

            vim.keymap.set("n", "<space>e", api.tree.toggle)
            vim.keymap.set("n", "<space>fe", api.tree.focus)

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                view = {
                    width = 40,
                },
            })
        end,
    },
}
