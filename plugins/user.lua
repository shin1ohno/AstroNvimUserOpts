return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  "christoomey/vim-tmux-navigator",
  {
    "keaising/im-select.nvim",
    event = "BufEnter",
    enabled = function()
      return vim.fn.has('macunix') == 1
    end,
    config = function()
      require('im_select').setup {
        set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
        set_previous_events = { "InsertEnter" },
      }
    end
  }
}
