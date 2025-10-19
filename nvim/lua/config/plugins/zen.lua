return {
    "folke/zen-mode.nvim",
    dependencies = "folke/twilight.nvim",
    opts = {
        window = {
            width = 90,
            options = {
                cursorcolumn = true,
                relativenumber = true,
            },
        },
        plugins = {
            twilight = {
                enabled = true,
            },
        },
    },
    config = function()
        local zen = require("zen-mode")

        vim.keymap.set("n", "<leader>z", zen.toggle, { desc = "Toggle :ZenMode" })
    end,
}
