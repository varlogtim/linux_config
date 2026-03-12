return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,          -- Load early (essential for highlighting on startup)
    build = ":TSUpdate",   -- Auto-update parsers after install/sync

    config = function()
        -- This is where the actual setup lives
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
            -- Optional extras you might want later:
            -- indent = { enable = true },
            -- rainbow = { enable = true },
        })
    end,
}
