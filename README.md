# vindent.vim

`vindent.vim` is a minimal plugin for Vim and Neovim that provides two functionalities:

1. Jump to previous/next line with same indentation. (*vindent motion*)
2. Select adjacent lines with same or more indentation. (*vindent text object*: 3 variations)

This plugin was partially inspired by [vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object).
`vindent.vim` is essentially a simplified version of the two plugins combined,
but reimplemented with less than *100 lines* of vimscript!

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

After installation, put the following lines in your `~/.vimrc`:
```vim
let g:vindent_motion_prev='[l'
let g:vindent_motion_next=']l'
let g:vindent_object_ii='ii'
let g:vindent_object_ai='ai'
let g:vindent_object_aI='aI'
```
and enjoy using:

1. **Vindent Motion**: Jump to previous/next with same indentation with `[l`/`]l`.
   ([explanation](#vindent-motion-move-to-line-with-same-indentation))
2. **Vindent Text Objects**: Select text with `ii` (*in indent*), `ai` (*an indent*), and `aI` (*an Indent*).
   ([explanation](#vindent-text-objects-select-lines-of-text-with-same-indentation))

**Note**: The mapping `[l` and `]l` are also used in [vim-unimpaired](https://github.com/tpope/vim-unimpaired),
so be sure you change them if you also use [vim-unimpaired](https://github.com/tpope/vim-unimpaired).

### Keybindings

`vindent.vim` comes with no default keybindings.
You can set keybindings using the following variables:

| variable name           | description                                                    |
| ---                     | ---                                                            |
| `g:vindent_motion_prev` | keybinding to move to the previous line with same indentation. |
| `g:vindent_motion_next` | keybinding to move to the next     line with same indentation. |
| `g:vindent_object_ii`   | keybinding to select text object "*in indent*".                |
| `g:vindent_object_ai`   | keybinding to select text object "*an indent*".                |
| `g:vindent_object_aI`   | keybinding to select text object "*an Indent*".                |

An example of use is provided in [TL;DR](#tldr).
If you wish not to use a certain functionality,
simply leave the corresponding variable undefined.

Alternatively, you can create mappings directly by using the `<Plug>`s provided.
`vindent.vim` provides the following `<Plug>`s:

1. **Vindent Motions:**

| Plug                         | description                                                 |
| ---                          | ---                                                         |
| `<Plug>(VindentMove_N_prev)` | (normal mode) move to previous line with same indent level. |
| `<Plug>(VindentMove_N_next)` | (normal mode) move to next     line with same indent level. |
| `<Plug>(VindentMove_X_prev)` | (visual mode) move to previous line with same indent level. |
| `<Plug>(VindentMove_X_next)` | (visual mode) move to next     line with same indent level. |
| `<Plug>(VindentMove_O_prev)` | (text object) move to previous line with same indent level. |
| `<Plug>(VindentMove_O_next)` | (text object) move to next     line with same indent level. |

2. **Vindent Text Objects:**

| Plug                         | description                              |
| ---                          | ---                                      |
| `<PLug>(VindentObject_X_ii)` | (visual mode) select text "*in indent*". |
| `<PLug>(VindentObject_X_ai)` | (visual mode) select text "*an indent*". |
| `<PLug>(VindentObject_X_aI)` | (visual mode) select text "*an Indent*". |
| `<PLug>(VindentObject_O_ii)` | use "*in indent*" as text object.        |
| `<PLug>(VindentObject_O_ai)` | use "*an indent*" as text object.        |
| `<PLug>(VindentObject_O_aI)` | use "*an Indent*" as text object.        |

These definitions can be found in [`plugin/vindent.vim`](./plugin/vindent.vim).

## Explanation

The following explanation assumes that the keybindings in [TL;DR](#tldr) are used.

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
        I am a sentence that was             % line 3 ┐ vii │ vai │
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
| `ai`        | *an indent* | select adjacent lines with the same or more indentation and one extra line with less indentation at the beginning.                         |
| `aI`        | *an Indent* | select adjacent lines with the same or more indentation and two extra line with less indentation: one at the beginning and one at the end. |

**Notes**: Some quirks about vindent text objects:

- Similar to `[l` and `]l`, vindent text objects assumes that the indentation is consistent.
- Similar to `[l` and `]l`, vindent text objects ignores empty lines.
- Vindent text objects would not select empty lines at the beginning or the end.
- Vindent text objects would select nothing if the current line is either *empty* or *not indented*.

The last three points from **Notes** can be demonstrated by the following example in LaTeX:
```tex
\begin{enumerate}                         % line 1 vii    ┐   
                                          % line 2        │   
    \item                                 % line 3  ┐     │     ┐ dii
        I am an intentionally very long   % line 4  │     │     │
        and meaningless sentence.         % line 5  │     │     │
                                          % line 6  │     │     │
        And something random here.        % line 7  ┘ dai │     │
                                          % line 8        │     │
    \item                                 % line 9        │ cai │
        I am another sentence.            % line 10       ┘     ┘
                                          % line 11
\end{enumerate}                           % line 12
```
If the cursor is on line 3 and `dii` is pressed, lines 3 to 10 would be deleted.
If the cursor is on line 9 and `cai` is pressed, lines 1 to 10 would be changed.
If the cursor is on line 7 and `dai` is pressed, lines 3 to 7  would be deleted.
If the cursor is on line 1 and `vii` is pressed, nothing would happen (since `\begin{enumerate}` is not indented).

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
