return {
    -- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        enabled = true,
        build = "cd app && npm install",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
}
