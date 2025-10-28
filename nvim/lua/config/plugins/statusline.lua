return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    component_separators = '',
                    section_separators = '',
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_x = {
                        -- "encoding",
                        -- "fileformat",
                        -- "filetype",
                        'diagnostics'
                        -- "searchcount",
                    },
                },
            })
        end,
    },
}
