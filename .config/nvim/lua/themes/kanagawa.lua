return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            compile = false, -- Enable compiling the colorscheme
            undercurl = true, -- Enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            dimInactive = false, -- Dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- Define vim.g.terminal_color_{0,17}
            colors = { -- Modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- Modify highlights if needed
                return {}
            end,
            theme = "dragon", -- Set theme to "wave", can be "dragon" or "lotus"
            background = { -- Map Neovim's 'background' option to a theme
                dark = "dragon", -- Choose "wave" or "dragon" for dark mode
                light = "lotus", -- Choose "lotus" for light mode
            },
        })
    end,
}