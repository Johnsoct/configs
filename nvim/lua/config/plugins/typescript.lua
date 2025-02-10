return {
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            require("typescript-tools").setup({
                -- handlers = {
                -- ["textDocument/publishDiagnostics"] = function() end,
                -- },
            })
        end,
    },
}
