return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "knubie/vim-kitty-navigator",
        build = "cp ./*.py ~/.config/kitty/",
    },

    {
        "Djancyp/better-comments.nvim",
        lazy = false,
        config = function()
            require("better-comment").Setup({
                tags = {
                    {
                        name = "TODO",
                        fg = "#93a1a1",
                        bg = "#103955",
                        bold = true,
                        virtual_text = "",
                    },
                    {
                        name = "FIX",
                        fg = "#93a1a1",
                        bg = "#B6211D",
                        bold = true,
                        virtual_text = "This is virtual Text from FIX",
                    },
                    {
                        name = "WARNING",
                        fg = "#A13D10",
                        bg = "",
                        bold = false,
                        virtual_text = "This is virtual Text from WARNING",
                    },
                    {
                        name = "?",
                        fg = "#196397",
                        bg = "",
                        bold = true,
                        virtual_text = "",
                    },
                    {
                        name = "!",
                        fg = "#A13D10",
                        bg = "",
                        bold = true,
                        virtual_text = "",
                    },
                },
            })
        end,
    },
}
