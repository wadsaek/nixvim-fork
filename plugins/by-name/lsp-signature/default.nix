{ lib, helpers, ... }:
let
  inherit (lib.nixvim) defaultNullOpts;
in
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "lsp-signature";
  originalName = "lsp_signature.nvim";
  package = "lsp_signature-nvim";
  luaName = "lsp_signature";

  maintainers = [ lib.maintainers.wadsaek ];

  settingsOptions = {
    debug = defaultNullOpts.mkBool false ''
      Whether to enable debug logging
    '';

    log_path =
      defaultNullOpts.mkStr
        (lib.nixvim.mkRaw # lua
          ''
            vim.fn.stdpath("cache") .. "/lsp_signature.log"
          ''
        )
        ''
          Log directory for when debug is on. Default is  ~/.cache/nvim/lsp_signature.log

          Note: if you specify this as a nix path, make sure it points to an existing file
        '';

    verbose = defaultNullOpts.mkBool false ''
      Whether to show the debug line number
    '';

    bind = defaultNullOpts.mkBool true ''
      This is mandatory, otherwise border config won't get registered.
      If you want to hook lspsaga or other signature handler, please set to false
    '';

    doc_lines = defaultNullOpts.mkUnsignedInt 10 ''
      Will show two lines of comment/doc(if there are more than two lines in the doc, will be truncated)

      Set to zero if you DO NOT want any API comments be shown
      This setting only take effect in insert mode, it does not affect signature help in nornal mode
    '';

    max_height = defaultNullOpts.mkUnsignedInt 12 ''
      Maximum height of the signature floating_window
    '';

    max_width = defaultNullOpts.mkPositiveInt 80 ''
      Maximum height of the signature floating_window, line will be wrapped if it exceeds max_width
    '';

    wrap = defaultNullOpts.mkBool true ''
      Allow doc/signature text wrap inside floating_window, useful if your lsp return/sig is too long
    '';

    floating_window = defaultNullOpts.mkBool true ''
      Show hint in a floating window, set to false for virtual text only mode
    '';

    floating_window_above_cur_line = defaultNullOpts.mkBool true ''
      Whether to try to place the floating window above the current line when possible

      Note:
        Will set to true when fully tested, set to false will use whichever side has more space
        This setting will be helpful if you do not want the PUM and floating win overlap
    '';

    floating_window_off_x = defaultNullOpts.mkStrLuaFnOr lib.types.int 1 ''
      Adjust the floating window's x position 
    '';

    floating_window_off_y = defaultNullOpts.mkStrLuaFnOr lib.types.int 0 ''
      Adjust the floating window's y positin. e.g: 
      - `-2` move window up 2 lines
      - `2` move down 2 lines
    '';

    close_timeout = defaultNullOpts.mkUnsignedInt 4000 ''
      Close the floating window after ms when last parameter is entered
    '';

    fix_pos = defaultNullOpts.mkBool false ''
      If set to true, the floating window will not auto-close until all parameters are entered
    '';

    hint_enable = defaultNullOpts.mkBool true ''
      Whether to enable virtual hint
    '';

    hint_prefix = helpers.defaultNullOpts.mkNullable' {
      type = lib.types.anything;
      pluginDefault = "🐼 ";
      description = ''
        Panda for parameter. Note: for the terminal not support emoji, might crash

        or, provide a table with 3 icons
      '';
    };

    hint_scheme = defaultNullOpts.mkStr "String" "";
    hint_inline =
      defaultNullOpts.mkLuaFn
        ''
          function() return false end
        ''
        ''
          Should the hint be inline(nvim 0.10 only)?  default false
          - Return true | 'inline' to show hint inline
          - Return 'eol' to show hint at the end of line
          - Return false to disable
          - Return 'right_align' to display hint right aligned in the current line
        '';

    hi_parameter = defaultNullOpts.mkStr "LspSignatureActiveParameter" ''
      How your parameter will be highlighted
    '';

    handler_opts =
      defaultNullOpts.mkAttributeSet
        {
          border = "rounded";
        }
        ''
          `border` can be double, rounded, single, shadow, none or a lua table of borders
        '';

    always_trigger = defaultNullOpts.mkBool false ''
      Sometime show signature on new line or in middle of parameter can be confusing
    '';

    auto_close_after = defaultNullOpts.mkLua "nil" ''
      Autoclose signature float win after x seconds, disabled if`nil`
    '';

    extra_trigger_chars = defaultNullOpts.mkListOf lib.types.str [ ] ''
      Array of of extra characters that will trigger signature completion
    '';

    zindex = defaultNullOpts.mkInt 200 ''
      By default it will be on top of all floating windows, set to <= 50 to send it to the bottom
    '';

    padding = defaultNullOpts.mkStr "" ''
      Character to pad on left and right of signature
    '';

    transparency = defaultNullOpts.mkStrLuaOr (lib.types.ints.between 1 100) "nil" ''
      Disabled by default, allow floating window transparent value 1~100
    '';

    shadow_blend = defaultNullOpts.mkInt 36 ''
      If you're using shadow as border, use this to set the opacity
    '';

    shadow_guibg = defaultNullOpts.mkStr "Green" ''
      If you're using shadow as border, use this to set the color
    '';

    time_interval = defaultNullOpts.mkInt 200 ''
      Timer check interval. Set to a lower value if you want to reduce latency
    '';

    toggle_key = defaultNullOpts.mkLua "nil" ''
      Toggle signature on and off in insert mode
    '';

    toggle_flip_floatwin_setting = defaultNullOpts.mkStrLuaOr lib.types.bool false ''
      - true: toggle 
      - floating_windows: true|false setting after toggle key pressed
      - false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature

      May not popup when typing, depending on floating_window setting
    '';

    select_signature_key = defaultNullOpts.mkLua "nil" ''
      The keybind for cycling to next signature
    '';

    move_cursor_key = defaultNullOpts.mkLua "nil" ''
      imap, use nvim_set_current_win to move cursor between current window and floating window. Once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down.
    '';

    keymaps = defaultNullOpts.mkListOf lib.types.anything { } ''
      related to move_cursor_key. the keymaps inside floating window with arguements of bufnr. 
      It can be a function that sets keymaps.
      <M-d> and <M-u> are default keymaps for moving the cursor up and down.
    '';
  };

  settingsExample = {
    hint_prefix = {
      above = "↙ ";
      current = "← ";
      below = "↖ ";
    };
    extra_trigger_chars = [
      "("
      ","
    ];
    padding = " ";
    shadow_guibg = "#121315";
    toggle_key = "<M-x>";
  };
}
