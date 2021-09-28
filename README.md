# prompts.nvim
no, not that kind of prompt. prompts for your vimwiki!

_This plugin will populate any empty files matching `*/diary/*` with a randomly selected prompt._


```
██   ██████  ██████   ██████  ███    ███ ██████  ████████ ███████    ███    ██ ██    ██ ██ ███    ███ 
 ██  ██   ██ ██   ██ ██    ██ ████  ████ ██   ██    ██    ██         ████   ██ ██    ██ ██ ████  ████ 
  ██ ██████  ██████  ██    ██ ██ ████ ██ ██████     ██    ███████    ██ ██  ██ ██    ██ ██ ██ ████ ██ 
 ██  ██      ██   ██ ██    ██ ██  ██  ██ ██         ██         ██    ██  ██ ██  ██  ██  ██ ██  ██  ██ 
██   ██      ██   ██  ██████  ██      ██ ██         ██    ███████ ██ ██   ████   ████   ██ ██      ██ 
```

[![asciicast](https://asciinema.org/a/438566.svg)](https://asciinema.org/a/438566)

### Requirements:

- neovim (>= 0.5.0)
- vimwiki

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

### Adding your own prompts

The prompts used by vimwiki are in simple text format under `./resources/prompts/$SUBDIR/$FNAME.txt`  Each prompt should be on its own line. You can add new prompts to existing files under the `resources/prompts` directory. Alternatively, you can create a new file or subdirectory and add this value to your `g:prompts_vimwiki_list`.  For example, you could add `resources/prompts/custom_prompts/quotes.txt` and configure prompts.nvim with: `let g:prompts_vimwiki_list = ['custom_prompts.quotes']` (NOTE: we omit the file extension.)

### Warning: WIP.

## Acknowledgements

Included prompts were sourced from various locations on the internet with minor rearrangement by me into separate lists. Here are the specific sources:
- [u/Dahija](https://www.reddit.com/r/JournalingIsArt/comments/13njgp/1000_prompts/)
- [Psych Central](https://psychcentral.com/blog/30-more-journaling-prompts-for-self-reflection-and-self-discovery#4)
- [Psych Central](https://psychcentral.com/blog/ready-set-journal-64-journaling-prompts-for-self-discovery#getting-unstuck)
