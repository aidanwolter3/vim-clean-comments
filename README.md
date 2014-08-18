#clean_comments.vim
Quickly insert beautiful comments in VIM. All comments will extend to a width of 70 characters by default.

##Installation
Please use [pathogen.vim](https://github.com/tpope/vim-pathogen) by cloning this repo into your bundle folder.
```
cd ~/.vim/bundle
git clone git@github.com:aidanwolter3/vim-clean-comments.git
```

##Mappings

**< Leader >cf**

comment a function
```
/*********************************************************************
*
* function_name
*
*********************************************************************/
```

**< Leader >cs**

comment a section
```
/*--------------------------------------------------------------------
section_name
--------------------------------------------------------------------*/
```

**Note:** < Leader > is **\\** by default but can be set with `:let mapleader = [new_keystroke]`


##Customization

Comment width can be changed with `let g:clean_comment_width=80`
