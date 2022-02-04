local function path()
    local cwd = vim.api.nvim_call_function("getcwd", {})
    return string.gsub(cwd, ".*vinc/", "")
end

require('lualine').setup {
    options = {theme= 'onedark'},
    sections = {lualine_c = {path, {'filename', path = 1}, require('lsp-status').status}}
}
