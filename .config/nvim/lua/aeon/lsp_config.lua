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

local on_attach = function(client, bufnr)
  require("lsp_signature").on_attach({
    bind = true,
    doc_lines = 2,          -- Número de líneas para la documentación
    floating_window = true, -- Ventana flotante para mostrar la firma
    fix_pos = false,
    hint_enable = true,
    hint_prefix = " ", -- Puedes personalizar el ícono
    hi_parameter = "Search", -- Highlight para el parámetro actual
    handler_opts = {
      border = "rounded" -- Borde redondeado en la ventana
    },
  }, bufnr)
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "lua_ls",
    "clangd",
    "pyright",
    -- "gopls",
    "cssls",
    "html",
    "hls",
    "bashls",
    -- "ts_ls",
    -- "omnisharp"
  }
})

lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.pyright.setup {
  settings = {
    python = {
      pythonPath = vim.fn.systemlist("poetry env info --path")[1] .. "/bin/python"
    }
  }
}
lspconfig.gopls.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.bashls.setup {}

-- Configuración para C#
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  cmd = { "dotnet", "/home/moruz/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
}

-- Configuración para typescript
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr) -- Llamamos a la función on_attach común
    -- Opciones adicionales, por ejemplo:
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}

-- Configuración para Haskell
lspconfig.hls.setup {
  filetypes = { "haskell", "lhaskell", "cabal" },
  root_dir = lspconfig.util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"),
  settings = {
    haskell = {
      formattingProvider = "ormolu", -- Cambia a "brittany" o "fourmolu" si prefieres otro formateador
    }
  }
}
lspconfig.emmet_language_server.setup({
  filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
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
