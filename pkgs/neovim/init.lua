vim.o.number = true
vim.o.hlsearch = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fs", "<cmd>write<cr>", {desc = "Save"})
vim.keymap.set("n", "<leader>qq", "<cmd>quit<cr>", {desc = "Quit"})

vim.opt.clipboard = "unnamedplus"

vim.cmd("colorscheme ef-winter")

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        components_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
})

require("nvim-autopairs").setup({
    check_ts = true,
})

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<S-CR>"] = { "select_and_accept", "fallback" },
    },

    completion = {
        documentation = { auto_show = true },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },

    signature = { enabled = true },
})

local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
    capabilities = blink_capabilities,
})

vim.diagnostic.config({
    signs = false,
})

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("nixd")
vim.lsp.enable("clangd")
