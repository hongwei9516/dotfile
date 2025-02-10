-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- =================================== 基本映射 ===================================
lvim.keys.visual_mode["q"] = "<Esc>"
lvim.keys.insert_mode["jk"] = "<Esc>"

-- 左右切换buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- keymap ==> <space> + "
lvim.builtin.which_key.setup.plugins.registers = true

lvim.builtin.telescope.defaults.layout_config = {
  width = 0.5, -- 0.90,
  height = 0.4,
}

-- ==================================== other =====================================
-- lemminx cache location
-- require('lspconfig').lemminx.setup({
--   settings = {
--     xml = {
--       server = {
--         workDir = "~/.cache/lemminx",
--       }
--     }
--   }
-- })

-- ===================================== plu ======================================
lvim.plugins = {
  { "rebelot/kanagawa.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}
-- Default options:
require('kanagawa').setup({
    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
    background = {                 -- map the value of 'background' option to a theme
        dark = "dragon",           -- try "dragon" !
        light = "dragon"
    },
})
-- setup must be called before loading
lvim.colorscheme = 'kanagawa-dragon'

-- ===================================== bug ======================================
-- nvimtree 修复打开文件对半分bug
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true

