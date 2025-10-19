return {
    {
        "folke/persistence.nvim",
        config = function()
            local persistence = require("persistence")

            persistence.setup({
                dir = vim.fn.stdpath("state") .. "/sessions/",
                options = { "buffers", "curdir", "tabpages", "winsize" },
            })

            -- load the session for the current directory
            vim.api.nvim_create_user_command("SessionLoadFromCWD", persistence.load, {})

            -- select a session to load
            vim.api.nvim_create_user_command("SessionSelect", persistence.select, {})

            -- load the last session
            vim.api.nvim_create_user_command("SessionLoadLast", function()
                persistence.load({ last = true })
            end, {})

            -- stop Persistence => session won't be saved on exit
            vim.api.nvim_create_user_command("SessionStop", persistence.stop, {})
        end,
    },
}
