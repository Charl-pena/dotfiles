
-- Intenta cargar el módulo prettier de manera segura
local status_ok, none_ls = pcall(require, "prettier")
if not status_ok then
    return -- Sal del script si no se puede cargar
end

none_ls.setup({
 sources = {
        none_ls.builtins.formatting.prettier.with({
            command = "prettierd", -- Usar Prettierd en lugar de Prettier
            extra_args = { "--single-quote", "--jsx-single-quote", "--semi=false" }, -- Opciones opcionales
            filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown" }, -- Tipos de archivo soportados
        }),
    },
    -- on_attach = function(client, bufnr)
    --     -- Mapear comando para formatear
    --     if client.supports_method("textDocument/formatting") then
    --         vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
    --     end
    -- end,
})
