{ config, pkgs, lib, ... }:

{
  # NVIDIA-specific hardware configuration
  
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA driver configuration
  hardware.nvidia = {
    # Modesetting is required for Wayland
    modesetting.enable = true;

    # Power management (can cause sleep/suspend issues on some laptops)
    powerManagement.enable = false;
    
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern NVIDIA GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the open source kernel module (only works on newer GPUs)
    # Only Turing+ (RTX 20xx series and newer) GPUs are supported
    open = false;

    # Enable the NVIDIA settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Kernel parameters for NVIDIA
  boot.kernelParams = [
    # Enable DRM kernel mode setting for the NVIDIA driver
    "nvidia-drm.modeset=1"
    
    # Disable the open-source Nouveau driver to prevent conflicts
    "nouveau.modeset=0"
    
    # For screen tearing issues (optional)
    "nvidia-drm.fbdev=1"
  ];

  # Blacklist nouveau driver
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Enable early KMS for NVIDIA
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Additional packages for NVIDIA
  environment.systemPackages = with pkgs; [
    # GPU monitoring
    nvtopPackages.nvidia
    
    # NVIDIA GPU utilization
    nvidia-vaapi-driver
    
    # Vulkan support
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
  ];

  # Environment variables for NVIDIA
  environment.sessionVariables = {
    # Force GBM backend for NVIDIA
    GBM_BACKEND = "nvidia-drm";
    
    # Enable NVIDIA-specific GL libraries
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    
    # Vulkan ICD
    VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    
    # Enable direct rendering for NVIDIA
    LIBVA_DRIVER_NAME = "nvidia";
    
    # Use NVIDIA for hardware video acceleration
    NVD_BACKEND = "direct";
    
    # Other Wayland optimizations
    NIXOS_OZONE_WL = "1";
    GTK_USE_PORTAL = "1";
  };
}