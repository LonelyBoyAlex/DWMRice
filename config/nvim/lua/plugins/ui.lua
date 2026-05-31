-- lua/plugins/ui.lua
return {

  --  ── Theme ──────────────────────────────────────────────────────────
--  {
--    "catppuccin/nvim",
--    name = "catppuccin",
--    priority = 1000,   -- load first
--    config = function()
--      require("catppuccin").setup({
--        flavour = "mocha",
--        background = { light = "latte", dark = "mocha" },
--        transparent_background = true,   -- matches dwm gaps/transparency
--        term_colors = true,
--        integrations = {
--          neo_tree = true,
--          which_key = true,
--          indent_blankline = { enabled = true },
--          bufferline = true,
--          mini = { enabled = true },
--        },
--      })
--      vim.cmd.colorscheme("catppuccin")
--    end,
--  },
{
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      transparent_background = true,
      terminal_colors = true,
      devicons = true,
      filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
      inc_search = "background", -- underline | background
      background_clear = {
        "toggleterm",
        "telescope",
        "renamer",
        "notify",
        "neo-tree",
        "which_key"
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
          underline_fill = false,
          bold = true,
        },
        indent_blankline = {
          context_highlight = "default", -- default | pro
          context_start_underline = false,
        },
      },
    })
    vim.cmd.colorscheme("monokai-pro")
  end,
},

  --   -- ── Statusline ─────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          --theme = "catppuccin-mocha",
          theme = "monokai-pro"
             },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch", "diff", "diagnostics" },
              lualine_c = { { "filename", path = 1 } },   -- relative path
              lualine_x = { "encoding", "fileformat", "filetype" },
              lualine_y = { "progress" },
              lualine_z = { "location" },
            },
          })
        end,
      },

      -- ── Buffer tabs ────────────────────────────────────────────────────
      {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
          require("bufferline").setup({
            options = {
              mode = "buffers",
              separator_style = "slant",
              show_buffer_close_icons = true,
              show_close_icon = false,
              color_icons = true,
              diagnostics = false,
              offsets = {
                {
                  filetype = "neo-tree",
                  text = "  File Explorer",
                  highlight = "Directory",
                  separator = true,
                },
              },
            },
          })
        end,
      },

      -- ── Indent guides ──────────────────────────────────────────────────
      {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
          require("ibl").setup({
            indent = { char = "│" },
            scope = { enabled = true },
          })
        end,
      },

      -- ── Dashboard (start screen) ───────────────────────────────────────
      {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("dashboard").setup({
            theme = "hyper",
            config = {
              header = {
                "",
                "  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                "",
              },
              shortcut = {
                { icon = "󰊳 ", desc = "Lazy update", action = "Lazy update", key = "u" },
                { icon = " ", desc = "New file",    action = "enew",         key = "n" },
                { icon = " ", desc = "Config",      action = "e ~/.config/nvim/init.lua", key = "c" },
                { icon = " ", desc = "Quit",        action = "qa",           key = "q" },
              },
            },
          })
        end,
      },

    }
