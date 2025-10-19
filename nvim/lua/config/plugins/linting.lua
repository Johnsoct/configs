return {
    {
        "mfussenegger/nvim-lint",
        enabled = false,
        config = function()
            local lint = require("lint")
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            ---------------
            ---LINTERS---
            ---------------
            lint.linters_by_ft = {
                bash = { "bash" },
                css = { "stylelint" },
                go = { "gopls" },
                html = { "eslint_d" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                scss = { "stylelint" },
                typescript = { "eslint_d" },
                vue = { "eslint_d", "stylelint" },
            }

            -- vim.env.ESLINT_D_PPID = vim.fn.getpid()

            ---------------
            --- ESLINT ---
            ---------------
            -- lint.linters.eslint = {
            --     cmd = "eslint_d",
            --     stdin = true,
            --     args = { "--stdin", "--stdin-filename", "%filepath" },
            --     ignore_exitcode = true,
            --     parser = require("lint.parser").from_errorformat(
            --         "%f: line %l, col %c, %trror - %m",
            --         { source = "eslint_d", severity = vim.diagnostic.severity.ERROR }
            --     ),
            -- }

            ---------------
            ---LUA CHECK---
            ---------------
            lint.linters.luacheck.cmd = "luacheck"
            lint.linters.luacheck.args = { "--globals", "vim" }

            ---------------
            ---STYLELINT---
            ---------------
            -- lint.linters.stylelint = {
            --     -- cmd = "npx",
            --     cmd = "stylelint",
            --     stdin = true,
            --     args = { "--stdin", "--stdin-filename", "%filepath", "--formatter", "json" },
            --     ignore_exitcode = true,
            --     parser = require("lint.parser").from_errorformat(
            --         "%f: line %l, col %c, %m",
            --         { source = "stylelint", severity = vim.diagnostic.severity.WARN }
            --     ),
            -- }

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- print("Configured linter for filetype: ", vim.inspect(lint.linters_by_ft[vim.bo.filetype]))
                    -- print("Running stylelint for (filepath):", vim.fn.expand("%:p"))

                    require("lint").try_lint()
                end,
            })

            vim.keymap.set("n", "<space>li", function()
                require("lint").try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
