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
    vim.opt.title = true
    --vim.opt.titlestring = '%{system("whoami")[:-2]}@%{hostname()}: nvim: %{fnamemodify(getcwd(), ":~"}: %f'
    --^ the default is actually pretty good. Might want to modify it in the future.
    vim.opt.signcolumn = "yes:1"
    vim.opt.spell = true
    vim.opt.spelllang = "en_us"
    vim.keymap.set('n', '<leader><BS>', ':noh<CR>', { desc = "Remove highting after search" })

-- Operations:
-- - Expanding setting correct tab width: select text in vision mode, the hit =, bam!
--

--
-- Code Navigation / LSP Config
--
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


    -- Signature help (manual trigger)
    -- TODO: the UX for this kind of sucks.
    vim.keymap.set('n', '<leader>p', vim.lsp.buf.signature_help, { desc = 'LSP Signature Help' })
    
    -- Show implementations???
    -- TODO: figure out the LSP command for this.

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

    -- Git signs and hunk management
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "", hl = "GitSignsAdd" },
                    change       = { text = "", hl = "GitSignsChange" },
                    delete       = { text = "", hl = "GitSignsDelete" },
                    topdelete    = { text = "‾", hl = "GitSignsDelete" },
                    changedelete = { text = "", hl = "GitSignsChange" },
                    untracked    = { text = "┆", hl = "GitSignsUntracked" },
                },
                signs_staged = {
                    add          = { text = "", hl = "GitSignsStagedAdd" },
                    change       = { text = "", hl = "GitSignsStagedChange" },
                    delete       = { text = "󰍵", hl = "GitSignsStagedDelete" },
                    topdelete    = { text = "‾", hl = "GitSignsStagedDelete" },
                    changedelete = { text = "~", hl = "GitSignsStagedChange" },
                },  
                signs_staged_enable = true, -- important: enables the staged signs
                current_line_blame = false, -- set to true if you like inline blame
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 300,
                },
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<leader>gs", ":LazyGit<cr>", { desc = "Git Status (popup)" })
        end,
    },
}, {
    performance = {
        rtp = {
            disabled_plugins = { "netrw", "netrwPlugin" }, -- Disable netrw
        },
    },
}) -- end lazy setup

--
-- Colors for Git Signs
--
-- TODO: Make staged signs more distinct...
-- vim.api.nvim_set_hl(0, "GitSignsStagedAdd",    { fg = "#5f875f", bold = true })
-- vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#5f5f87", bold = true })
-- vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#875f5f", bold = true })


--
-- Plugin Configuration
--

-- LSP setup

    -- Python: Pyright for code completion, goto def, etc.
    -- TODO: Errors are indicated, but not displayed.

    vim.lsp.config('pyright', {
        cmd = { 'pyright' },  -- assuming it's in PATH; add full path if needed
        filetypes = { 'python' },
        root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' }),
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",  -- or "strict", "off", etc.
                },
            },
        },
    })

    -- Go: gopls
    vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = vim.fs.root(0, { 'go.work', 'go.mod', '.git' }),
        settings = {
            gopls = {
                -- your extra settings if any
            },
        },
        -- on_attach moved here (or use LspAttach autocmd globally)
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            -- add any other on_attach stuff (keymaps, etc.)
        end,
    })

    -- TypeScript/JS/React: ts_ls (was tsserver)
    vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_dir = vim.fs.root(0, { 'tsconfig.json', 'package.json', '.git' }),
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
        end,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded",
          focusable = false,
        }
    )

    -- Enable them all (this sets up FileType autocommands to start when you open matching files)
    vim.lsp.enable({'pyright', 'gopls', 'ts_ls'})

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

--
-- UX Keybindings
--

-- Search files in this directory
vim.keymap.set('n', '<C-p>', fzf.files, { desc = "FzfLua: Find Files" })

-- Live grep across files (uses ripgrep, maybe)
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "FzfLua: Live Grep" })
vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = "FzfLua: Buffers" })
vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = "FzfLua: Help Tags" })

-- Display diagnostics in current file. I.e., if you have errors.
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })


-- Gitsigns keymaps
local gitsigns = require("gitsigns")

-- A "hunk" is a contiguous block of change in a file.
-- OK, the set({"n", "v"}, ...) is Normal and Visual mode.
vim.keymap.set({"n", "v"}, "<C-s>", gitsigns.stage_hunk, { desc = "Stage hunk" }) -- git add hunk
vim.keymap.set({"n", "v"}, "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" }) -- git restore --staged hunk
vim.keymap.set({"n", "v"}, "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
vim.keymap.set({"n", "v"}, "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" }) -- show the changes in a floating window.
vim.keymap.set({"n", "v"}, "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" }) -- show git blame
-- so... the UX here for refactor of a local function signature:
-- 1. Make some change to the function signature.
-- 2. Find references in file, change sig there.
-- 3. Repeat.
-- 4. Now I can use ctrl+j and ctrl+k to navigate around and see my changes.
-- 5. I can use space+hd, and see a diff.
-- 6. Now I can use ctrl+j and ctrl+s, to stage that hunk.
-- 7. repeat.
-- 8. Oops, I messed up, now I can space+hu, to undo the stage. (actually, just staging again seems to unstage... don't really understand")
-- 9. Shoot, I don't even wanna do any of this ... space+hr, reset hunk.

-- Git diff
vim.keymap.set({"n", "v"}, "<leader>hd", gitsigns.diffthis, { desc = "Diff this" }) -- show the changes in file compared to staged changes.
-- Close diff view easily
vim.keymap.set("n", "<leader>hq", function()
    if vim.wo.diff then
        vim.cmd("wincmd h")
        vim.cmd("q")
    else
        vim.cmd("q")
    end
end, { desc = "Close diff view" })

-- Navigation
vim.keymap.set("n", "<C-j>", function()
    if vim.wo.diff then return "<C-j>" end
    vim.schedule(function() gitsigns.next_hunk({ target = "all" }) end)
    return "<Ignore>"
end, { expr = true, desc = "Next hunk" })

vim.keymap.set("n", "<C-k>", function()
    if vim.wo.diff then return "<C-k>" end
    vim.schedule(function() gitsigns.prev_hunk({ target = "all" }) end)
    return "<Ignore>"
end, { expr = true, desc = "Prev hunk" })


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
