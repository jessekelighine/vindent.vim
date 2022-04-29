# vindent.vim

`vindent.vim` is a simple plugin for Vim and Neovim that provides two functionalities that have to
do with indentations:

1. Creates a *vindent motion* that moves cursor to the previous or next line with the same indentation as the current line.
2. Creates three *vindent text object* that selects adjacent lines with the same indentation (with three slight variations).

This plugin was partially inspired by
[vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and
[vim-indent-object](https://github.com/michaeljsmith/vim-indent-object).
`vindent.vim` is essentially a simplified version of the two plugins combined.
Same indent level jumping from [vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and all text objects from [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)
are reimplemented here with less than *100 lines* of vimscript!

## Installation

Install using your favourite plugin manager, or use Vim's built-in package
support:
```sh
mkdir -p ~/.vim/pack/jessekelighine/start
cd ~/.vim/pack/jessekelighine/start
git clone https://github.com/jessekelighine/vindent.vim
```

## Usage

### TL;DR

1. **Vindent Motion**: Move to lines with the same indentation with `[l` and `]l`.
   (more [details](#vindent-motion-move-to-line-with-same-indentation))
2. **Vindent Text Objects**: Use text objects with `ii` (*in indent*),
   `ai` (*a indent*), and `aI` (*a Indent*).
   (more [details](#vindent-text-objects-select-lines-of-text-with-same-indentation))

### Mappings

`vindent.vim` provides the following `<Plug>`s:

1. **Vindent Motions:**

| Plug                         | description                                                 |
| ---                          | ---                                                         |
| `<Plug>(VindentMove_N_prev)` | move to previous line with same indent level. (normal mode) |
| `<Plug>(VindentMove_N_next)` | move to next     line with same indent level. (normal mode) |
| `<Plug>(VindentMove_X_prev)` | move to previous line with same indent level. (visual mode) |
| `<Plug>(VindentMove_X_next)` | move to next     line with same indent level. (visual mode) |
| `<Plug>(VindentMove_O_prev)` | move to previous line with same indent level. (text object) |
| `<Plug>(VindentMove_O_next)` | move to next     line with same indent level. (text object) |

2. **Vindent Text Objects:**

| Plug                         | description                              |
| ---                          | ---                                      |
| `<PLug>(VindentObject_X_ii)` | select text "*in indent*". (visual mode) |
| `<PLug>(VindentObject_X_ai)` | select text "*a indent*".  (visual mode) |
| `<PLug>(VindentObject_X_aI)` | select text "*a Indent*".  (visual mode) |
| `<PLug>(VindentObject_O_ii)` | use "*in indent*" as text object.        |
| `<PLug>(VindentObject_O_ai)` | use "*a indent*"  as text object.        |
| `<PLug>(VindentObject_O_aI)` | use "*a Indent*"  as text object.        |

The default keybindings are defined in `plugin/vindent.vim` as follows:
```vim
" Default Keybindings: vindent motion.
nnoremap <silent> [l <Plug>(VindentMove_N_prev)
nnoremap <silent> ]l <Plug>(VindentMove_N_next)
xnoremap <silent> [l <Plug>(VindentMove_X_prev)
xnoremap <silent> ]l <Plug>(VindentMove_X_next)
onoremap <silent> [l <Plug>(VindentMove_O_prev)
onoremap <silent> ]l <Plug>(VindentMove_O_next)
" Default Keybindings: vindent text object.
xnoremap <silent> ii <PLug>(VindentObject_X_ii)
xnoremap <silent> ai <PLug>(VindentObject_X_ai)
xnoremap <silent> aI <PLug>(VindentObject_X_aI)
onoremap <silent> ii <PLug>(VindentObject_O_ii)
onoremap <silent> ai <PLug>(VindentObject_O_ai)
onoremap <silent> aI <PLug>(VindentObject_O_aI)
```
Feel free to change them directly.

## Explanation

### Vindent Motion: move to line with same indentation.

Consider the LaTeX code:
```tex
\begin{enumerate}       % line 1  ┐ ]l
    \item I am item 1.  % line 2  │  ┐ ]l
    \item I am item 2.  % line 3  │ <┘
\end{enumerate}         % line 4 <┘
```
If the cursor is on line 1 and `]l` is pressed,
the cursor will move to the beginning of line 4.
The similar is true for `[l`.
If `]l` is pressed when the cursor is on line 2,
the cursor will move to line 3.
Vindent motion also works in visual mode and as a text object,
i.e., you can `V]l` or `d]l` or do anything similar.

**Notes**: Some quirks about vindent motion:

- Vindent motion does nothing (cursor will not move) if the current line is empty.
- Vindent motion assumes that the indentation is consistent.
  E.g., pressing `]l` on a line indented with one tab would not move the cursor
  to a line indented with 4 spaces.
- Vindent motion ignores empty lines.  If there is an empty line between line 2
  and 3 in the aforementioned code sample, vindent motion would still behave as
  expected.
- If no line with the same indentation is found, the cursor will not move.
- If being used as a text object, `d]l` deletes entire lines.  Similar for `c`.

### Vindent Text Objects: select lines of text with "same" indentation

Consider the LaTeX code:
```tex
\begin{enumerate}                            % line 1             ┐
    \item                                    % line 2       ┐     │ vaI
        I am an a sentence that was          % line 3 ┐ vii │ vai │
        intentionally split into two lines.  % line 4 ┘     ┘     │
    \item                                    % line 5             │
        I am another sentence.               % line 6             │
\end{enumerate}                              % line 7             ┘
```
If the cursor is on line 3 and `vii` is pressed, lines 3 and 4 would be selected;
if `vai` is pressed, lines 2, 3, and 4 would be selected.
If the cursor is on line 2 and `vaI` is pressed, then lines 1 to 7 would be selected.
In summary,

| Text Object | mnemonics   | description                                                                                                                                |
| ---         | ---         | ---                                                                                                                                        |
| `ii`        | *in indent* | select adjacent lines with the same or more indentation.                                                                                   |
| `ai`        | *a indent*  | select adjacent lines with the same or more indentation and one extra line with less indentation at the beginning.                         |
| `aI`        | *a Indent*  | select adjacent lines with the same or more indentation and two extra line with less indentation: one at the beginning and one at the end. |

**Notes**: Some quirks about vindent text objects:

- Similar to `[l` and `]l`, vindent text objects assumes that the indentation is consistent.
- Similar to `[l` and `]l`, vindent text objects ignores empty lines.
- Vindent text objects would not select empty lines at the beginning or the end.
- Vindent text objects would select nothing if the current line is either *empty* or *not indented*.

The last three points from **Notes** can be demonstrated by the following example in LaTeX:
```tex
\begin{enumerate}                         % line 1 vii
                                          % line 2
    \item                                 % line 3  ┐     ┐ dii
        I am an intentionally very long   % line 4  │     │
        and meaningless sentence.         % line 5  │     │
                                          % line 6  │     │
        And something random here.        % line 7  ┘ dai │
                                          % line 8        │
    \item                                 % line 9        │
        I am another sentence.            % line 10       ┘
                                          % line 11
\end{enumerate}                           % line 12
```
If the cursor is on line 3 and `dii` is pressed, lines 3 to 10 would be deleted.
If the cursor is on line 7 and `dai` is pressed, lines 3 to 7  would be deleted.
If the cursor is on line 1 and `vii` is pressed, nothing would happen (since `\begin{enumerate}` is not indented).

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
