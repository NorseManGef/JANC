{ pkgs, lib, ... }: 

{
  config.vim = {
    theme = {
      enable = true;
      name = lib.mkForce "gruvbox";
      style = lib.mkForce "dark";
    };

    options = {
      shiftwidth = 2;
      tabstop = 2;
      autoindent = true;
      mouse = "";
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
      {
        key = "gD";
        mode = "n";
        silent = true;
        noremap = true;
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      }
      {
        key = "gd";
        mode = "n";
        silent = true;
        noremap = true;
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        key = "<Space>bd";
        mode = "n";
        silent = true;
        noremap = true;
        action = "<cmd>bd<CR>";
      }
      {
        key = "jj";
        mode = "i";
        noremap = false;
        action = "<Esc>";
      }
      {
        key = ">";
        mode = "n";
        noremap = false;
        action = "<c-w>>";
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

    autocmds = [ 
      {
        enable = true;
        event = [
          "BufNewFile"
          "BufReadPre"
          "FileReadPre"
        ]; 
        pattern = [
          "*.cpp"
          "*.h"
          "*.inc"
          "cpp"
        ]; 
        callback = lib.mkLuaInline '' 
          function() vim.bo.tabstop = 4 vim.bo.shiftwidth = 4 end
        ''; 
      } 
    ];

    debugger.nvim-dap = {
      enable = true;
      ui = {
        enable = true;
      };
    };

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
      enable = true;
      fold = true;
      context.enable = true;
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

    diagnostics.nvim-lint = {
      enable = true;
      linters = {
        clang-tidy = {
          name = "clangtidy";
          cmd = "clang-tidy";
          #args = [ ];
        };
      };
      linters_by_ft = {
        cpp = [ "clangtidy" ];
      };
      lint_function = lib.mkLuaInline 
      ''
        function(buf)
          require("lint").try_lint()
        end
      '';

      lint_after_save = true;
    };

    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableDAP = true;

      nix.enable = true;
      rust.enable = true;
      rust.extensions.crates-nvim.enable = true;
      clang.enable = true;
      clang.lsp.enable = true;
      clang.lsp.servers = ["clangd"];
      clang.dap = {
        enable = true;
      };
      python.enable = true;
      cmake.enable = true;
      glsl.enable = true;
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

    mini.animate = {
      enable = true;
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
        #hop.enable = true;
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
}
