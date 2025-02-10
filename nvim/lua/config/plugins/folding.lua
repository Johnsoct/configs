local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 🖐🏼 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            vim.o.foldlevelstart = 1 -- '0' is not bad
            vim.o.foldlevel = 99     -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            -- (Note: the `nvim-treesitter` plugin is *not* needed.)
            -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
            -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
            require("ufo").setup({
                fold_virt_text_handler = handler,
                provider_selector = function()
                    return { "treesitter", "indent" }
                end,
            })

            ----------------
            ---SCSS FOLDS---
            ----------------
            vim.cmd([[
                augroup scss_folding
                    autocmd!
                    autocmd FileType scss setlocal foldmethod=syntax
                augroup END
            ]])
        end,
    },
}
