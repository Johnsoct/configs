return {
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        config = function()
            local lint = require("lint")
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.env.ESLINT_D_PPID = vim.fn.getpid()

            lint.linters_by_ft = {
                bash = { "bash" },
                css = { "stylelint" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                scss = { "stylelint" },
                typescript = { "eslint_d" },
                vue = { "eslint_d" },
            }

            ---------------
            ---LUA CHECK---
            ---------------
            lint.linters.luacheck.cmd = "luacheck"
            lint.linters.luacheck.args = { "--globals", "vim" }

            ---------------
            ---STYLELINT---
            ---------------
            lint.linters.stylelint.cmd = "stylelint"
            lint.linters.stylelint.stdin = false
            lint.linters.stylelint.args = { "--formatter", "json" }
            lint.linters.stylelint.stream = "both"
            lint.linters.stylelint.ignore_exitcode = true

            -- Testing stylelint and parsed outputs
            -- local stylelintOutput = vim.fn.system("stylelint --formatter json " .. vim.fn.expand("%:p"))
            -- print("Raw stylelint output:", stylelintOutput)
            -- local stylelintParsed = vim.fn.json_decode(stylelintOutput)
            -- print("Parsed JSON:", vim.inspect(stylelintParsed))

            lint.linters.stylelint.parser = function(output, bufnr)
                local decoded = vim.fn.json_decode(output)
                local diagnostics = {}

                for _, file in ipairs(decoded) do
                    for _, warning in ipairs(file.warnings or {}) do
                        table.insert(diagnostics, {
                            lnum = warning.line - 1,                          -- Neovim diagnostics use 0-based line numbers
                            col = warning.column and warning.column - 1 or 0, -- 0-based columns
                            end_lnum = warning.line - 1,
                            end_col = warning.column and warning.column or 1,
                            severity = warning.severity == "error" and vim.diagnostic.severity.ERROR
                                or vim.diagnostic.severity.WARN,
                            source = "stylelint",
                            message = warning.text,
                        })
                    end
                end

                return diagnostics
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- print("Configured linter for filetype: ", vim.inspect(lint.linters_by_ft[vim.bo.filetype]))
                    -- print("Running stylelint for (filepath):", vim.fn.expand("%:p"))

                    require("lint").try_lint()
                end,
            })

            vim.keymap.set("n", "<space>l", function()
                require("lint").try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
