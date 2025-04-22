return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
   
  { "chrisgrieser/nvim-genghis" },
-- nvim v0.8.0
 {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
},
{ "nvchad/volt" , lazy = true },
{ "nvchad/menu" , lazy = true },
{'tzachar/cmp-ai', dependencies = 'nvim-lua/plenary.nvim'},
{'hrsh7th/nvim-cmp', dependencies = {'tzachar/cmp-ai'}},
{
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
        set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)

        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<c-q>", mc.toggleCursor)
        -- Pressing `gaip` will add a cursor on each line of a paragraph.
        set("n", "ga", mc.addCursorOperator)
    
        -- Clone every cursor and disable the originals.
        set({"n", "x"}, "<leader><c-q>", mc.duplicateCursors)
        
        -- Align cursor columns.
        set("n", "<leader>a", mc.alignCursors)
        
        -- Split visual selections by regex.
        set("x", "S", mc.splitCursors)
        
        -- match new cursors within visual selections by regex.
        set("x", "M", mc.matchCursors)
        
        -- bring back cursors if you accidentally clear them
         set("n", "<leader>gv", mc.restoreCursors)
        
        -- Add a cursor for all matches of cursor word/selection in the document.
        set({"n", "x"}, "<leader>A", mc.matchAllAddCursors)
        
        -- Rotate the text contained in each visual selection between cursors.
        set("x", "<leader>t", function() mc.transposeCursors(1) end)
        set("x", "<leader>T", function() mc.transposeCursors(-1) end)

        -- Append/insert for each line of visual selections.
        -- Similar to block selection insertion.
        set("x", "I", mc.insertVisual)
        set("x", "A", mc.appendVisual)
 
 -- Increment/decrement sequences, treaing all cursors as one sequence.
        set({"n", "x"}, "g<c-a>", mc.sequenceIncrement)
        set({"n", "x"}, "g<c-x>", mc.sequenceDecrement)

-- Add a cursor and jump to the next/previous search result.
        set("n", "<leader>/n", function() mc.searchAddCursor(1) end)
        set("n", "<leader>/N", function() mc.searchAddCursor(-1) end)

        -- Jump to the next/previous search result without adding a cursor.
        set("n", "<leader>/s", function() mc.searchSkipCursor(1) end)
        set("n", "<leader>/S", function() mc.searchSkipCursor(-1) end)
        -- Add a cursor to every search result in the buffer.
        set("n", "<leader>/A", mc.searchAllAddCursors)
        
        -- Pressing `<leader>miwap` will create a cursor in every match of the
        -- string captured by `iw` inside range `ap`.
        -- This action is highly customizable, see `:h multicursor-operator`.
        set({"n", "x"}, "<leader>m", mc.operator)
        -- Add or skip adding a new cursor by matching diagnostics.
        set({"n", "x"}, "]d", function() mc.diagnosticAddCursor(1) end)
        set({"n", "x"}, "[d", function() mc.diagnosticAddCursor(-1) end)
        set({"n", "x"}, "]s", function() mc.diagnosticSkipCursor(1) end)
        set({"n", "x"}, "[S", function() mc.diagnosticSkipCursor(-1) end)
        -- Press `mdip` to add a cursor for every error diagnostic in the range `ip`.
        set({"n", "x"}, "md", function()
    -- See `:h vim.diagnostic.GetOpts`.
    mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR })
    end)
        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)

            -- Delete the main cursor  .
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
},
{
  'vyfor/cord.nvim',
   build = ':Cord update',
    event = 'VeryLazy'
  -- opts = {}
},
{ 
    'IogaMaster/neocord',
    event = "VeryLazy"
},
{
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
},
{
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim"
    }
},
-- lazy.nvim
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
},

 {
    "neovim/nvim-lspconfig",
     dependencies = { 'saghen/blink.cmp' },
   config = function()
    require "configs.lspconfig"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work! 

  ---@type LazySpec
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory" ,
    },
    {
      -- NOTE: this requires a version of yazi that includes
      -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      '<c-up>',
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
},

 {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false, -- force immediate loading
    -- Still restrict commands if needed by filetype:
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- You can use either mini.nvim or nvim-web-devicons:
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup {
        file_types = { "markdown" }, -- ensure this matches your buffers
        log_level = "debug", -- for more detailed logs
      }
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },
  {
    "mattn/emmet-vim",
    lazy = false, -- Ensures Emmet loads on start
  },
   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css", "javascript"
   		},
   	},
   },
}
