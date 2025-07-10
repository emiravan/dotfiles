return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
      { "sainnhe/gruvbox-material", priority = 1000, lazy = true },
    },
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      require("auto-dark-mode").setup({
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme gruvbox-material")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme gruvbox-material")
        end,
        update_interval = 10000,
        fallback = "dark",
      })
    end,
  },
}
