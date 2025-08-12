return {

  -- 🌈 Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          cmp = true,
          treesitter = true,
          native_lsp = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- 🔌 Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
  },

  -- 🧠 LSP support
  { "neovim/nvim-lspconfig" },

  -- 🪄 Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- 📁 File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    end,
  },

  -- 🔍 Telescope Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- 🧙 Which-Key
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- 🌳 Treesitter: syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "python", "lua", "json", "markdown",
          "bash", "html", "css", "javascript"
        },
      })
    end,
  },

  -- 💄 Lualine: statusline
  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = { theme = "catppuccin" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          function()
            local filename = vim.fn.expand("%:t")
            if filename == "" then
              return "[Louix]"
            end
            return filename
          end,
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
  },

  -- 🛠 Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          python = { "black" },
          lua = { "stylua" },
          javascript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
        },
      })
    end,
  },

  -- 🐛 Debugger (DAP)
  { "mfussenegger/nvim-dap" },

  -- 📄 Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },

  -- 📁 Project Manager for Telescope
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
      require("telescope").load_extension("projects")
    end,
  },

  -- 🔧 LazyGit UI
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })
    end,
  },

  -- 📈 Neogit Git UI
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup({})
      vim.keymap.set("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true })
    end,
  },
}

