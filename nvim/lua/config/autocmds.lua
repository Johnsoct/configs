-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Displays floating linting messages
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        -- vim.lsp.util.open_floating_preview.Opts
        -- offset_x/y
        -- zindex (defaults to 50)
        -- anchor_bias: auto, above, below (defaults to auto)
        vim.diagnostic.open_float({ focusable = false, scope = "line", anchor_bias = "above" })
    end,
})
