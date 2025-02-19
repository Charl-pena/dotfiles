local mason_ok, mason = pcall(require, "mason")
if not mason_ok then return end

local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then return end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end


local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      floating_window = false
    }, bufnr)
  end,
})

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
  capabilities = capabilities,
  -- on_attach = on_attach,
  on_new_config = function(config, root_dir)
    local handle = io.popen('cd "' .. root_dir .. '" && poetry env info -p 2>/dev/null')
    if handle then
      local env = handle:read("*a"):gsub("%s+$", "") -- Leer salida y eliminar espacios en blanco
      handle:close()
      if env and #env > 0 then
        config.settings.python.pythonPath = env .. '/bin/python'
      end
    end
  end
}
lspconfig.gopls.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.bashls.setup {}

-- Configuración para C#
lspconfig.omnisharp.setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "dotnet", "/home/moruz/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
}

-- Configuración para typescript
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- on_attach(client, bufnr) -- Llamamos a la función on_attach común
    -- Opciones adicionales, por ejemplo:
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = capabilities
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
