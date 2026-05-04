-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#12131c',
    base01 = '#1e1f29',
    base02 = '#282934',
    base03 = '#8e8fa6',
    base04 = '#c4c5dd',
    base05 = '#e2e1ef',
    base06 = '#e2e1ef',
    base07 = '#e2e1ef',
    base08 = '#ffb4ab',
    base09 = '#bcc2ff',
    base0A = '#8ccff0',
    base0B = '#6dd2ff',
    base0C = '#bcc2ff',
    base0D = '#6dd2ff',
    base0E = '#8ccff0',
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
