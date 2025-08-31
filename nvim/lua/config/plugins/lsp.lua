return {
    {

        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            auto_update = true,
            ensure_installed = {
                "bash-language-server",
                "css-lsp",
                "css-variables-language-server",
                "dotenv-linter",
                "eslint_d",
                "fixjson",
                "gh-actions-language-server",
                "go-debug-adapter",
                "gofumpt",
                "goimports",
                "golangci-lint",
                "golangci-lint-langserver",
                "golines",
                "gopls",
                "html-lsp",
                "js-debug-adapter",
                "json-lsp",
                "jsonlint",
                "lua-language-server",
                "luacheck",
                "luaformatter",
                "markdownlint",
                "marksman",
                "shfmt",
                "some-sass-language-server",
                "sql-formatter",
                "sqls",
                "stylelint",
                "stylua",
                "typescript-language-server",
                "vue-language-server",
                "yaml-language-server",
                "yamlfmt",
                "yamllint",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local function get_global_npm_root()
                local handle = io.popen("npm root -g")

                if handle then
                    local result = handle:read("*a")

                    handle:close()

                    return result:gsub("%s+", "") -- trim whitespace
                end
            end

            local async = require("lspconfig.async")
            local global_npm_root = get_global_npm_root()
            local lsp = require("lspconfig")
            local mod_cache = nil
            local util = require("lspconfig.util")

            ------------
            --- BASH ---
            ------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/bashls.lua
            lsp.bashls.setup({
                cmd = { "bash-language-server", "start" },
                settings = {
                    bashIde = {
                        -- Glob pattern for finding and parsing shell script files in the workspace.
                        -- Used by the background analysis features across files.

                        -- Prevent recursive scanning which will cause issues when opening a file
                        -- directly in the home directory (e.g. ~/foo.sh).
                        --
                        -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
                        globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
                    },
                },
                filetypes = { "bash", "sh" },
                root_dir = function(fname)
                    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
                end,
                single_file_support = true,
            })

            -----------
            --- CSS ---
            -----------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua
            lsp.cssls.setup({
                before_init = function(_, config)
                    config.settings.css.format = false
                    config.settings.scss.format = false
                end,
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
                on_attach = function(client)
                    -- Disable cssls' own diagnostics
                    client.handlers["textDocument/publishDiagnostics"] = function() end
                    -- Disable cssls formatting - unfortunately, it fucking sucks at formatting
                    -- expression operators: https://github.com/beautifier/js-beautify/issues/2223
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
                root_dir = util.root_pattern("package.json", ".git"),
                single_file_support = true,
                settings = {
                    css = { validate = true },
                    scss = { validate = true },
                    less = { validate = true },
                },
            })

            ---------------------
            --- CSS VARIABLES ---
            ---------------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/css_variables.lua
            lsp.css_variables.setup({
                cmd = { "css-variables-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_dir = util.root_pattern("package.json", ".git"),
                -- Same as inlined defaults that don't seem to work without hardcoding them in the lua config
                -- https://github.com/vunguyentuan/vscode-css-variables/blob/763a564df763f17aceb5f3d6070e0b444a2f47ff/packages/css-variables-language-server/src/CSSVariableManager.ts#L31-L50
                settings = {
                    cssVariables = {
                        lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
                        blacklistFolders = {
                            "**/.cache",
                            "**/.DS_Store",
                            "**/.git",
                            "**/.hg",
                            "**/.next",
                            "**/.svn",
                            "**/bower_components",
                            "**/CVS",
                            "**/dist",
                            "**/node_modules",
                            "**/tests",
                            "**/tmp",
                        },
                    },
                },
            })

            ---------------------
            --- GOLANGCI LINT ---
            ---------------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/golangci_lint_ls.lua
            lsp.golangci_lint_ls.setup({
                cmd = { "golangci-lint-langserver" },
                filetypes = { "go", "gomod" },
                init_options = {
                    command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
                },
                root_dir = function(fname)
                    return util.root_pattern(
                        ".golangci.yml",
                        ".golangci.yaml",
                        ".golangci.toml",
                        ".golangci.json",
                        "go.work",
                        "go.mod",
                        ".git"
                    )(fname)
                end,
                before_init = function(_, config)
                    -- Add support for golangci-lint V1 (in V2 `--out-format=json` was replaced by
                    -- `--output.json.path=stdout`).
                    local v1
                    -- PERF: `golangci-lint version` is very slow (about 0.1 sec) so let's find
                    -- version using `go version -m $(which golangci-lint) | grep '^\smod'`.
                    if vim.fn.executable("go") == 1 then
                        local exe = vim.fn.exepath("golangci-lint")
                        local version = vim.system({ "go", "version", "-m", exe }):wait()
                        v1 = string.match(version.stdout, "\tmod\tgithub.com/golangci/golangci%-lint\t")
                    else
                        local version = vim.system({ "golangci-lint", "version" }):wait()
                        v1 = string.match(version.stdout, "version v?1%.")
                    end
                    if v1 then
                        config.init_options.command = { "golangci-lint", "run", "--out-format", "json" }
                    end
                end,
            })

            -------------
            --- GOPLS ---
            -------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gopls.lua
            lsp.gopls.setup({
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = function(fname)
                    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
                    if not mod_cache then
                        local result = async.run_command({ "go", "env", "GOMODCACHE" })
                        if result and result[1] then
                            mod_cache = vim.trim(result[1])
                        else
                            mod_cache = vim.fn.system("go env GOMODCACHE")
                        end
                    end
                    if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
                        local clients = vim.lsp.get_clients({ name = "gopls" })
                        if #clients > 0 then
                            return clients[#clients].config.root_dir
                        end
                    end
                    return util.root_pattern("go.work", "go.mod", ".git")(fname)
                end,
                single_file_support = true,
            })

            ------------
            --- HTML ---
            ------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/html.lua
            --- `npm i -g vscode-langservers-extracted`
            lsp.html.setup({
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html", "templ" },
                root_dir = util.root_pattern("package.json", ".git"),
                single_file_support = true,
                settings = {},
                init_options = {
                    provideFormatter = true,
                    embeddedLanguages = { css = true, javascript = true },
                    configurationSection = { "html", "css", "javascript" },
                },
            })

            ------------
            --- JSON ---
            ------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/jsonls.lua
            lsp.jsonls.setup({
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                init_options = {
                    provideFormatter = true,
                },
                root_dir = function(fname)
                    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
                end,
                single_file_support = true,
            })
            -----------
            --- LUA ---
            -----------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua#L32
            local lua_root_files = {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git",
            }
            lsp.lua_ls.setup({
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_dir = util.root_pattern(lua_root_files),
                single_file_support = true,
                log_level = vim.lsp.protocol.MessageType.Warning,
            })

            ----------------
            ---- PYTHON ----
            ----------------
            --- https://github.com/python-lsp/python-lsp-server?tab=readme-ov-file
            lsp.pylsp.setup({
                cmd = { "pylsp" },
                filetypes = { "python" },
                root_dir = util.root_pattern(".git", "setup.py", "pyproject.toml"),
                single_file_support = true,
            })

            ----------------
            --- SOMESASS ---
            ----------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/somesass_ls.lua
            --- `npm i -g some-sass-language-server`
            lsp.somesass_ls.setup({
                name = "somesass_ls",
                cmd = { "some-sass-language-server", "--stdio" },
                filetypes = { "scss", "sass" },
                root_dir = util.root_pattern(".git", ".package.json"),
                single_file_support = true,
                settings = {
                    somesass = {
                        suggestAllFromOpenDocument = true,
                    },
                },
            })

            ------------
            --- SQL ----
            ------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/sqls.lua
            lsp.sqls.setup({
                cmd = { "sqls" },
                filetypes = { "sql", "mysql" },
                root_dir = util.root_pattern("config.yml"),
                single_file_support = true,
                settings = {},
            })

            -----------------
            --- STYLELINT ---
            -----------------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/stylelint_lsp.lua
            local stylelint_root_file = {
                ".stylelintrc",
                ".stylelintrc.mjs",
                ".stylelintrc.cjs",
                ".stylelintrc.js",
                ".stylelintrc.json",
                ".stylelintrc.yaml",
                ".stylelintrc.yml",
                "stylelint.config.mjs",
                "stylelint.config.cjs",
                "stylelint.config.js",
            }
            stylelint_root_file = util.insert_package_json(stylelint_root_file, "stylelint")
            lsp.stylelint_lsp.setup({
                cmd = { "npx", "stylelint-lsp", "--stdio" },
                filetypes = {
                    "css",
                    "scss",
                    "vue",
                },
                root_dir = util.root_pattern(unpack(stylelint_root_file)),
                -- root_dir = util.root_pattern("package.json", ".git"),
                settings = {},
            })

            ----------
            --- TS ---
            ----------
            --- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua
            --- Installed via `npm install -g typescript typescript-language-server`
            lsp.ts_ls.setup({
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = { "typescript", "javascript", "vue" },
                init_options = {
                    hostInfo = "neovim",
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = global_npm_root .. "/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                root_dir = util.root_pattern("tsconfig.json"),
                single_file_support = true,
            })

            -----------
            --- VUE ---
            -----------
            -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/volar.lua
            --- Uses a local TS server, but falls back to my global TS install
            --- Installed via `npm install -g @vue/language-server`
            local volar_init_options = {
                typescript = {
                    tsdk = global_npm_root .. "/typescript/lib",
                },
            }
            lsp.volar.setup({
                before_init = function(params, config)
                    local lib_path = vim.fs.find("node_modules/typescript/lib", { upward = true })
                    if lib_path then
                        config.init_options.typescript.tsdk = lib_path
                    end
                end,
                cmd = { "vue-language-server", "--stdio" },
                filetypes = { "vue" },
                init_options = volar_init_options,
                on_new_config = function(new_config, new_root_dir)
                    local lib_path =
                        vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
                    if lib_path then
                        new_config.init_options.typescript.tsdk = lib_path
                    end
                end,
                root_dir = util.root_pattern("package.json"),
            })

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
        end,
    },
}
