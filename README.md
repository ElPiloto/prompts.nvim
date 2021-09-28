# prompts.nvim
no, not that kind of prompt. prompts for your vimwiki.

### Warning: WIP. Even when completed, mainly intended for personal use.

```
██   ██████  ██████   ██████  ███    ███ ██████  ████████ ███████    ███    ██ ██    ██ ██ ███    ███ 
 ██  ██   ██ ██   ██ ██    ██ ████  ████ ██   ██    ██    ██         ████   ██ ██    ██ ██ ████  ████ 
  ██ ██████  ██████  ██    ██ ██ ████ ██ ██████     ██    ███████    ██ ██  ██ ██    ██ ██ ██ ████ ██ 
 ██  ██      ██   ██ ██    ██ ██  ██  ██ ██         ██         ██    ██  ██ ██  ██  ██  ██ ██  ██  ██ 
██   ██      ██   ██  ██████  ██      ██ ██         ██    ███████ ██ ██   ████   ████   ██ ██      ██ 
```

This plugin will populate any empty files matching `*/diary/*` with a prompt.


### Plugin configuration settings (WIP)

```
" This also reflects the default settings.

" Specify a list of prompt files using $SUBDIR/$FNAME_NO_EXT format
" ['writing.i_wish'] will load ./resources/prompts/writing/i_wish.txt"
" ['diary.*'] will load all files under./resources/prompts/diary/
let g:prompts_vimwiki_list = ['diary.*', 'writing.i_wish', 'writing.how']

" Controls whether we use our own date and extension check for a diary."
" vimwiki provides a vimwiki#base#is_diary_file command, but that only works for opening today's diary.
" manually checking allows us to detect yesterday/tomorrow diary entries too.
let g:prompts_manual_diary_check = 1

" Only used for prompts_manual_diary_check = 1.
let g:prompts_valid_diary_extensions = ['wiki', 'md']

```


## Acknowledgements

Included prompts were sourced from various locations on the internet with minor rearrangement by me into separate lists. Here are the specific sources:
- [u/Dahija](https://www.reddit.com/r/JournalingIsArt/comments/13njgp/1000_prompts/)
- [Psych Central](https://psychcentral.com/blog/30-more-journaling-prompts-for-self-reflection-and-self-discovery#4)
- [Psych Central](https://psychcentral.com/blog/ready-set-journal-64-journaling-prompts-for-self-discovery#getting-unstuck)
