local api = vim.api

vim.g.mapleader = ' '

api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })
api.nvim_set_keymap('n', '<leader>w', ':w<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>W', '<cmd>lua vim.lsp.buf.formatting_sync()<cr>:w<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', { noremap = true })
api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

api.nvim_set_keymap('n', '<leader>|', ':vsplit<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>-', ':split<cr>', { noremap = true })

api.nvim_set_keymap('n', 'gh', '<C-w>h', { noremap = true })
api.nvim_set_keymap('n', 'gj', '<C-w>j', { noremap = true })
api.nvim_set_keymap('n', 'gk', '<C-w>k', { noremap = true })
api.nvim_set_keymap('n', 'gl', '<C-w>l', { noremap = true })

api.nvim_set_keymap('n', '<esc><esc>', ':nohlsearch<cr>', { noremap = true })

api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true })

api.nvim_set_keymap('n', '<Tab>', 'gt', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<S-Tab>', 'gT', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-n>', ':$tabnew<cr>', { noremap = true })
api.nvim_set_keymap('n', '<A-h>', ':-tabmove<cr>', { noremap = true })
api.nvim_set_keymap('n', '<A-l>', ':+tabmove<cr>', { noremap = true })
