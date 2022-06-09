-- install packer if needed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({
        border = 'rounded'
      })
    end
  }
})

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'vim-jp/vimdoc-ja' }

  -- colorscheme
  use {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup({
        palettes = {
          nordfox = {
            comment = '#618a60'
          }
        }
      })
      vim.cmd [[colorscheme nordfox]]
    end
  }
  use { 'folke/tokyonight.nvim' }
  use { 'mhartington/oceanic-next' }

  -- filer
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = false,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = {
              ".DS_Store",
            }
          }
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖", -- this can only be used in the git_status source
              renamed   = "", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          }
        },
      })

      vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree filesystem left focus toggle<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>E', ':Neotree filesystem reveal left toggle<cr>', { noremap = true, silent = true })
    end
  }

  use { 'editorconfig/editorconfig-vim' }
  use {
    -- ctrl + e
    'simeji/winresizer',
    setup = function()
      vim.g.winresizer_vert_resize = 1
      vim.g.winresizer_horiz_resize = 1
    end
  }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use {
    'bkad/CamelCaseMotion',
    setup = function()
      vim.g.camelcasemotion_key = ','
    end
  }
  use { 'markonm/traces.vim' }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      local ft = require('Comment.ft')
      ft.set('dart', '//%s')
    end
  }
  use { 'andymass/vim-matchup' }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      local actions = require('telescope.actions')
      local action_layout = require('telescope.actions.layout')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<M-p>"] = action_layout.toggle_preview
            },
            n = {
              ["<M-p>"] = action_layout.toggle_preview
            }
          },
          file_ignore_patterns = {
            ".git/",
          },
        },
        pickers = {
          live_grep = {
            additional_args = function(opts)
              return { "--hidden" }
            end
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          }
        }
      }
      require('telescope').load_extension('fzf')
      vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files hidden=true<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
    end
  }
  use {
    'mrjones2014/legendary.nvim',
    requires = { 'stevearc/dressing.nvim' },
    config = function()
      require('legendary').setup({ include_builtin = true })
      -- vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("legendary").find()<CR>', { noremap = true, silent = true })
    end
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        eusure_installed = 'all',
        highlight = {
          enable = true,
        }
      })
    end
  }

  -- move
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.api.nvim_set_keymap('n', 's', ':HopChar2<cr>', { noremap = true })
    end
  }
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' }
      })
    end
  }

  -- lsp
  use {
    { 'williamboman/nvim-lsp-installer' },
    { 'tami5/lspsaga.nvim' },
    { 'ray-x/lsp_signature.nvim' },
    { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' },
    {
      'neovim/nvim-lspconfig',
      config = function()
        local lsp_installer = require('nvim-lsp-installer')
        lsp_installer.setup({
          automatic_installation = true
        })

        local saga = require('lspsaga')
        saga.init_lsp_saga()

        require('lsp_signature').setup()

        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end

          require('lsp_signature').on_attach()

          local opts = { noremap = true, silent = true }
          buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          buf_set_keymap("n", "gD", ":tab split<cr><cmd>lua vim.lsp.buf.definition()<CR>", opts)
          -- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          -- lspsaga
          buf_set_keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
          buf_set_keymap('x', '<leader>ca', ':<c-u>Lspsaga range_code_action<cr>', opts)
          buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
          buf_set_keymap('n', 'gr', '<cmd>Lspsaga rename<cr>', opts)
          -- buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", {})
          -- buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", {})
          buf_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<cr>", opts)
          buf_set_keymap('n', '<leader>cd', "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>", opts)

        end

        local lspconfig = require('lspconfig')
        local servers = require('lsp/servers')
        for name, config in pairs(servers) do
          config.on_attach = on_attach
          lspconfig[name].setup(config)
        end
        for _, server in ipairs(lsp_installer.get_installed_servers()) do
          if servers[server.name] == nil then
            lspconfig[server.name].setup({
              on_attach = on_attach
            })
          end
        end
        require("flutter-tools").setup({
          lsp = {
            on_attach = on_attach
          }
        })
      end
    }
  }
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'folke/lsp-colors.nvim' }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("trouble").setup {}
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
    end
  }
  -- display nvim-lsp progress
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {}
    end
  }

  -- ui
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup()
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1
            }
          }
        }
      })
    end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          middle_mouse_command = 'bdelete! %d',
          diagnostics = 'nvim_lsp',
          separator_style = 'thick',
          max_name_length = 50,
          name_formatter = function(buf)
            return vim.fn.pathshorten(vim.fn.fnamemodify(buf.path, ":~:."))
          end,
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neotree',
            },
          },
          custom_filter = function(buf_number, buf_numbers)
            -- hide [No Name]
            local length = 0
            for _ in pairs(buf_numbers) do
              length = length + 1
            end
            if length > 1 and vim.fn.bufname(buf_number) == '' then
              return false
            end
            return true
          end
        }
      })

      vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<cr>', { noremap = true, silent = true })
    end
  }
  use {
    'ojroques/nvim-bufdel',
    config = function()
      require('bufdel').setup({
        quit = false,
      })

      vim.cmd [[nnoremap bd :BufDel<cr>]]
    end,
  }
  use {
    'petertriho/nvim-scrollbar',
    requires = 'kevinhwang91/nvim-hlslens',
    config = function()
      require("scrollbar").setup()
      require('scrollbar.handlers.search').setup()
    end
  }
  use {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {}
    end
  }
  use({
    'crispgm/nvim-tabline',
    config = function()
      require('tabline').setup({})
    end,
  })

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use { 'tpope/vim-fugitive' }
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup({
        integrations = {
          diffview = true
        }
      })
    end
  }

  -- highlight
  use { 'RRethy/vim-illuminate' }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
