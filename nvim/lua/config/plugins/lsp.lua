return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "sqlls",
                    "sqls",
                    "stylelint_lsp",
                    "ts_ls",
                    "volar",
                },
            })

            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({})
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["vtsls"] = function()
                -- require("vtsls").setup {}
                -- end
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- blink.cmp is a performant, batteries-included completion plugin for Neovim
            local blink = require("blink.cmp").get_lsp_capabilities()
            local lsp = require("lspconfig")

            lsp.lua_ls.setup({
                capabilities = blink,
            })

            -----------
            --- TS ----
            -- --------
            lsp.ts_ls.setup({
                capabilities = blink,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "~/.nvm/versions/node/v22.11.0/lib/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
            })

            -----------
            -- VOLAR --
            -----------
            lsp.volar.setup({
                filetypes = { "vue" },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            })

            -----------
            ---CSSLS---
            -----------
            -- Enable snippet capability for completion
            -- local csslsCapabilities = vim.lsp.protocol.make_client_capabilities()
            -- csslsCapabilities.textDocument.completion.completionItem.snippetSupport = true
            lsp.cssls.setup({
                -- capabilities = csslsCapabilities,
                filetypes = { "css", "less", "scss" },
                before_init = function(_, config)
                    config.settings.css.format = false
                    config.settings.scss.format = false
                end,
                on_attach = function(client)
                    -- Disable cssls' own diagnostics
                    client.handlers["textDocument/publishDiagnostics"] = function() end
                    -- Disable cssls formatting - unfortunately, it fucking sucks at formatting
                    -- expression operators: https://github.com/beautifier/js-beautify/issues/2223
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            ---------------
            ---Stylelint---
            ---------------
            lsp.stylelint_lsp.setup({
                settings = {
                    autoFixOnFormat = true,
                    autoFixOnSave = true,
                    filetypes = { "css", "scss", "less" },
                },
                stylelintplus = {
                    -- see available options in stylelint-lsp documentation
                },
            })

            -----------------
            ---CSS Modules---
            -----------------
            -- lsp.cssmodules_ls.setup({
            --     filetypes = {
            --         "javascript",
            --         "javascriptreact",
            --         "typescript",
            --         "typescriptreact",
            --         "vue",
            --         "css",
            --         "scss",
            --         "sass",
            --     },
            -- on_attach = function(client)
            --     -- avoid race conditions with other LSPs, such as ts_ls, for go-to-definition support
            --     client.server_capabilities.definitionProvider = false
            -- end,
            -- })

            --------------------
            ---Web Components---
            --------------------
            -- lsp.custom_elements_ls.setup({
            --     filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            -- })

            ----------------
            ---LSP Attach---
            ----------------
            -- Create autocmd on LspAttach: key config entry point for what the lsp will do in any given buffer
            -- i.e. when we attach a file (Editor) and any given language server
            -- (the lack of a buffer argument inside of the {} for LspAttach implies it happens every single
            -- time we attach a file with a language server
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    -- Does this client actually support formatting, and if it does
                    -- create another autocmd for BufWritePre with a buffer parameter
                    -- (i.e. only listen to these events (textDocument/formatting) inside of this current buffer
                    -- so you're not calling format on an open file that doesn't have an attached LSP)
                    if client:supports_method("textDocument/formatting") then
                        if client.name == "cssls" then
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end
                        -- print(client.name, "supports text formatting")
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                -- vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
        end,
    },
}
