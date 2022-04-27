# vindent.vim

`vindent.vim` is a simple plugin that provides two functionalities that has to
do with indents:

1. Create a *motion* that moves cursor to the previous or next line with the same indentation as the current line.
2. Create three *text object* that selects adjacent lines with the same indentation (with three slight variations).

This plugin was partially inspired by
[vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and
[vim-indent-object](https://github.com/michaeljsmith/vim-indent-object).
`vindent.vim` is basically a simplified version of the two plugins combined,
reimplemented with very little vimscript (less than 100 lines!).

## Installation

Install using your favourite plugin manager, or use Vim's built-in package support:
```sh
mkdir -p ~/.vim/pack/jessekelighine/start
cd ~/.vim/pack/jessekelighine/start
git clone https://github.com/jessekelighine/vindent.vim
```

## Usage

### TL;DR

Put this in your `.vimrc`
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
and move to lines with the same indentation with `[l` and `]l`;
select indentation text objects with `ii` (*in indent*), `ai` (*a indent*), and `aI` (*a Indent*).
Feel free to use other keybindings.

For detailed explanation see [here](#Explanation).

### Mappings

`vindent.vim` provides the following `<Plug>`'s with no default keybindings:

1. Motion:
	- `<Plug>(VindentMove_N_prev)`: move to previous line with same indent in normal mode.
	- `<Plug>(VindentMove_X_prev)`: move to previous line with same indent in visual mode.
	- `<Plug>(VindentMove_N_next)`: move to next line with same indent in normal mode.
	- `<Plug>(VindentMove_X_next)`: move to next line with same indent in visual mode.
2. Text Object:
	- `<PLug>(VindentObject_O_i)`: use "*in indent*" as text object in combination with Vim verbs.
	- `<PLug>(VindentObject_O_a)`: use "*a indent*" as text object in combination with Vim verbs. 
	- `<PLug>(VindentObject_O_I)`: use "*a Indent*" as text object in combination with Vim verbs. 
	- `<PLug>(VindentObject_X_i)`: select text object "*in indent*" in visual mode.
	- `<PLug>(VindentObject_X_a)`: select text object "*a indent*" in visual mode.
	- `<PLug>(VindentObject_X_I)`: select text object "*a Indent*" in visual mode.

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
Say the cursor is on line 1 and you press `]l`,
the cursor will be moved to the beginning of line 4.
The similar is true for `[l`.
If you press `]l` when the cursor is on line 2,
then the cursor will move to line 3.
This also works in visual mode, so you can select text with this motion.

**Notes**

- The motions does nothing if the current line is empty.
- The motion assumes that the indentation is consistent. E.g., 4 spaces would not be considered to be equal to a tab.
- If no line with the same indentation is found, the cursor will not move.
- The motion ignores empty lines. So if there is an empty line between line 2
  and 3 in the aforementioned code sample, the motions still work as expected.

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
If the cursor is on line 3 and you press `vii`, you would select the lines 3 and 4;
if you press `vai`, you would select lines 2, 3, and 4.
If the cursor is on line 2 and you press `vaI`, then lines 1 to 7 would be selected.
In summary,

- Object `ii` (*in indent*): select adjacent lines with the same indentation.
- Object `ai` (*a indent*): select adjacent lines with the same indentation and one extra line with less indentation at the beginning.
- Object `aI` (*a Indent*): select adjacent lines with the same indentation and two extra line with less indentation: one at the beginning and one at the end.

**Notes**

- Similar to `[l` and `]l`, the text objects assumes that the indentation is consistent.
- Similar to `[l` and `]l`, the text objects ignores empty lines.
- The text objects would not select empty lines at the beginning or the end.
- The text objects would select nothing if the current line is empty or not indented.

The notes can be summarized by the following example in LaTeX:
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
If the cursor is on line 3 ad you press `dii`, lines 3 to 10 would be deleted;
if the cursor is on line 7 and you press `dai`, lines 3 to 7 would be deleted;
if the cursor is on line 1 and you press `vii`, nothing would happen.

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
