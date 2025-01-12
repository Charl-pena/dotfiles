-- Intenta cargar el módulo prettier de manera segura
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return -- Sal del script si no se puede cargar
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      command = "prettierd",                                                                                                       -- Usar Prettierd en lugar de Prettier
      extra_args = { "--double-quote", "--jsx-double-quote", "--semi=true" },                                                      -- Opciones opcionales
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "html", "json", "yaml", "markdown" }, -- Tipos de archivo soportados
    }),
    null_ls.builtins.formatting.ormolu,
  },
  -- Agregar un manejador de errores para evitar que el archivo se corrompa
  on_attach = function(client)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          pcall(vim.lsp.buf.format, { async = true })
        end,
      })
    end
  end,
})
