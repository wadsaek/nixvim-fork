{ lib,helpers, ... }:
let
  inherit (lib.nixvim) defaultNullOpts;
in
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "lsp_signature";
  originalName = "lsp_signature.nvim";
  package = "lsp_signature-nvim";

  maintainers = [ lib.maintainers.wadsaek ]; 


  # Optionally, provide an example for the `settings` option.
  settingsExample = {
    foo = 42;
    bar.__raw = "function() print('hello') end";
  }; 
}
