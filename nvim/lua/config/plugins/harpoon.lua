return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        local keymap_prefix = "<leader>h"

        harpoon.setup()

        -- Known harpoon functions:
        -- harpoon.ui.toggle_quick_menu(harpoon.list())
        -- harpoon.list().add()
        -- harpoon.list().select(#)
        -- harpoon.list().next()
        -- harpoon.list().prev()

        vim.keymap.set("n", keymap_prefix .. "p", function()
            harpoon:list():add()
        end, { desc = "Harpoon List Add" })

        vim.keymap.set("n", keymap_prefix .. "c", function()
            harpoon:list():clear()
        end, { desc = "Harpoon List Clear" })

        vim.keymap.set("n", "<C-S-N>", function()
            harpoon:list():next()
        end, { desc = "Harpoon List Next" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon List Previous" })

        -- REMOVE
        -- REMOVE
        -- REMOVE

        vim.keymap.set("n", keymap_prefix .. "r", function()
            harpoon:list():remove()
        end, { desc = "Harpoon List Remove" })

        vim.keymap.set("n", keymap_prefix .. "ra", function()
            harpoon:list():remove_at(1)
        end, { desc = "Harpoon List Remove 1" })

        vim.keymap.set("n", keymap_prefix .. "rs", function()
            harpoon:list():remove_at(2)
        end, { desc = "Harpoon List Remove 2" })

        vim.keymap.set("n", keymap_prefix .. "rd", function()
            harpoon:list():remove_at(3)
        end, { desc = "Harpoon List Remove 3" })

        vim.keymap.set("n", keymap_prefix .. "rf", function()
            harpoon:list():remove_at(4)
        end, { desc = "Harpoon List Remove 4" })

        vim.keymap.set("n", keymap_prefix .. "rg", function()
            harpoon:list():remove_at(5)
        end, { desc = "Harpoon List Remove 5" })

        vim.keymap.set("n", keymap_prefix .. "rh", function()
            harpoon:list():remove_at(6)
        end, { desc = "Harpoon List Remove 6" })

        vim.keymap.set("n", keymap_prefix .. "rj", function()
            harpoon:list():remove_at(7)
        end, { desc = "Harpoon List Remove 7" })

        vim.keymap.set("n", keymap_prefix .. "rk", function()
            harpoon:list():remove_at(8)
        end, { desc = "Harpoon List Remove 8" })

        vim.keymap.set("n", keymap_prefix .. "rl", function()
            harpoon:list():remove_at(9)
        end, { desc = "Harpoon List Remove 9" })
        -- REMOVE end
        -- REMOVE end
        -- REMOVE end

        -- REPLACE_AT
        -- REPLACE_AT
        -- REPLACE_AT
        vim.keymap.set("n", keymap_prefix .. "Ra", function()
            harpoon:list():replace_at(1)
        end, { desc = "Harpoon List Replace 1" })

        vim.keymap.set("n", keymap_prefix .. "Rs", function()
            harpoon:list():replace_at(2)
        end, { desc = "Harpoon List Replace 2" })

        vim.keymap.set("n", keymap_prefix .. "Rd", function()
            harpoon:list():replace_at(3)
        end, { desc = "Harpoon List Replace 3" })

        vim.keymap.set("n", keymap_prefix .. "Rf", function()
            harpoon:list():replace_at(4)
        end, { desc = "Harpoon List Replace 4" })

        vim.keymap.set("n", keymap_prefix .. "Rg", function()
            harpoon:list():replace_at(5)
        end, { desc = "Harpoon List Replace 5" })

        vim.keymap.set("n", keymap_prefix .. "Rh", function()
            harpoon:list():replace_at(6)
        end, { desc = "Harpoon List Replace 6" })

        vim.keymap.set("n", keymap_prefix .. "Rj", function()
            harpoon:list():replace_at(7)
        end, { desc = "Harpoon List Replace 7" })

        vim.keymap.set("n", keymap_prefix .. "Rk", function()
            harpoon:list():replace_at(8)
        end, { desc = "Harpoon List Replace 8" })

        vim.keymap.set("n", keymap_prefix .. "Rl", function()
            harpoon:list():replace_at(9)
        end, { desc = "Harpoon List Replace 9" })
        -- REPLACE_AT end
        -- REPLACE_AT end
        -- REPLACE_AT end

        -- SELECT
        -- SELECT
        -- SELECT
        vim.keymap.set("n", keymap_prefix .. "a", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon List Select 1" })

        vim.keymap.set("n", keymap_prefix .. "s", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon List Select 2" })

        vim.keymap.set("n", keymap_prefix .. "d", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon List Select 3" })

        vim.keymap.set("n", keymap_prefix .. "f", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon List Select 4" })

        vim.keymap.set("n", keymap_prefix .. "g", function()
            harpoon:list():select(5)
        end, { desc = "Harpoon List Select 5" })

        vim.keymap.set("n", keymap_prefix .. "h", function()
            harpoon:list():select(6)
        end, { desc = "Harpoon List Select 6" })

        vim.keymap.set("n", keymap_prefix .. "j", function()
            harpoon:list():select(7)
        end, { desc = "Harpoon List Select 7" })

        vim.keymap.set("n", keymap_prefix .. "k", function()
            harpoon:list():select(8)
        end, { desc = "Harpoon List Select 8" })

        vim.keymap.set("n", keymap_prefix .. "l", function()
            harpoon:list():select(9)
        end, { desc = "Harpoon List Select 9" })
        -- SELECT END
        -- SELECT END
        -- SELECT END

        vim.keymap.set("n", keymap_prefix, function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon List Toggle" })

        -- Telescope integration
        -- basic telescope configuration
        -- local conf = require("telescope.config").values
        -- local function toggle_telescope(harpoon_files)
        --     local file_paths = {}
        --     for _, item in ipairs(harpoon_files.items) do
        --         table.insert(file_paths, item.value)
        --     end
        --
        --     require("telescope.pickers")
        --         .new({}, {
        --             finder = require("telescope.finders").new_table({
        --                 results = file_paths,
        --             }),
        --             previewer = conf.file_previewer({}),
        --             prompt_title = "Harpoon",
        --             sorter = conf.generic_sorter({}),
        --         })
        --         :find()
        -- end
        --
        -- vim.keymap.set("n", keymap_prefix .. "", function()
        --     toggle_telescope(harpoon:list())
        -- end, { desc = "Open harpoon window" })
    end,
}
