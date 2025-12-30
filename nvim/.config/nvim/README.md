# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Personal Mods

in `nvim/lua/plugins/editer-fzf.lua`, i changed the keymap to

```lua
files = {
  cwd_prompt = false,
  actions = {
    -- ["alt-i"] = { actions.toggle_ignore },
    -- ["alt-h"] = { actions.toggle_hidden },
    ["ctrl-I"] = { actions.toggle_ignore },
    ["ctrl-H"] = { actions.toggle_hidden },
  },
},
grep = {
  actions = {
    -- ["alt-i"] = { actions.toggle_ignore },
    -- ["alt-h"] = { actions.toggle_hidden },
    ["ctrl-I"] = { actions.toggle_ignore },
    ["ctrl-H"] = { actions.toggle_hidden },
  },
},
```
