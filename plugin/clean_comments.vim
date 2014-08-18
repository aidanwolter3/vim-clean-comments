" Author:      Aidan Wolter
" Plugin:      Clean Comments
" Description: Inserts pretty comments to help with organization.
"              Comments extend to width of 70 characters or what
"              is specified in g:clean_comment_width.
"
" Mappings:    <Leader>cf -> comment for function
"                   /************************
"                   *
"                   * function_name
"                   *
"                   ************************/
"
"              <Leader>cs -> comment for section
"                   /*-----------------------
"                   section_name
"                   -----------------------*/

" make sure that this plugin does not get loaded multiple times
if exists("g:loaded_clean_comments")
  finish
endif
let g:loaded_clean_comments = 1

" map the functions only if the user has not already done so
if !hasmapto('<Plug>clean_comments_add_function_comment')
  map <unique> <Leader>cf <Plug>clean_comments_add_function_comment
endif
if !hasmapto('<Plug>clean_comments_add_section_comment')
  map <unique> <Leader>cs <Plug>clean_comments_add_section_comment
endif

" map the plugin calls to the script specific functions then onto the functions
noremap <unique> <script> <Plug>clean_comments_add_function_comment <SID>add_function_comment
noremap <SID>add_function_comment :call <SID>add_function_comment()<CR>
noremap <unique> <script> <Plug>clean_comments_add_section_comment <SID>add_section_comment
noremap <SID>add_section_comment :call <SID>add_section_comment()<CR>

" add menu items
noremenu <script> Plugin.Add\ Function\ Comment  <SID>add_function_comment
noremenu <script> Plugin.Add\ Section\ Comment  <SID>add_section_comment

" global variables
if !exists("g:clean_comment_width")
  let g:clean_comment_width=70
endif


function s:add_function_comment()

  " enter a line above with same indent level and an 'a' to keep the indent
  exe "normal Oa\<Esc>"

  " save the format options and remove comment auto formatting
  let s:save_fo = &formatoptions
  set formatoptions-=cro

  " build the comment
  let n = g:clean_comment_width-col('.')
  let comment_head = '/' . repeat('*', n)
  let comment_foot = repeat('*', n) . '/'

  " write the comment
  exe "normal i" . comment_head ."\n" ."*\n" . "*\n" . "*\n" . comment_foot . "\<Esc>"

  " remove the 'a' character inserted above
  exe "normal lx"

  " move the cursor to the proper place within the comment
  exe "normal kka function_name\<Esc>b"

  " restore format options
  let formatoptions = s:save_fo
  unlet s:save_fo

  ec "Added a Function Comment"
endfunction
 

function s:add_section_comment()

  " enter a line above with same indent level and an 'a' to keep the indent
  exe "normal Oa\<Esc>"

  " save the format options and remove comment auto formatting
  let s:save_fo = &formatoptions
  set formatoptions-=cro

  " build the comment
  let n = g:clean_comment_width-col('.')
  let comment_head = '/*' . repeat('-', n-1)
  let comment_foot = repeat('-', n-1) . '*/'

  " write the comment
  exe "normal i" . comment_head ."\n". "\n" . comment_foot . "\<Esc>"

  " remove the 'a' character inserted above
  exe "normal lx"

  " move the cursor to the proper place within the comment
  exe "normal kasection_name\<Esc>b"

  " restore format options
  let formatoptions = s:save_fo
  unlet s:save_fo

  ec "Added a Section Comment"
endfunction
