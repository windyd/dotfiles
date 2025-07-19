return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {

      ruff = {
        -- lsp: https://docs.astral.sh/ruff/editors/setup/#neovim
        -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ruff.lua
        -- ref: https://github.com/fredrikaverpil/dotfiles/blob/531050b744c215e7b67b71e229709acff53b9da2/nvim-fredrik/lua/fredrik/plugins/lang/python.lua#L88
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            -- https://docs.astral.sh/ruff/editors/settings/
            -- configurationPreference = "filesystemFirst",
            -- lineLength = 80,
            logLevel = "warn",
          },
        },
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      },
      -- TODO: consider change to this
      basedpyright = {
        -- ref: https://github.com/fredrikaverpil/dotfiles/blob/531050b744c215e7b67b71e229709acff53b9da2/nvim-fredrik/lua/fredrik/plugins/lang/python.lua#L88
        -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/basedpyright.lua
        --      ./reference/basedpyright.lua.bak
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        disableOrganizeImports = true, -- deletgate to ruff
        analysis = {
          -- NOTE: uncomment this to ignore linting. Good for projects where
          -- basedpyright lights up as a christmas tree.
          -- ignore = { "*" },
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
      pyright = {},
    },
  },
}
