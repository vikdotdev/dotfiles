local Util = { }

function Util.kill_current_buffer()
  vim.api.nvim_buf_delete(0, {})
end

function Util.toggle_line_numbers()
  if vim.wo.number and vim.wo.relativenumber then
    vim.wo.number = true
    vim.wo.relativenumber = false
  elseif vim.wo.number and vim.wo.relativenumber == false then
    vim.wo.relativenumber = false
    vim.wo.number = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end

function Util.toggle_readonly()
  vim.bo.readonly = not vim.bo.readonly
  vim.bo.modifiable = vim.bo.readonly
end

function Util.shallow_copy(source)
  local target = {}
  for k, v in pairs(source) do
    target[k] = v
  end
  return target
end

function Util.git_path_to_current_buffer()
  local root_to_repo = vim.api.nvim_call_function('finddir', { '.git/..', vim.fn.expand('%:p:h')..';'})
  local full_path = vim.fn.expand('%:p')
  -- function

  if string.match(full_path, root_to_repo) then
    return string.gsub(full_path, root_to_repo, '') or ''
  else
    return vim.fn.expand('%:t')
  end
end

function Util.packer_sync()
  local packer = require('packer')

  -- luafile %

  packer.compile()
  packer.sync()
end

function Util.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function Util.delete_augroups(groups)
  for _, group_name in ipairs(groups) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command('augroup END')
  end
end

function Util.blame_toggle()
  local group_name = 'vdd_toggle_blame'

  if vim.g.vdd_blame_toggled_on then
    vim.g.vdd_blame_toggled_on = false
    Util.delete_augroups({ group_name })
  else
    vim.g.vdd_blame_toggled_on = true
    Util.create_augroups({
      [group_name] = {
        "CursorHold * lua require('gitsigns').blame_line()"
      }
    })
  end

end

function Util.set_alternate_buffer()
  if string.len(vim.fn.expand('#')) == 0 then

  else
  end
end

function Util.flash_cursorline()
  vim.cmd([[hi CursorFlash guifg=#aaafef guibg=#0a8e8f]])

  local window = vim.api.nvim_win_get_number(0)
  local ns_id = vim.api.nvim_create_namespace('flash_cursor')
  local current_lnum = vim.api.nvim__buf_stats(0)['current_lnum'] - 1

  -- vim.fn.timer_stopall()
  vim.api.nvim_buf_add_highlight(window, ns_id, 'CursorFlash', current_lnum, 0, -1)
  local timer_id = vim.fn.timer_start(600, function()
    vim.api.nvim_buf_clear_namespace(window, ns_id, 0, -1)
  end)
  -- print(vim.inspect(vim.fn.timer_info(timer_id)))


  -- local initial = vim.api.nvim_get_hl_by_name('cursorline', true)
  -- print(vim.inspect(vim.api.nvim_get_hl_by_name('cursorline', true)))
  -- vim.api.nvim_set_hl(43, 'CursorLine', { background = 2896444 })
  -- vim.cmd([[hi CursorLine guifg=#000000 guibg=#ffffff]])
  --
  -- print(vim.inspect(vim.api.nvim__buf_stats(0)))
end

--- Get a ts compatible range of the current visual selection.
--
-- The range of ts nodes start with 0 and the ending range is exclusive.
-- local function Util.visual_selection_range()
--   local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
--   local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
--   if csrow < cerow or (csrow == cerow and cscol <= cecol) then
--     return csrow - 1, cscol - 1, cerow - 1, cecol
--   else
--     return cerow - 1, cecol - 1, csrow - 1, cscol
--   end
-- end

return Util
