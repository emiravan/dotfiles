local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        python = { "isort", "black" },
    },

    formatters = {
        -- C & C++
        ["clang-format"] = {
            prepend_args = {
                "-style={ \
        IndentCaseLabels: true, \
        IndentWidth: 4, \
        TabWidth: 4, \
        UseTab: Never, \
        AccessModifierOffset: 0, \
        IndentAccessModifiers: false, \
        ColumnLimit: 0, \
        PointerAlignment: Left, \
        AlignAfterOpenBracket: DontAlign, \
        BreakBeforeBraces: Attach \
    }",
            },
        },

        -- Golang
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80" },
        },
        -- Lua
        stylua = {
            prepend_args = {
                "--column-width",
                "80",
                "--line-endings",
                "Unix",
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
                "--quote-style",
                "AutoPreferDouble",
            },
        },
        -- Python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "100",
                "--skip-string-normalization",
            },
        },
        isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
