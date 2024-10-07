-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map æ to ]. Used for navigating to "next" something.
vim.keymap.set("n", "æ", "]", { remap = true, silent = true })
vim.keymap.set("o", "æ", "]", { remap = true, silent = true })
vim.keymap.set("x", "æ", "]", { remap = true, silent = true })

-- Map ø to [. Used for navigating to "previous" something.
vim.keymap.set("n", "ø", "[", { remap = true, silent = true })
vim.keymap.set("o", "ø", "[", { remap = true, silent = true })
vim.keymap.set("x", "ø", "[", { remap = true, silent = true })

-- Map å to `. Used to go to marker.
vim.keymap.set("n", "å", "`", { silent = true })
