-- Bootstrap lazy.nvim
-- vim.fn functions built into vim, look for lazy.nvim in stdpath data
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- If it exists
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- If not, clone it
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Hey! Put lazy into the runtime path for neovim! (this allows us to `require("lazy")` below
-- :echo nvim_list_runtime_paths() will show the lazy in the paths
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "config.plugins" },
    },
    defaults = {
        lazy = false, -- Do not lazy load plugins
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "catppuccin-mocha" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
}, {
    rocks = {
        hererocks = true,
    },
})
