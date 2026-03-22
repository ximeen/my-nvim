return {
   "mfussenegger/nvim-lint",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      local lint = require("lint")

      -- Cria um linter customizado para o biome
      lint.linters.biome = {
         cmd = "biome",
         stdin = true,
         args = {
            "lint",
            "--stdin-file-path",
            function()
               return vim.api.nvim_buf_get_name(0)
            end,
         },
         stream = "stderr",
         ignore_exitcode = true,
         parser = require("lint.parser").from_errorformat("%f:%l:%c %m", {
            source = "biome",
         }),
      }

      lint.linters_by_ft = {
         javascript = { "biome" },
         typescript = { "biome" },
         javascriptreact = { "biome" },
         typescriptreact = { "biome" },
         svelte = { "biome" },
         python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
         group = lint_augroup,
         callback = function()
            lint.try_lint()
         end,
      })

      vim.keymap.set("n", "<leader>l", function()
         lint.try_lint()
      end, { desc = "Trigger linting for current file" })
   end,
}
