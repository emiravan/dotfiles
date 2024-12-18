-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "solarized_osaka",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.ui = {
    statusline = {
        enabled = false,
        theme = "vscode",
        -- round and block will work for minimal theme only
        separator_style = "",
        order = nil,
        modules = nil,
    },
}

return M
