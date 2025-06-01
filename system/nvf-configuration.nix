{ pkgs, lib, ... }: 

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      options = {
        shiftwidth = 2;
        tabstop = 2;
        autoindent = true;
      };

      keymaps = [
        {
          key = "<c-t>";
          mode = "t";
          silent = true;
          action = "<c-\\><c-n>";
        }
        {
          key = "<c-s>";
          mode = "i";
          silent = false;
          action = "<c-[>:w<CR>";
        }
        {
          key = "<c-s>";
          mode = "n";
          silent = false;
          action = ":w<CR>";
        }
      ];

      tabline = {
        nvimBufferline.enable = true;
      };

      luaConfigRC.filetypeRules = ''
        vim.filetype.add({
          extension = {
            inc = "cpp",
          }
        })
      '';

      statusline.lualine.enable = true;

      lineNumberMode = "number";
      autocomplete.nvim-cmp.enable = true;
      autocomplete.nvim-cmp.mappings = {
        close = "<C-e>";
        complete = "<C-Space>";
        confirm = "<C-CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
      };

      telescope.enable = true;

      treesitter = {
        fold = true;
      };

      terminal = {
        toggleterm.enable = true;
        toggleterm.mappings.open = "<c-t>";
        toggleterm.lazygit.enable = true;
        toggleterm.setupOpts = {
          direction = "horizontal";
        };
      };

      lsp = {
        enable = true;
        formatOnSave = false;
        inlayHints.enable = true;
        lspsaga = {
          enable = true;
          setupOpts.border_style = "double";
        };
      };

      languages = {
        enableTreesitter = true;
        enableFormat = true;

        nix.enable = true;
        rust.enable = true;
        rust.crates.enable = true;
        clang.enable = true;
        clang.lsp.server = "clangd";
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        cellular-automaton.enable = true;
      };

      filetree = {
        neo-tree = {
          enable = true;
          setupOpts = {
            
          };
        };
      };

      git = {
        enable = true;
        gitsigns.enable = true;
      };

      minimap = {
        codewindow.enable = true;
      };

      dashboard = {
        alpha.enable = true;
      };

      notify = {
        nvim-notify.enable = true;
      };

      projects = {
        project-nvim.enable = true;
      };

      presence.neocord.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
        hardtime-nvim.enable = false;
      };

      utility = {
        ccc.enable = true;
        diffview-nvim.enable = true;
        icon-picker.enable = true;
        surround.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = true;
        };
      };

      autopairs.nvim-autopairs.enable = true;

      notes = {
        todo-comments.enable = true;
      };

      ui = {
        borders = {
          enable = true;
          globalStyle = "double";
          plugins = {
            nvim-cmp.enable = true;
            fastaction.enable = true;
            lspsaga.enable = true;
            which-key.enable = true;
          };
        };
        noice.enable = false;
        colorizer.enable = true;
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        fastaction.enable = true;
      };
    };
  };
}
