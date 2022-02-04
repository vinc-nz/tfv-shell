local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local make_entry = require "telescope.make_entry"

local M = {}


function hlword()
    local word = vim.api.nvim_call_function("getreg", {"/", 1})
    local escape_seq = string.sub(word, 0, 2)
    if (escape_seq == "\\V")
    then
        return string.sub(word, 3, -1)
    elseif (escape_seq == "\\<")
    then
        return string.sub(word, 3, -3)
    else
        return word
    end
end


function M.grep_hl(opts)
    local opts = opts or {}
    opts.search = hlword()
    require("telescope.builtin").grep_string(opts)
end


function M.find_files(opts)
    local opts = opts or {}
    opts.find_command = { "rg", "--files", "--glob=!target" }
    require("telescope.builtin").find_files(opts)
end

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob=!target'
    },
    mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<esc>"] = actions.close,
        },
    }
  },
}

return M
