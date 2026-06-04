-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#0e150c',
    base01 = '#1a2217',
    base02 = '#242c21',
    base03 = '#85957e',
    base04 = '#bbcbb2',
    base05 = '#dde5d5',
    base06 = '#dde5d5',
    base07 = '#dde5d5',
    base08 = '#ffb4ab',
    base09 = '#a5d396',
    base0A = '#e2c46d',
    base0B = '#e9c348',
    base0C = '#a5d396',
    base0D = '#e9c348',
    base0E = '#e2c46d',
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
