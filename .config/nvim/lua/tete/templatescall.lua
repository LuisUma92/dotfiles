vim.api.nvim_create_user_command('InitPartial',
  '!xclip -sel clip < ~/.config/mytex/templates/PN-YYYY-IIIC.tex',
  {}
  )

vim.api.nvim_create_user_command('InitTestItem',
  '!xclip -sel clip < ~/.config/mytex/templates/TNNE000.tex',
  {}
  )



