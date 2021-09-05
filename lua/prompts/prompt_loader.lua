local path = require('plenary.path')
local M = {}


M.load_prompts = function(key)
  local prompts = {}
  local vimwiki_list = vim.g.prompts_vimwiki_list
  for _, entry in pairs(vimwiki_list) do
    local category, list = string.match(entry, "(.*)%.(.*)")
    --local full_path = vim.g.prompts_resources_dir .. category .. "/" .. list .. ".txt"
    local full_path = vim.g.prompts_resources_dir .. "prompts/" .. category .. "/"
    local dir_contents = vim.loop.fs_scandir(full_path)
    if dir_contents then
      local subdir = vim.loop.fs_scandir_next(dir_contents)
      while subdir do
        print('========')
        print(subdir)
        subdir = vim.loop.fs_scandir_next(dir_contents)
      end
    else
      print("Could not find anything under: " .. full_path)
      print(dir_contents)
      print("Could not find anything under: " .. full_path)
    end
    ---@diagnostic disable: unused-local
    local files = ""
    if list == '*' then
      files = ""
    ---@diagnostic enable: unused-local
    else
      files = ""
    end

    print(category, list, full_path)
    print(vim.fn.expand("<sfile>"))
  end
  return prompts
end

return M
