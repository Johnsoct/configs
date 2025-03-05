return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_x = {
                        "encoding",
                        "fileformat",
                        "filetype",
                        -- "searchcount",
                    },
                },
            })
        end,
    },
}
