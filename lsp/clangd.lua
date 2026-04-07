-- Este archivo define cómo se comporta el servidor clangd
return {
  cmd = { 'clangd' }, -- Neovim buscará este ejecutable en tu PATH [3]
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, -- Cuándo activarse [1]
  root_markers = { '.git', 'compile_commands.json', 'compile_flags.txt' }, -- Dónde buscar la raíz del proyecto [1, 3]
}
