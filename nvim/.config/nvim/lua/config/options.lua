-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"
--
-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

-- vim.g.lazyvim_blink_main = true
-- vim.g.lazyvim_cmp = "blink.nvim" -- default is "auto"

-- NOTE: 2025-06-06 something wrong with copilot
vim.g.ai_cmp = false

-- NOTE: clipboard handling
local opt = vim.opt

local function is_rocky_linux()
  -- Rocky Linux reliably ships /etc/redhat-release containing "Rocky Linux"
  if vim.fn.filereadable("/etc/redhat-release") ~= 1 then
    return false
  end
  local lines = vim.fn.readfile("/etc/redhat-release")
  local content = table.concat(lines, "\n")
  return content:match("Rocky Linux") ~= nil
end

-- Guard: only apply the SSH OSC52/tmux clipboard override on Rocky Linux hosts.
if is_rocky_linux() then
  if vim.env.SSH_CONNECTION then
    -- OSC52 writer that works inside tmux by wrapping in DCS passthrough.
    local function osc52_tmux_write(text)
      local b64 = vim.base64.encode(text)
      local osc = "\027]52;c;" .. b64 .. "\007"

      if vim.env.TMUX then
        -- tmux passthrough wrapper: DCS tmux; ESC <osc> ST
        return "\027Ptmux;\027" .. osc .. "\027\\"
      end

      return osc
    end

    local function copy(lines)
      local text = table.concat(lines, "\n")
      vim.api.nvim_chan_send(vim.v.stderr, osc52_tmux_write(text))
    end

    vim.g.clipboard = {
      name = "osc52-tmux",
      copy = { ["+"] = copy, ["*"] = copy },
      -- Disable OSC52 read/paste to avoid hangs; paste via terminal (Cmd+V) instead.
      paste = {
        ["+"] = function()
          return {}
        end,
        ["*"] = function()
          return {}
        end,
      },
      cache_enabled = 0,
    }

    -- Make yanks default to + (routes to local clipboard via OSC52).
    opt.clipboard = "unnamedplus"
  else
    -- Local session on Rocky: normal system clipboard integration.
    opt.clipboard = "unnamedplus"
  end
else
  -- Non-Rocky hosts: use LazyVim default behavior.
  opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Sync with system clipboard
end
