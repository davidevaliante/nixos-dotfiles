{ config, pkgs, lib, ... }:

{
  # VM-specific hardware configuration
  
  # Software rendering for VM
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
  };

  # VM-specific environment variables
  environment.sessionVariables = {
    # Force software rendering
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Use software OpenGL
    LIBGL_ALWAYS_SOFTWARE = "1";
    
    # Use Mesa DRI backend
    GBM_BACKEND = "dri";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
  };

  # Additional packages for VM debugging
  environment.systemPackages = with pkgs; [
    mesa-demos
    glxinfo
    vulkan-tools
  ];
}