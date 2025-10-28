return {
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        config = function()
            local lint = require("lint")
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            ---------------
            ---LINTERS---
            ---------------
            lint.linters_by_ft = {
                bash = { "bash" },
                -- css = { "stylelint" },
                go = { "gopls" },
                html = { "eslint_d" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                -- scss = { "stylelint" },
                typescript = { "eslint_d" },
                vue = { "eslint_d", "stylelint" },
            }

            ---------------
            ---LUA CHECK---
            ---------------
            lint.linters.luacheck.cmd = "luacheck"
            lint.linters.luacheck.args = { "--globals", "vim" }

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- print("Configured linter for filetype: ", vim.inspect(lint.linters_by_ft[vim.bo.filetype]))
                    -- print("Running stylelint for (filepath):", vim.fn.expand("%:p"))

                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<space>li", function()
                require("lint").try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
