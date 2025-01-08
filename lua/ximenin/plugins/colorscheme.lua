return {
   "folke/tokyonight.nvim",
   priority = 1000,
   config = function()
      local transparent = false -- set to true if you would like to enable transparency

      require("tokyonight").setup({
         style = "storm",
         transparent = transparent,
      })

      vim.cmd("colorscheme tokyonight")
   end,
}
