-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#111509',
    base01 = '#1d2115',
    base02 = '#272c1f',
    base03 = '#8b9478',
    base04 = '#c1caab',
    base05 = '#e1e5d1',
    base06 = '#e1e5d1',
    base07 = '#e1e5d1',
    base08 = '#ffb4ab',
    base09 = '#b6d086',
    base0A = '#f1be6d',
    base0B = '#fcbb4a',
    base0C = '#b6d086',
    base0D = '#fcbb4a',
    base0E = '#f1be6d',
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
