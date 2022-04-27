# vindent.vim

vindent.vim is a simple plugin that provides two functionalities that has to do
with indents:

1. Create a *motion* that moves cursor to the previous or next line with the same indentation as the current line.
2. Create three *text object* that selects adjacent lines with the same indentation (with three slight variations).

## Usage

### Mappings

`vindent.vim` provides the following `<Plug>`'s:

1. Motion:
	- `<Plug>(VindentMove_prev_normal)`: move to previous line with same indent in normal mode.
	- `<Plug>(VindentMove_prev_visual)`: move to previous line with same indent in visual mode.
	- `<Plug>(VindentMove_next_normal)`: move to next line with same indent in normal mode.
	- `<Plug>(VindentMove_next_visual)`: move to next line with same indent in visual mode.
2. Text Object:
	- `<PLug>(VindentObject_X_i)`: select text object *indent-i* in visual mode.
	- `<PLug>(VindentObject_X_a)`: select text object *indent-a* in visual mode.
	- `<PLug>(VindentObject_X_I)`: select text object *indent-I* in visual mode.
	- `<PLug>(VindentObject_O_i)`: use *indent-i* as text object with other commands.
	- `<PLug>(VindentObject_O_a)`: use *indent-a* as text object with other commands.
	- `<PLug>(VindentObject_O_I)`: use *indent-I* as text object with other commands.

However, `vindent.vim` provides no default keybindings.
I use the following keybindings:
```vim
" vindent.vim motion
nnoremap <silent> [l <Plug>(VindentMove_prev_normal)
xnoremap <silent> [l <Plug>(VindentMove_prev_visual)
nnoremap <silent> ]l <Plug>(VindentMove_next_normal)
xnoremap <silent> ]l <Plug>(VindentMove_next_visual)
" vindent.vim test object
xnoremap <silent> ii <PLug>(VindentObject_X_i)
xnoremap <silent> ai <PLug>(VindentObject_X_a)
xnoremap <silent> aI <PLug>(VindentObject_X_I)
onoremap <silent> ii <PLug>(VindentObject_O_i)
onoremap <silent> ai <PLug>(VindentObject_O_a)
onoremap <silent> aI <PLug>(VindentObject_O_I)
```
Feel free to use other keybindings and put it in your `.vimrc`.
I'll explain the functionalities with these default keybindings.

### (1) Functionality 1: move to same indentation.

Mapping `[l` moves the
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
If no line with the same indentation is found, then the cursor does not move.

This also works in visual mode, so you can select text with this motion.
Note that this motion ignores empty lines, so if the code looks like this,
```
1 \begin{enumerate}
2
3 	\item I am item 1.
4
5 	\item I am item 2.
6
7 \end{enumerate}
```
the aforementioned motions still work.

### (2) Functionality 2: indentation text objects.

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

Object `ai` is useful in languages like python that uses indentation to specify scopes.
Object `aI` is useful in languages like LaTeX with many opening and closing matching pairs on the same indentation level.
Note that this text object assumes that the indentation is consistent, e.g.,
it would not consider 4 white spaces to be equal to a tab.

Similar to the motion `[l` and `]l`, the three text objects also ignores empty lines.
Consider the following LaTeX code:
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
If the cursor is on line 3 ad you press `vii`, lines 3 to 8 would be selected;
if the cursor is on line 7 and you press `vai`, lines 3 to 7 would be selected.

## Installation

Install using your favourite plugin manager, or use Vim's built-in package support:
```sh
mkdir -p ~/.vim/pack/jessekelighine/start
cd ~/.vim/pack/jessekelighine/start
git clone https://github.com/jessekelighine/vindent.vim
```

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
