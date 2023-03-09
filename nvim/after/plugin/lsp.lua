local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "rust_analyzer",
  "pyright",
  "lua_ls",
  "tailwindcss",
  "cssls",
  "html"
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.configure('tsserver', {
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
})

lsp.configure('tailwindcss', {
  capabilities = capabilities
})

lsp.configure('cssls', {
  capabilities = capabilities
})

lsp.configure('eslint', {
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact" }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
