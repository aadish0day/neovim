-- Consider bufferline.nvim instead
return{
{
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup{}
    vim.keymap.set('n', '<TAB>', '<Cmd>BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<S-TAB>', '<Cmd>BufferLineCyclePrev<CR>')
    vim.keymap.set('n', '<leader>q', '<Cmd>bdelete<CR>')
  end
},
}
