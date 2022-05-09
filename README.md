# vindent.vim

`vindent.vim` is a minimal plugin for Vim and Neovim that provides three functionalities:

1. Jump to previous/next line with *same*, *less*, *more* or *different* indentation. (**vindent motions**)
2. Jump to previous/next "text block" with *same* (in some sense) indentation. (**vindent block motions**: 4 variations)
3. Select adjacent lines with same or more indentation. (**vindent text object**: 4 variations)

This plugin was partially inspired by [vim-indentwise](https://github.com/jeetsukumaran/vim-indentwise)
and [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object).
`vindent.vim` is essentially a simplified version of the two plugins combined,
but reimplemented with about *200 lines* of vimscript!

You can also find this plugin on [vim.org](https://www.vim.org/scripts/script.php?script_id=6016).

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
let g:vindent_motion_same_prev = '[='
let g:vindent_motion_same_next = ']='
let g:vindent_motion_less_prev = '[-'
let g:vindent_motion_less_next = ']-'
let g:vindent_motion_more_prev = '[+'
let g:vindent_motion_more_next = ']+'
let g:vindent_motion_diff_prev = '[;'
let g:vindent_motion_diff_next = '];'
let g:vindent_blockmotion_OO_prev = '[1'
let g:vindent_blockmotion_OO_next = ']1'
let g:vindent_blockmotion_XO_prev = '[2' " you probably don't need this...
let g:vindent_blockmotion_XO_next = ']2' " you probably don't need this...
let g:vindent_blockmotion_OX_prev = '[3' " you probably don't need this...
let g:vindent_blockmotion_OX_next = ']3' " you probably don't need this...
let g:vindent_blockmotion_XX_prev = '[4' " you probably don't need this...
let g:vindent_blockmotion_XX_next = ']4' " you probably don't need this...
let g:vindent_object_ii = 'ii'
let g:vindent_object_iI = 'iI'
let g:vindent_object_ai = 'ai'
let g:vindent_object_aI = 'aI'
let g:vindent_tabstop   = &tabstop " let vindent know to treat 1 <Tab> as tabstop # of <Spaces>s.
```
and enjoy using:

1. **Vindent Motions**: ([examples](#vindent-motion))
	- Jump to previous/next with same indentation with `[=`/`]=`.
	- Jump to previous/next with less indentation with `[-`/`]-`.
	- Jump to previous/next with more indentation with `[+`/`]+`.
	- Jump to previous/next with different indentation with `[;`/`];`.
2. **Vindent Block Motions**: ([examples](#vindent-block-motion))
	- Jump to previous/next text block with the same indentation with `[1`/`]1`.
3. **Vindent Text Objects**: Select text with `ii` (*in indent*), `iI` (*in Indent*), `ai` (*an indent*), and `aI` (*an Indent*).
   ([examples](#vindent-text-object))

Feel free to customize the keybindings.

**Note**:

- If you wish not to use a certain functionality, simply leave the corresponding variable undefined.
- If you wish not to treat `<Tab>` as some number of `<Space>`s, leave `g:vindent_tabstop` undefined.

For details please refer to the [`doc flie`](./doc/vindent.txt).

## Examples

### Vindent Motion

This motion is very self explanatory: move to the previous or next line with
either *same*, *less*, *more*, or *different* indentation.  This motion does
not move the cursor if the cursor is on an empty line.  This motion operates on
text *line-wise* if it is used as a text object.

Here are some examples.  Assume that the keybindings in [Usage](#usage) are
used and consider the LaTeX code:

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
- If the cursor is on line 6,  `[=`  moves it to line 5.
- If the cursor is on line 9,  `[=`  moves it to line 6.
- If the cursor is on line 1,  `]=`  moves it to line 11.
- If the cursor is on line 5,  `2]=` moves it to line 9. (Takes `{count}`)
- If the cursor is on line 3,  `d]=` deletes lines 3 to 8. (As text object)
- If the cursor is on line 6,  `[-`  moves it to line 3. (Less indentation)
- If the cursor is on line 1,  `]+`  moves it to line 3. (More indentation)
- If the cursor is on line 11, `[+`  moves it to line 9.
- If the cursor is on line 3,  `];`  moves it to line 5. (Different indentation)
- If the cursor is on line 5,  `];`  moves it to line 8. (Different indentation)

For more details please refer to the [`doc flie`](./doc/vindent.txt).

### Vindent Block Motion

This motion moves the cursor to the previous or next "text block" of the same
indentation as the current line.  `vindent.vim` provides 4 variations of this
motion since there are some subtleties in defining a "text block".

The 4 variations are all named as `vindent_blockmotion_<A1><A2>` where `<A1>`
and `<A2>` can be either `O` (for YES) or `X` (for NO):

- `<A1>` indicates whether "empty lines" are considered boundaries of a text block.
- `<A2>` indicates whether "lines with *more* indentation" are considered boundaries of a text block.

Here are some examples to clear things up.  Assume that the keybindings in
[Usage](#usage) are used and consider the LaTeX code:

```tex
 1 \begin{document}
 2 
 3 I am the first sentence
 4 \begin{enumerate}
 5     \item
 6 
 7     \item
 8         I am a sentence
 9     \item
10 \end{enumerate}
11     I am an incorrectly indented sentence.
12 I am one last sentence.
13 
14 \end{document}
```

If the cursor is on line 1, then pressing...

- `]1` 4 times move cursor to line 3, 10, 12, and 14.
- `]2` 2 times move cursor to line 10 and 12. (lines 1 to 3 are considered to be 1 text block)
- `]3` 3 times move cursor to line 3, 10, and 14. (lines 10 to 12 are considered to be 1 text block)
- `]4` does no move the cursor since lines 1 to 13 are
  considered to be one whole text block.  If the cursor is
  on line 5, then `]4` moves it to line 11.

If the cursor is on line 10, then pressing...

- `[1` moves cursor to line 4. (moves to the end of previous text block)

**Note**: I believe `vindent_blockmotion_OO` is what most people want, since
every breakage of continuous lines with same indentation are considered a
boundary.  Also, in many cases, `[1`/`]1` can be much more useful than `[=`/`]=`.
You might not even need `[=`/`]=`!

### Vindent Text Object

The text objects are:

| Text Object | mnemonics   | description                                                                                                                                |
| ---         | ---         | ---                                                                                                                                        |
| `ii`        | *in indent* | select adjacent lines with the same or more indentation.                                                                                   |
| `iI`        | *in Indent* | select adjacent lines with the same indentation.                                                                                           |
| `ai`        | *an indent* | select adjacent lines with the same or more indentation and one extra line with less indentation at the beginning.                         |
| `aI`        | *an Indent* | select adjacent lines with the same or more indentation and two extra line with less indentation: one at the beginning and one at the end. |

For all these object, empty lines are ignored (otherwise why not use `vip` instead?).
Also, this text object selects nothing if there is no indentation on that line (otherwise the entire document would probably be selected).

Here are some examples to clear things up.  Assume that the keybindings in
[Usage](#usage) are used and consider the LaTeX code:

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
- If cursor is on line 1, `vii`, `viI`, `vai`, and `vaI` all select nothing. (Since line 1 is not indented)

For more details please refer to the [`doc flie`](./doc/vindent.txt).

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
