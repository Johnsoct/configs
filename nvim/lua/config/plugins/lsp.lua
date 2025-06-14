return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
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
            local function get_global_npm_root()
                local handle = io.popen("npm root -g")

                if handle then
                    local result = handle:read("*a")

                    handle:close()

                    return result:gsub("%s+", "") -- trim whitespace
                end
            end

            -- blink.cmp is a performant, batteries-included completion plugin for Neovim
            local blink = require("blink.cmp").get_lsp_capabilities()
            local global_npm_root = get_global_npm_root()
            local lsp = require("lspconfig")

            lsp.lua_ls.setup({
                capabilities = blink,
            })

            -----------
            --- TS ----
            -----------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua
            lsp.ts_ls.setup({
                capabilities = blink,
                filetypes = { "typescript", "javascript", "vue" },
                -- handlers = {
                --     ["textDocument/publishDiagnostics"] = function() end,
                -- },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = global_npm_root .. "/@vue/typescript-plugin",
                            languages = { "vue" },
                        },
                    },
                },
                -- on_attach = function(client, bufnr)
                --     -- Disable diagnostics if using ESLint
                --     client.server_capabilities.diagnosticProvider = false
                -- end,
            })

            -----------
            -- VUE --
            -----------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue_ls
            --- Uses a local TS server, but falls back to my global TS install
            lsp.volar.setup({
                before_init = function(params, config)
                    local lib_path = vim.fs.find("node_modules/typescript/lib", { upward = true })
                    if lib_path then
                        config.init_options.typescript.tsdk = lib_path
                    end
                end,
                filetypes = { "vue" },
                init_options = {
                    typescript = {
                        tsdk = global_npm_root .. "/typescript/lib",
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
                filetypes = { "css", "scss", "vue" },
                settings = {
                    autoFixOnFormat = true,
                    autoFixOnSave = true,
                    filetypes = { "css", "scss", "vue" },
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
