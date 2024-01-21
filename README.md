# NOTE: Use Treesitter Instead!
[Evergreen](https://github.com/TorchedSammy/Evergreen.lxl) is an implementation of Treesitter syntax highlighting for Lite XL,
and will be much better than what Lite XL's language plugins can provide. As such, Lazulight is now unmaintained.

# Lazulight.lxl
> Lite XL language plugins with more specific highlight groups/types.

Lazulight is a collection of Lite XL languages with additional
highlight types to have more colors for specific parts of language
syntax.

This is to address issue [#1000], and the hope is that the the language
plugins here will be upstreamed.

[#1000]: https://github.com/lite-xl/lite-xl/issues/1000

> This is work in progress! The highlight groups may change
sporadically.

# Supported Languages
- [x] Go
- [ ] Lua (partially)

If you want more languages, make an issue.

## Highlight Groups
Lazulight language plugins will offer these additional highlight groups:  
- `function_builtin`: A builtin function
- `type`: Type declaration
- `type_builtin`: Builtin type declaration
- `parameter`: Function parameter
- `constant`: A constant value
- `field`: A table/struct field
- `conditional`: Conditional keywords (if, else)
- `variable`: A variable
- `variable_builtin`: A known variable (builtin)

## Installation
Simply git clone to your plugins directory. Lazulight will load up
all the plugins automatically.

# LICENSE
MIT
