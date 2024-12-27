local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "lua_ls",
                       "clangd",
                      "pyright",
                        "gopls",
                        "cssls",
                         "html",
                          "hls",
                         "bashls",
                         "ts_ls"
                       }
})

lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.gopls.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.bashls.setup {}

-- Configuración para typescript
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Opciones adicionales como deshabilitar el formateador de tsserver si prefieres otro formateador.
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities() -- Integración con nvim-cmp
}

-- Configuración para Haskell
lspconfig.hls.setup{
--    cmd = {"/home/moruz/.ghcup/hls/2.9.0.1/bin/haskell-language-server-wrapper"},
    filetypes = { "haskell", "lhaskell", "cabal" },
    root_dir = lspconfig.util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"),
    settings = {
        haskell = {
            formattingProvider = "ormolu",  -- Cambia a "brittany" o "fourmolu" si prefieres otro formateador
        }
    }
}
lspconfig.emmet_language_server.setup({
  filetypes = {  "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
})
