return {
    {
        {
            "catppuccin/nvim",
            enabled = true,
            config = function()
                require("catppuccin").setup({
                    flavour = "mocha",
                })

                vim.cmd.colorscheme("catppuccin-mocha")
            end,
        },
        {
            "folke/tokyonight.nvim",
            enabled = false,
            opts = {},
            config = function()
                local transparent = false

                if transparent then
                    vim.cmd([[
                        highlight Normal guibg=none
                        highlight NonText guibg=none
                        highlight Normal ctermbg=none
                        highlight NonText ctermbg=none
                    ]])
                end

                require("tokyonight").setup({
                    dim_inactive = true,

                    -- on_colors = function(colors)
                    --     colors.
                    styles = {
                        -- comments = {
                        --     bg = "white",
                        --     fg = "#222222",
                        -- },
                        -- floats = transparent and "transparent" or "dark",
                        -- sidebars = transparent and "transparent" or "dark",
                    },
                    transparent = transparent,
                })

                vim.cmd.colorscheme("tokyonight-storm")
            end,
        },
        {
            "nyoom-engineering/oxocarbon.nvim",
            enabled = false,
            config = function()
                vim.opt.background = "dark"
                vim.cmd.colorscheme("oxocarbon")
            end,
        },
        {
            "scottmckendry/cyberdream.nvim",
            enabled = false,
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("cyberdream")

                local transparent = true

                if transparent then
                    vim.cmd([[
                        highlight Normal guibg=none highlight NonText guibg=none
                        highlight Normal ctermbg=none
                        highlight NonText ctermbg=none
                    ]])
                end

                require("cyberdream").setup({
                    cache = false, -- improve start up time by caching highlights
                    theme = {
                        saturation = 1,
                    },
                    transparent = true,
                })

                -- The event data property will contain a string with either "default" or "light" respectively
                vim.api.nvim_create_autocmd("User", {
                    pattern = "CyberdreamToggleMode",
                    callback = function(event)
                        -- Your custom code here!
                        -- For example, notify the user that the colorscheme has been toggled
                        print("Switched to " .. event.data .. " mode!")
                    end,
                })
            end,
        },
    },
}
