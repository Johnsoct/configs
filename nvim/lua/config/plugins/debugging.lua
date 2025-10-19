return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("dapui").setup()
        require("dap-go").setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>dc", dap.continue, {})
        -- vim.keymap.set("n", "<leader>dd", dap.disconnect, {})
        -- vim.keymap.set("n", "<leader>dn", dap.new, {})
        -- vim.keymap.set("n", "<leader>dr", dap.restart_frame, {})
        -- vim.keymap.set("n", "<leader>dsi", dap.step_into, {})
        -- vim.keymap.set("n", "<leader>dsl", dap.step_over, {})
        -- vim.keymap.set("n", "<leader>dso", dap.step_out, {})
        -- vim.keymap.set("n", "<leader>dt", dap.terminate, {})
        vim.keymap.set("n", "<leader>dcb", dap.clear_breakpoints, {})
        vim.keymap.set("n", "<leader>dtb", dap.toggle_breakpoint, {})

        -- dap.adapters.go = {
        --     type = "executable",
        --     command = "node",
        --     args = { os.getenv("HOME") .. "/dev/vscode-go/extension/dist/debugAdapter.js" },
        -- }
        -- dap.configurations.go = {
        --     {
        --         type = "go",
        --         name = "Debug",
        --         request = "launch",
        --         showLog = false,
        --         program = "${file}",
        --         dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        --     },
        -- }
    end,
}
