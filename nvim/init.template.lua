-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--
-- TODO: TODO is colored strangely in other source files.
-- - Need to look into Spellsitter (for spelling checking)
-- - Need to enable golangci-lint lint for golang.
-- - Looking into treesitter settings:
--   - incremental_selection: more configuring...
--   - textobjects: the bindings do not work for selecting functions in visual mode.
-- - Yank copies to clipboard, but also dw and similar does. Perhaps it shouldn't


--
-- General Settings
--
    vim.opt.clipboard = "unnamedplus" -- Sync yanks with system clipboard
    vim.opt.number = true
    vim.opt.expandtab = true
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.smartindent = true
    vim.opt.termguicolors = true
    vim.opt.signcolumn = "yes:1"
    vim.opt.spell = true
    vim.opt.spelllang = "en_us"
    vim.keymap.set('n', '<leader>h', ':noh<CR>', { desc = "Remove highting after search" })

-- Operations:
-- - Expanding setting correct tab width: select text in vision mode, the hit =, bam!
--

--
-- Code Navigation
--
    -- TODO:
    -- I tried a lot of these in Python, need to try Golang, Typescript and others.
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    --
    -- List Function, Class and Methods in file
    --
    -- Attempt with Lspsaga...
    --vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { desc = 'Show file outline' })
    -- Issues: lists all symbols, not just functions, classes and methods.
    -- Also, <enter> doesn't jump

    -- Attempt Symbols Outline ...
    vim.keymap.set('n', '<leader>o', '<cmd>SymbolsOutline<CR>', { desc = 'Show file outline' })
    -- This works, but lists all symbols.
    -- Need a way to filter types or something...
    -- Also, would be cool if it was more of a tree.

    --
    -- Goto Definition
    --
    vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga goto_definition<CR>', { desc = 'Go to Definition' })
    -- Holy smokes, this works so well...


    --
    -- Get References
    --
    vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga finder ref<CR>', { desc = 'Find References' })
    -- Works. Use "o" to open the file.
    -- Try this also:
    -- lazy.nvim: { "folke/trouble.nvim", cmd = "Trouble" }
    -- vim.keymap.set('n', '<leader>gr', '<cmd>Trouble lsp_references<CR>', { desc = 'Find References' })


    --
    -- Show implementations???
    --

    --
    -- Refactor
    --
    vim.keymap.set('n', '<leader>=', '<cmd>Lspsaga rename<CR>', { desc = 'Rename Symbol' })
    -- Haven't tried this yet.


 
--
-- Load Lazy.nvim and plugins
--
require("lazy").setup({
    -- LSP core
    { "neovim/nvim-lspconfig" },

    -- Symbol Tree
    { "simrat39/symbols-outline.nvim", config = function() require("symbols-outline").setup() end },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- Enhanced LSP UI
    { "nvimdev/lspsaga.nvim" },

    -- Status Line
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Fzf - Fuzzy Finder
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },  -- Optional for icons
        opts = {},
    },
}, {
    performance = {
        rtp = {
            disabled_plugins = { "netrw", "netrwPlugin" }, -- Disable netrw
        },
    },
}) -- end lazy setup


--
-- Plugin Configuration
--

-- LSP setup
    local lspconfig = require("lspconfig")

    -- Python: Pyright for code completion, goto def, etc.
    -- TODO: Errors are indicated, but not displayed.
    lspconfig.pyright.setup {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                },
            },
        },
    }
    -- Go: gopls for LSP and formatting
    lspconfig.gopls.setup {
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
        end,
    }
    -- TypeScript/JS/React: ts_ls for LSP and formatting
    lspconfig.ts_ls.setup {
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
        end,
    }

-- Lspsaga UI setup
require("lspsaga").setup({
    ui = {
        border = "rounded",
        winblend = 10,
    },
    hover = {
        max_width = 0.6,
        max_height = 0.4,
    },
    diagnostic = {
        on_insert = false, -- Prevent diagnostic popups during typing
        show_code_action = true,
        show_source = true,
    },
    outline = {
        auto_preview = true,
        auto_close = true,
        keys = {
            jump = '<Enter>',
            toggle_or_jump = 'o',
        },
    },
    -- lightbulb = {
    --     enable = true,
    --     sign = true,
    --     icon = 'g',
    -- },
    -- diagnostic = {
    --     virtual_text = { prefix = 'd' },
    -- }
})

-- Autocompletion setup
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})

-- Treesitter Setup
require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "go", "typescript", "javascript", "tsx", "lua" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
    },
})


-- Dynamic window scaling on resize
vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        -- Update lspsaga window sizes based on new window dimensions
        local win_width = vim.api.nvim_win_get_width(0)
        local win_height = vim.api.nvim_win_get_height(0)
        require("lspsaga").setup({
            ui = {
                border = "rounded",
                winblend = 10,
            },
            hover = {
                max_width = math.max(0.6 * win_width, 30), -- Scale width dynamically
                max_height = math.max(0.4 * win_height, 10), -- Scale height dynamically
            },
            diagnostic = {
                on_insert = false,
            },
        })
    end,
})

--
-- Fuzzy Finder
--
local fzf = require('fzf-lua')
-- Search files in this directory
vim.keymap.set('n', '<C-p>', fzf.files, { desc = "FzfLua: Find Files" })
-- Live grep across files (uses ripgrep, maybe)
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "FzfLua: Live Grep" })
vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = "FzfLua: Buffers" })
vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = "FzfLua: Help Tags" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

------------------------------------------
-- Lualine Setup
--
-- Sections:
-- - Sections are lists of components.
-- - A section is one of lualine_?
--   - a, b, c (the left sections)
--   - x, y, z (the right sections)
--
-- - sections is the main ... I actually have no idea.
-- - tabline is Global, for all windows.
-- - winbar is per window. (splitv, split?)
--
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = {}, winbar = {} },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        always_show_tabline = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" }, -- "branch"
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", {"filetype", icon_only = true} },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    -- tabline = {},
    tabline = {
        -- lualine_a = { "buffers" },  -- filetype icon, filename
        -- When a file is opened, then another one after, it appends to this buffer.
        -- Not really sure how to move through the buffer, or if I even want to.
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_z = { "windows" },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {},
})
-- require("lualine").setup({
--   options = {
--     theme = "auto",
--     icons_enabled = true,
--   },
--   sections = {
--     lualine_c = { { "diagnostics", sources = { "nvim_lsp" } } },
--     lualine_x = { { "filetype", icon_only = true } },
--   },
-- })

-- Colorscheme. Must be at the end.
vim.cmd.colorscheme('${theme_name}')

-- Fin
