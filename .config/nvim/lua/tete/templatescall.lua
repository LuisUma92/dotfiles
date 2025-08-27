vim.api.nvim_create_user_command('InitPartial',
  '!xclip -sel clip < ~/.config/mytex/templates/PN-YYYY-IIIC.tex',
  {}
  )

vim.api.nvim_create_user_command('InitPropousal',
  '!xclip -sel clip < ~/.config/mytex/templates/PartialPropousal.tex',
  {}
  )

vim.api.nvim_create_user_command('InitTestItem',
  '!xclip -sel clip < ~/.config/mytex/templates/TNNE000.tex',
  {}
  )

vim.api.nvim_create_user_command('InitMain',
  '!xclip -sel clip < ~/.config/mytex/templates/00AA.tex',
  {}
  )

vim.api.nvim_create_user_command('InitText',
  '!xclip -sel clip < ~/.config/mytex/templates/C0S0-000.tex',
  {}
  )

vim.api.nvim_create_user_command('InitBookExercise',
  '!xclip -sel clip < ~/.config/mytex/templates/book-C00S00P000.tex',
  {}
  )

vim.api.nvim_create_user_command('InitArtFicha',
  '!xclip -sel clip < ~/.config/mytex/templates/lect.tex',
  {}
  )


