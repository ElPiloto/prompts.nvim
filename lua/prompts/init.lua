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

local check_buffer_is_empty = function(buf_nr)
  --todo set default value of 0 for buf_nr if not specified
  -- 0 as bufnr gives current buffer
  local num_lines = vim.api.nvim_buf_line_count(buf_nr)
  if num_lines > 1 then
    -- TODO(elpiloto): Prompt user to insert prompt at top line.
    --print(tostring(num_lines))
    print('Diary file has too many lines, cannot insert prompt.')
    return
  end

  local buf_line = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  if buf_line[1]:gsub("^%s*(.-)%s*$", "%1") ~= '' then
    return false
  end
  return true
end

M.add_prompt_if_empty = function()
  local fname = vim.fn.expand("<afile>")
  local new_buf_nr = vim.fn.expand("<abuf>")
  local method = M.VIMWIKI_FN
  if vim.g.prompts_manual_diary_check == 1 then
    method = M.DATE_AND_EXTENSION
  end
  local is_diary = M.is_diary_file(fname, method)
  local is_empty = check_buffer_is_empty(new_buf_nr)
  if is_empty then
    local prompts = loader.load_prompts()
    local prompt = loader.choose_random_element(prompts)
    vim.api.nvim_buf_set_lines(buf_nr, 0, 1, false, {prompt})
  end
end

return M
