return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon.setup()

        -- Known harpoon functions:
        -- harpoon.ui.toggle_quick_menu(harpoon.list())
        -- harpoon.list().add()
        -- harpoon.list().select(#)
        -- harpoon.list().next()
        -- harpoon.list().prev()

        vim.keymap.set("n", "<leader>lp", function()
            harpoon:list():add()
        end, { desc = "Harpoon List Add" })

        vim.keymap.set("n", "<leader>lc", function()
            harpoon:list():clear()
        end, { desc = "Harpoon List Clear" })

        vim.keymap.set("n", "<leader>lr", function()
            harpoon:list():remove()
        end, { desc = "Harpoon List Remove" })

        -- vim.keymap.set("n", "<leader>lp", function()
        --     harpoon:list():remove_at()
        -- end)

        -- vim.keymap.set("n", "<leader>lp", function()
        --     harpoon:list():add()
        -- end)
        -- remove_at
        -- replace_at
        vim.keymap.set("n", "<leader>L", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon List Toggle" })

        vim.keymap.set("n", "<leader>la", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon List Select 1" })

        vim.keymap.set("n", "<leader>ls", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon List Select 2" })

        vim.keymap.set("n", "<leader>ld", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon List Select 3" })

        vim.keymap.set("n", "<leader>lf", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon List Select 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon List Previous" })

        vim.keymap.set("n", "<C-S-N>", function()
            harpoon:list():next()
        end, { desc = "Harpoon List Next" })

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
        -- vim.keymap.set("n", "<leader>l", function()
        --     toggle_telescope(harpoon:list())
        -- end, { desc = "Open harpoon window" })
    end,
}
