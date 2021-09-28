local path = require('plenary.path')
local M = {}
math.randomseed(os.time())

M.choose_random_element = function(t)
  local rand_number = math.random(#t)
  return t[rand_number]
end


local table_concat = function(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
end

local split_at_newlines = function(str)
  local lines = {}
  for s in str:gmatch("[^\r\n]+") do
    table.insert(lines, s)
  end
  return lines
end


local read_file_if_exists = function(f)
  local fstat = vim.loop.fs_stat(f)
  if fstat then
    local fd = vim.loop.fs_open(f, "r", 438)
    local lines = vim.loop.fs_read(fd, fstat.size, 0)
    return split_at_newlines(lines)
  else
    print('prompts.nvim: Unable to find prompts file: ' .. full_path .. ', skipping...')
  end
  return {}
end


M.load_prompts = function(key)
  local prompts = {}
  local vimwiki_list = vim.g.prompts_vimwiki_list
  local files = {}
  for _, entry in pairs(vimwiki_list) do
    local category, prompt_fname = string.match(entry, "(.*)%.(.*)")
    local full_path = vim.g.prompts_resources_dir .. "prompts/" .. category .. "/"
    if prompt_fname == '*' then
      --load all files in directory
      local dir_contents = vim.loop.fs_scandir(full_path)
      if dir_contents then
        local subdir = vim.loop.fs_scandir_next(dir_contents)
        while subdir do
          local this_file = full_path .. subdir
          local file_contents = read_file_if_exists(this_file)
          table_concat(prompts, file_contents)
          subdir = vim.loop.fs_scandir_next(dir_contents)
        end
      end
    else
      --look for the specific file
      local this_file = full_path .. prompt_fname .. '.txt'
      local file_contents = read_file_if_exists(this_file)
      table_concat(prompts, file_contents)
    end
  end
  return prompts
end

return M
