# vindent.vim

`vindent.vim` is a minimal plugin for Vim and Neovim that provides two functionalities:

1. Jump to previous/next line with same indentation. (*vindent motion*)
2. Select adjacent lines with same or more indentation. (*vindent text object*: 4 variations)

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

`vindent.vim` comes with no default keybindings.  So after installation, put
the following lines in your `~/.vimrc`:
```vim
let g:vindent_motion_prev = '[l'
let g:vindent_motion_next = ']l'
let g:vindent_object_ii   = 'ii'
let g:vindent_object_iI   = 'iI'
let g:vindent_object_ai   = 'ai'
let g:vindent_object_aI   = 'aI'
let g:vindent_tabstop     = &tabstop " let vindent.vim know to treeat 1 <Tab> as "tabsop" <Space>s.
```
and enjoy using:

1. **Vindent Motion**: Jump to previous/next with same indentation with `[l`/`]l`.
   ([examples](#vindent-motion-move-to-line-with-same-indentation))
2. **Vindent Text Objects**: Select text with `ii` (*in indent*), `iI` (*in Indent*), `ai` (*an indent*), and `aI` (*an Indent*).
   ([examples](#vindent-text-objects-select-lines-of-text-with-same-indentation))

Feel free to customize the keybindings.

**Note**:

- If you wish not to use a certain functionality, simply leave the corresponding variable undefined.
- If you wish not to treat `<Tab>` as some number of `<Space>`s, leave `g:vindent_tabstop` undefined.
- `[l` and `]l` are commonly used keybindings (e.g., [vim-unimpaired](https://github.com/tpope/vim-unimpaired)), so be sure to change them if you already use those.

For details please refer to the [`doc flie`](./doc/vindent.txt).

## Examples

The following examples assumes that the keybindings in [Usage](#usage) are used.

### Vindent Motion: move to line with same indentation.

This motion is very self explanatory: move to the previous or next line with
the same indentation.  This motion does not move the cursor if the cursor is on
an empty line.  This motion operates on text *line-wise* if it is used as a text object.

Here are some examples.  Consider the LaTeX code:
```tex
 1 \begin{enumerate}
 2
 3     \item
 4
 5         Some sentence that is
 6         split into two lines.
 7
 8     \item
 9         Another sentence here.
10
11 \end{enumerate}
```

- If cursor is on line 3, then `]l` moves it to line 8.
- If cursor is on line 6, then `]l` moves it to line 9.
- If cursor is on line 6, then `[l` moves it to line 5.
- If cursor is on line 1, then `]l` moves it to line 11.
- If cursor is on line 2, then `]l` does not move. (No movement if the line is empty)
- If cursor is on line 5, then `2]l` moves it to line 9. (Takes `{count}`)
- If cursor is on line 3, then `d]l` deletes lines 3 to 8. (As test object)

For more details please refer to the [`doc flie`](./doc/vindent.txt).

### Vindent Text Objects: select lines of text with "same" indentation

The text objects are:

| Text Object | mnemonics   | description                                                                                                                                |
| ---         | ---         | ---                                                                                                                                        |
| `ii`        | *in indent* | select adjacent lines with the same or more indentation.                                                                                   |
| `iI`        | *in Indent* | select adjacent lines with the same indentation.                                                                                           |
| `ai`        | *an indent* | select adjacent lines with the same or more indentation and one extra line with less indentation at the beginning.                         |
| `aI`        | *an Indent* | select adjacent lines with the same or more indentation and two extra line with less indentation: one at the beginning and one at the end. |

For all these object, empty lines are ignored (otherwise why not use `vip` instead?).
Also, this text object selects nothing if there is no indentation on that line (otherwise the entire document would probably be selected).

Here are some examples to clear thing up.  Consider the LaTeX code:
```tex
 1 \begin{enumerate}
 2     \item
 3
 4         Some sentence that is
 5         split into two lines.
 6
 7         \begin{enumerate}
 8             \item This thing.
 9         \end{enumerate}
10
11     \item
12         Another sentence here.
13 \end{enumerate}
```

- If cursor is on line 5,  then `vii` selects lines 4  to 9. (Empty line 6 ignored; Empty lines 3 and 10 not selected)
- If cursor is on line 5,  then `viI` selects lines 4  to 7. (Empty line 6 ignored; Empty line 3 not selected)
- If cursor is on line 12, then `vai` selects lines 11 to 12.
- If cursor is on line 7,  then `vai` selects lines 2  to 9. (Empty lines 3 and 6 ignored; Empty line 10 not selected)
- If cursor is on line 11, then `vaI` selects lines 1  to 14. (Empty lines 3, 6, and 10 ignored)
- If cursor is on line 8,  then `vaI` selects lines 7  to 9.

For more details please refer to the [`doc flie`](./doc/vindent.txt).

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
