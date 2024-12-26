local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup({
  hijack_netrw = true,       -- Reemplaza netrw
  disable_netrw = true,      -- Desactiva netrw
  renderer = {
    indent_width = 0,
    icons = {
      glyphs = {
        folder = {
          arrow_open = "▾",  -- Icono para carpetas abiertas
          arrow_closed = "▸", -- Icono para carpetas cerradas
        },
      },
    },
  },
  view = {
    width =30,              -- Ancho del panel
    side = "left",           -- Lado donde se abre el árbol
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Keymaps personalizados
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  end,
})
