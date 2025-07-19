return {
  "augmentcode/augment.vim",
  -- ref: https://github.com/vyorkin/nvim/blob/664db68951b249526cff46a22f0d8ed475662212/lua/plugins/augment.lua
  -- ref: https://github.com/arthur404dev/dotfiles/blob/108cb1c71a56b15469f60ef621d7d00948824eff/.config/nvim/lua/plugins/ai.lua
  init = function()
    vim.g.augment_disable_completions = true
    vim.g.augment_disable_tab_mapping = true
  end,
  enabled = function()
    local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
    local file = cwd .. "/.augmentignore"
    local enabled = vim.loop.fs_stat(file) ~= nil
    return enabled
  end,
  config = function()
    local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
    vim.g.augment_workspace_folders = { cwd }
    -- key binds
  end,
}
