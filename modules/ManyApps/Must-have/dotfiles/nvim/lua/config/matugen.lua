-- ~/.config/nvim/lua/config/matugen-template.lua
local M = {}

function M.setup()
  local status, base16 = pcall(require, 'base16-colorscheme')
  if not status then return end

  base16.setup({
    base00 = '#1e100f',
    base01 = '#2b1c1b',
    base02 = '#362625',
    base03 = '#ad8886',
    base04 = '#e6bdba',
    base05 = '#f8dcda',
    base06 = '#f8dcda',
    base07 = '#f8dcda',
    base08 = '#ffb4ab',
    base09 = '#ffb3b0',
    base0A = '#edb4ea',
    base0B = '#faacf9',
    base0C = '#ffb3b0',
    base0D = '#faacf9',
    base0E = '#edb4ea',
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
