-- luacheck: push ignore 211 (unused variable)
--local api = vim.api

-- TODO(elpiloto): make debug level based on sidekick option.
--local log = require('plenary.log').new({ plugin = 'prompts.nvim', level='debug' })
-- luacheck: pop
loader = require('prompts.prompt_loader')

local M = {}

M.DATE_AND_EXTENSION = "date_and_extension"
M.VIMWIKI_FN = "vimwiki_fn"

local call_vimwiki_fn = function(fn_call)
  local fn_call_cmd = ":echo " .. fn_call
  local output = vim.api.nvim_exec(fn_call_cmd, true)
  return output
end


M.is_diary_file = function(fname, method)
  if method == M.DATE_AND_EXTENSION then
    local date_ext_pattern = '%d%d%d%d%-%d%d%-%d%d%.(.*)$'
    local ext_capture = string.match(fname, date_ext_pattern)
    for _, valid_ext in pairs(vim.g.prompts_valid_diary_extensions) do
      if ext_capture == valid_ext then
        print("Valid file.")
        return true
      end
    end
    return false
  elseif method == M.VIMWIKI_FN then
    local cmd = ":echom vimwiki#base#is_diary_file('" .. fname .. "')"
    local is_diary = vim.api.nvim_exec(cmd, true)
    return is_diary == "1"
  end
end

M.add_prompt_if_empty = function()
  local fname = vim.fn.expand("<afile>")
  local method = M.VIMWIKI_FN
  if vim.g.prompts_manual_diary_check == 1 then
    method = M.DATE_AND_EXTENSION
  end
  local is_diary = M.is_diary_file(fname, method)
  if is_diary then
    print("We would add a prompt now!")
    loader.load_prompts("nothing")
  end
end

return M
