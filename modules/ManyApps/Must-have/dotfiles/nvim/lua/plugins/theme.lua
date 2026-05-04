return {
  {
    'RRethy/base16-nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- Sử dụng đường dẫn module chính xác theo cấu trúc của bạn
      local status, matugen = pcall(require, 'config.matugen')
      if status then
        matugen.setup()
        -- Không dùng vim.cmd.colorscheme('base16-matugen') nữa
        -- vì hàm setup() bên trong matugen đã thực hiện việc này rồi.
      end
    end,
  },
}
