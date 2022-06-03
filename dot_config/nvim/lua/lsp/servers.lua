local M = {
  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { 'flake8' },
        plugins = {
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          yapf = { enabled = false },
          flake8 = { enabled = true },
          black = { enabled = true },
          pylsisort = { enabled = true }
        }
      }
    }
  }
}
return M
