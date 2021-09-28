" Let's us reload our lua code by calling :call Prompts()
fun! Prompts()
	lua for k in pairs(package.loaded) do if k:match("^prompts") then package.loaded[k] = nil end end
	lua require("prompts")
endfun

augroup Prompts
	autocmd!
augroup END

if !exists('g:prompts_vimwiki_list')
  " TODO(ElPiloto): Remove writing here.
  let g:prompts_vimwiki_list = ['diary.*', 'writing.i_wish', 'writing.how']
endif
if !exists('g:prompts_enable_vimwiki')
  let g:prompts_enable_vimwiki = 1
endif
if !exists('g:prompts_manual_diary_check')
  " Controls whether we use our own date and extension check for a diary."
  " vimwiki provides a vimwiki#base#is_diary_file command, but that only works for opening today's diary.
  " manually checking allows us to detect yesterday/tomorrow diary entries too.
  let g:prompts_manual_diary_check = 1
endif
" TODO(ElPiloto): Add setting for dict of filetypes --> list of prompt types.
" let g:prompts_list = {'writing': ['writing.i_wish']}
if !exists('g:prompts_valid_diary_extensions')
  " Only used for prompts_manual_diary_check = 1.
  let g:prompts_valid_diary_extensions = ['wiki', 'md']
endif
augroup Prompts
  autocmd BufEnter */diary/* :lua require('prompts').add_prompt_if_empty()
  " autocmd BufAdd,BufNewFile */diary/* :lua require('prompts').add_prompt_if_empty()
augroup END

let g:prompts_resources_dir = expand("<sfile>:h:h") .. "/resources/"
