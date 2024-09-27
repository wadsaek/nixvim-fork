{
  empty = {
    plugins.lsp_signature.enable = true;
  };

  example = {
    plugins.lsp_signature = {
      enable = true;

      settings = {
        debug = true;
        log_path = "~/.config/TestDirectory/lsp_signature.log";
        verbose = true;
        bind = true;
        doc_lines = 5;

        max_height = 10;
        max_width = 45;
        wrap = false;
        floating_window = true;
        floating_window_above_cur_line = false;
        floating_window_off_x = "function() return 1 end";
        fix_pos = true;
        hint_inline = "function() return 'inline' end";
        handler_opts.border = "shadow";
        extra_trigger_chars = [ "$" ];

        shadow_blend = 1;
        select_signature_key = "<C-c>";
      };
    };
  };
}
