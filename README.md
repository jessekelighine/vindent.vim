---
title:  "vindent.vim"
author: "jessekelighine@gmail.com"
date:   "2022-Apr-27"
---

# vindent.vim

`vindent.vim` is a simple plugin that provides two functionalities that have to
do with indentations:

1. Create a *motion* that moves cursor to the previous or next line with the same indentation as the current line.
2. Create three *text object* that selects adjacent lines with the same indentation (with three slight variations).

This plugin was partially inspired by
[vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and
[vim-indent-object](https://github.com/michaeljsmith/vim-indent-object).
`vindent.vim` is essentially a simplified version of the two plugins combined.
Same indent level moving from [vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and all text objects from [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object) are reimplemented,
but with only less than 100 lines of vimscript!

## Installation

Install using your favourite plugin manager, or use Vim's built-in package support:
```sh
mkdir -p ~/.vim/pack/jessekelighine/start
cd ~/.vim/pack/jessekelighine/start
git clone https://github.com/jessekelighine/vindent.vim
```

## Usage

### TL;DR

Put this in your `.vimrc`:
```vim
" vindent.vim motion
nnoremap <silent> [l <Plug>(VindentMove_N_prev)
nnoremap <silent> ]l <Plug>(VindentMove_N_next)
xnoremap <silent> [l <Plug>(VindentMove_X_prev)
xnoremap <silent> ]l <Plug>(VindentMove_X_next)
" vindent.vim test object
xnoremap <silent> ii <PLug>(VindentObject_X_i)
xnoremap <silent> ai <PLug>(VindentObject_X_a)
xnoremap <silent> aI <PLug>(VindentObject_X_I)
onoremap <silent> ii <PLug>(VindentObject_O_i)
onoremap <silent> ai <PLug>(VindentObject_O_a)
onoremap <silent> aI <PLug>(VindentObject_O_I)
```
Move to lines with the same indentation with `[l` and `]l`;
select indentation text objects with `ii` (*in indent*), `ai` (*a indent*), and `aI` (*a Indent*).
Feel free to use other keybindings.

For detailed explanation see [here](#Explanation).

### Mappings

`vindent.vim` provides the following `<Plug>`'s with no default keybindings:

1. Motion:
	- `<Plug>(VindentMove_N_prev)`: move to previous line with same indentation level in normal mode.
	- `<Plug>(VindentMove_X_prev)`: move to previous line with same indentation level in visual mode.
	- `<Plug>(VindentMove_N_next)`: move to next     line with same indentation level in normal mode.
	- `<Plug>(VindentMove_X_next)`: move to next     line with same indentation level in visual mode.
2. Text Object:
	- `<PLug>(VindentObject_O_i)`: use "*in indent*" as text object in combination with Vim verbs.
	- `<PLug>(VindentObject_O_a)`: use "*a indent*"  as text object in combination with Vim verbs. 
	- `<PLug>(VindentObject_O_I)`: use "*a Indent*"  as text object in combination with Vim verbs. 
	- `<PLug>(VindentObject_X_i)`: select text object "*in indent*" in visual mode.
	- `<PLug>(VindentObject_X_a)`: select text object "*a indent*"  in visual mode.
	- `<PLug>(VindentObject_X_I)`: select text object "*a Indent*"  in visual mode.

## Explanation

The following explanation assumes that the default keybindings provided in [TL;DR](#tldr) is used.

### Motion: move to line with same indentation.

Consider the following LaTeX code:
```
1 \begin{enumerate}
2 	\item I am item 1.
3 	\item I am item 2.
4 \end{enumerate}
```
If the cursor is on line 1 and `]l` is pressed,
the cursor will move to the beginning of line 4.
The similar is true for `[l`.
If `]l` is pressed when the cursor is on line 2,
the cursor will move to line 3.
This also works in visual mode, so text can be selected with this motion.

**Notes**

- The motions does nothing (cursor will not move) if the current line is empty.
- The motion assumes that the indentation is consistent.
  E.g., pressing `]l` on a line indented with one tab would not move the cursor
  to a line indented with 4 spaces.
- If no line with the same indentation is found, the cursor will not move.
- The motion ignores empty lines.  So if there is an empty line between line 2
  and 3 in the aforementioned code sample, the motion would still behave as expected.

### Text Objects: select lines of text with "same" indentation

Consider the following LaTeX code:
```
1 \begin{enumerate}
2 	\item
3 		I am an intentionally very very very long
4 		and meaningless sentence.
5 	\item
6 		I am another sentence.
7 \end{enumerate}
```
If the cursor is on line 3 and `vii` is pressed, lines 3 and 4 would be selected;
if `vai` is pressed, lines 2, 3, and 4 would be selected.
If the cursor is on line 2 and `vaI` is pressed, then lines 1 to 7 would be selected.
In summary,

- Object `ii` (*in indent*): select adjacent lines with the same indentation.
- Object `ai` (*a indent*):  select adjacent lines with the same indentation and one extra line with less indentation at the beginning.
- Object `aI` (*a Indent*):  select adjacent lines with the same indentation and two extra line with less indentation: one at the beginning and one at the end.

**Notes**

- Similar to `[l` and `]l`, the text objects assumes that the indentation is consistent.
- Similar to `[l` and `]l`, the text objects ignores empty lines.
- The text objects would not select empty lines at the beginning or the end.
- The text objects would select nothing if the current line is empty or not indented.

The last three points from **Notes** can be demonstrated by the following example in LaTeX:
```
1 \begin{enumerate}
2
3 	\item
4 		I am an intentionally very very very long
5 		and meaningless sentence.
6
7 		And something random here.
8
9 	\item
10 		I am another sentence.
11
12 \end{enumerate}
```
If the cursor is on line 3 and `dii` is pressed, lines 3 to 10 would be deleted;
if the cursor is on line 7 and `dai` is pressed, lines 3 to 7 would be deleted;
if the cursor is on line 1 and `vii` is pressed, nothing would happen (since `\begin{enumerate}` is not indented).

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
