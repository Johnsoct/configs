return {
    {
        "fatih/vim-go",
        build = ":GoUpdateBinaries",
        config = function()
            -- require("vim-go").setup()

            vim.g.go_fmt_command = "goimports"
            vim.g.go_def_mode = "gopls"
            vim.g.go_info_mode = "gopls"
        end,
    }
}
