local langs = { "python", "javascript", "rust", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
require('nvim-treesitter').install(langs)
vim.api.nvim_create_autocmd('FileType', {
  pattern = langs,
  callback = function()
    vim.treesitter.start()                                    -- highlighting
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'     -- folds
    vim.wo.foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
})
