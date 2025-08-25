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

-- General Settings
vim.opt.clipboard = "unnamedplus" -- Sync yanks with system clipboard
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- Load Lazy.nvim and plugins
require("lazy").setup({
    -- Solarized Color Scheme
    -- { 
    --     "craftzdog/solarized-osaka.nvim",
    --     lazy = false, -- Load during startup
    --     priority = 1000, -- Load before other plugins
    --     config = function()
    --         require("solarized-osaka").setup({
    --             transparent = false, -- Optional: enable transparent background
    --             styles = {
    --                 floats = "transparent", -- Transparent floating windows
    --                 sidebars = { "qf", "vista_kind", "terminal", "packer" },
    --             },
    --         })
    --         vim.cmd([[colorscheme solarized-osaka]])
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    --         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
    --         vim.api.nvim_set_hl(0, "NonText", { bg = "#000000" })
    --      end,
    -- },
    -- OneDark Color Scheme
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('onedark').setup {
                --style = dark, darker, cool, deep, warm, warmer
                style = 'darker'
            }
            -- Enable theme
            require('onedark').load()
            -- Force black background
            vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
            vim.api.nvim_set_hl(0, "NonText", { bg = "#000000" })
        end,
    },
    -- LSP core
    { "neovim/nvim-lspconfig" },
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

}, {
    performance = {
        rtp = {
            disabled_plugins = { "netrw", "netrwPlugin" }, -- Disable netrw
        },
    },
}) -- end lazy setup

-- LSP setup
local lspconfig = require("lspconfig")
-- Python: ruff for formatting, pylsp for mypy diagnostics
lspconfig.ruff.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
    end,
}
lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                mypy = { enabled = true }, -- Mypy for type checking
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

-- Treesitter setup
require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "go", "typescript", "javascript", "tsx" },
    highlight = { enable = true },
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

-- Lspsaga setup
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
        -- on_insert = false, conos
        on_insert = false, -- Prevent diagnostic popups during typing
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


-- Lualine setup
require("lualine").setup({
  options = {
    theme = "solarized-osaka",
  },
})

