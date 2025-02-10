-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file
return {
    {
        "stevearc/conform.nvim",
        enabled = true,
        config = function()
            local conform = require("conform")

            conform.setup({
                default_format_opts = {
                    lsp_format = "fallback",
                },
                format_on_save = function(bufnr)
                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end

                    return {
                        -- These options are passed to conform.format()
                        timeout_ms = 5000,
                    }
                end,
                formatters_by_ft = {
                    -- Conform will run the first available formatter
                    -- javascript = { "prettierd", "prettier", stop_after_first = true }

                    bash = { "shfmt" },
                    css = { "stylelint" },
                    go = { "goimports", "gofumpt" },
                    html = { "djlint" },
                    javascript = { "eslint_d" },
                    json = { "fixjson" },
                    lua = { "stylua" },
                    markdown = { "marksman" },
                    scss = { "stylelint" },
                    sql = { "sqlfmt" },
                    typescript = { "eslint_d" },
                    vue = { "eslint_d" },
                },
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })
        end,
    },
}
