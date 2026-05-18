-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#0f131c',
    base01 = '#1b2029',
    base02 = '#252a33',
    base03 = '#8891a5',
    base04 = '#bdc7dc',
    base05 = '#dfe2ef',
    base06 = '#dfe2ef',
    base07 = '#dfe2ef',
    base08 = '#ffb4ab',
    base09 = '#a9c7ff',
    base0A = '#83d3e3',
    base0B = '#51d7ef',
    base0C = '#a9c7ff',
    base0D = '#51d7ef',
    base0E = '#83d3e3',
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
