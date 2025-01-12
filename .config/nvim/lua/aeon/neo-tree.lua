vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
-- vim.cmd([[
--   highlight WinSeparator guibg=None guifg=None
-- ]])

local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

neotree.setup({
  close_if_last_window = false, -- No cerrar Neo-tree si es la última ventana abierta
  enable_git_status = true,     -- Mostrar estados de Git
  enable_diagnostics = false,   -- Opcional, para deshabilitar diagnósticos
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      { "name" },
      { "clipboard" },
      { "diagnostics", errors_only = true },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "name",
        use_git_status_colors = true,
        zindex = 10
      },
      { "clipboard" },
      { "bufnr" },
      { "modified" },
      { "diagnostics" },
      { "git_status" },
    },
  },
  default_component_configs = {
    -- container = {
    --   enable_character_fade = false
    -- },
    indent = {
      indent_size = 1, -- Equivalente a indent_width en nvim-tree
      padding = 1,     -- Espaciado entre niveles del árbol
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      expand_marker = { open = "▾", closed = "▸" }, -- Iconos de carpeta abiertos y cerrados
    },
    icon = {
      folder_closed = "", -- Opcional, icono de carpeta cerrada
      folder_open = "", -- Opcional, icono de carpeta abierta
      folder_empty = "",
    },
  },
  window = {
    position = "left",       -- Equivalente a `side`
    border = "none",
    width = 30,              -- Ancho del panel
    enable_horizontal_scroll = true,
    mappings = {
      ["l"] = "open",        -- Abrir archivo o carpeta
      ["h"] = "close_node",  -- Cerrar carpeta
      ["v"] = "open_vsplit", -- Abrir en split vertical
      ["Y"] = "copy_file_name", -- Copiar nombre de archivo
      ["<C-y>"] = "copy_relative_path", -- Copiar ruta relativa
    },
  },
  filesystem = {
    commands = {
      copy_file_name = function(state)
        local node = state.tree:get_node()
        if node then
          vim.fn.setreg('*', node.name, 'c')
          print("Nombre del archivo copiado: " .. node.name)
        else
          print("No se pudo obtener el nodo actual.")
        end
      end,
      copy_relative_path = function(state)
        local node = state.tree:get_node()
        if node then
          local relative_path = vim.fn.fnamemodify(node.path, ':.')
          vim.fn.setreg('*', relative_path, 'c')
          print("Ruta relativa copiada: " .. relative_path)
        else
          print("No se pudo obtener el nodo actual.")
        end
      end,
    },
    filtered_items = {
      hide_dotfiles = false,   -- Mostrar archivos ocultos (opcional)
      hide_gitignored = false, -- Mostrar archivos ignorados por Git
    },
    follow_current_file = {
      enabled = true,              -- Seguir el archivo activo
    },
    use_libuv_file_watcher = true, -- Actualizar automáticamente al cambiar archivos
  },
})
