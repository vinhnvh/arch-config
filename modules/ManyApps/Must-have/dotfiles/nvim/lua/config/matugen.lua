-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#091517',
    base01 = '#152224',
    base02 = '#202c2e',
    base03 = '#7c9599',
    base04 = '#b1cbd0',
    base05 = '#d7e5e7',
    base06 = '#d7e5e7',
    base07 = '#d7e5e7',
    base08 = '#ffb4ab',
    base09 = '#81d3e0',
    base0A = '#93d5a9',
    base0B = '#79da9f',
    base0C = '#81d3e0',
    base0D = '#79da9f',
    base0E = '#93d5a9',
    base0F = '#93000a',
  })
end

-- Tự động reload khi Noctalia gửi tín hiệu
local signal = vim.uv.new_signal()
signal:start('sigusr1', vim.schedule_wrap(function()
  -- Xóa cache để load file matugen.lua mới được ghi đè
  package.loaded['config.matugen'] = nil
  require('config.matugen').setup()
end))

return M
