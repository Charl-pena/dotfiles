local status_ok, treesitter = pcall(require, "nvim-treesitter.configs") -- Asegúrate de usar el módulo correcto
if not status_ok then
  return -- Si `require` falla, sal del script
end

treesitter.setup {
    -- ensure_installed = { "haskell", "lua", "python", "javascript", "typescript", "tsx", "c", "html", "css", "rust" }, -- Añade lenguajes que uses
    ensure_installed = { "lua", "python", "javascript", "tsx", "c", "html", "css", "c_sharp", }, -- Añade lenguajes que uses
    highlight = {
        enable = true,              -- Activa el resaltado de sintaxis
        additional_vim_regex_highlighting = false,
    },
    indent ={ enable = true,}
}

--treesitter.setup {
  --ensure_installed = { "c", "lua", "python", "html", "css", "javascript" },
  --sync_install = false,
  --auto_install = true,
  --highlight = {
    --enable = true,
    --additional_vim_regex_highlighting = false,
  --},
  --indent = { enable = true, disable = { "yaml" } },
--}
