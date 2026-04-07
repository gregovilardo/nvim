-- ~/.config/nvim/lsp/lua_ls.lua
return {
  cmd = { 'lua-language-server' }, -- El binario que instala Mason [7]
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git', 'init.lua' }, -- Marcadores para detectar la raíz [8, 9]
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- Evita avisos de "undefined global vim" [10, 11]
      },
    },
  },
}
