-- https://github.com/folke/snacks.nvim/blob/main/docs/image.mdhttps://github.com/folke/snacks.nvim/blob/main/docs/image.md
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {
      -- your image configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    gitbrowse = {
      -- "repo" | "branch" | "file" | "commit" | "permalink"
      what = "permalink",
    },
  },
}
