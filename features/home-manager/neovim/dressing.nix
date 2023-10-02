{ ... }: ''
  require("dressing").setup({
    input = {
      win_options = {
        winblend = 0,
      },
    },
    select = {
      backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
      builtin = {
        relative = "cursor",
        win_options = {
          winblend = 0,
        },
        mappings = {
          ["q"] = "Close",
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
        },
      },
    },
  })
''
