-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#13121c',
    base01 = '#1f1f29',
    base02 = '#292934',
    base03 = '#908ea5',
    base04 = '#c6c4dd',
    base05 = '#e4e1ef',
    base06 = '#e4e1ef',
    base07 = '#e4e1ef',
    base08 = '#ffb4ab',
    base09 = '#c2c1ff',
    base0A = '#90cef4',
    base0B = '#7ed0ff',
    base0C = '#c2c1ff',
    base0D = '#7ed0ff',
    base0E = '#90cef4',
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
