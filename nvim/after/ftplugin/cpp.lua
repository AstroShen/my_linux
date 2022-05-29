-- set semicolon automatically at the end of line
function set_semicolon()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]
  if string.sub(current_line, -string.len(";")) ~= ";" then
    current_line = current_line .. ";"
    vim.api.nvim_set_current_line(current_line)
  end
  vim.api.nvim_win_set_cursor(0, {line, #current_line})
end
vim.keymap.set('i', '<C-l>', set_semicolon, {noremap = true, silent = true, buffer=true})
