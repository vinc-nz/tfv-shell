
local lspstatus = require('lsp-status')
lspstatus.register_progress()
lspstatus.config({
    status_symbol = ' V',
})

local completion = require('completion')

function on_attach(client, bufnr)
    lspstatus.on_attach(client, bufnr)
    completion.on_attach(client, bufnr)
end

local lsp = require('lspconfig')
lsp.rust_analyzer.setup {
    capabilities = lspstatus.capabilities,
    on_attach = on_attach,
    settings = { 
  	["rust-analyzer"] = { 
  		diagnostics = {
  			disabled = {"inactive-code"}
  			} 
  		} 
  	} 
}

lsp.clangd.setup {
    capabilities = lspstatus.capabilities,
    on_attach = on_attach,
}
