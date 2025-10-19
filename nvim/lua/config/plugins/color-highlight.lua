return {
    -- {
    --     "brenoprata10/nvim-highlight-colors",
    --     config = function()
    --         require("nvim-highlight-colors").setup({
    --             render = "background",
    --             enable_named_colors = true,
    --         })
    --     end,
    -- },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            local colorizer = require("colorizer")

            colorizer.setup({
                filetypes = {
                    "*",
                    ps1 = {
                        RGB = false,
                        css = false,
                    },
                    vue = {
                        -- mode = "virtualtext",
                        css = true,
                    },
                    typescript = {
                        css = true,
                    },
                    javascript = {
                        css = false,
                    },
                    json = {
                        css = false,
                    },
                    sh = {
                        css = false,
                    },
                    mason = {
                        css = false,
                    },
                    lazy = {
                        RGB = false,
                        css = false,
                    },
                    cmp_docs = {
                        always_update = true,
                        css = true,
                    },
                    TelescopeResults = {
                        RGB = false,
                    },
                    markdown = {
                        RGB = false,
                        always_update = true,
                    },
                    checkhealth = {
                        names = false,
                    },
                    Mason = {
                        names = false,
                    },
                },
                user_default_options = {
                    always_update = true,
                    css = true,
                    mode = "background",
                    names = false,
                    names_opts = {
                        camelcase = true,
                        lowercase = true,
                        strip_digits = false,
                        uppercase = true,
                    },
                    sass = {
                        enable = false,
                        parsers = {
                            "css",
                        },
                    },
                },
            })
        end,
    },
}
