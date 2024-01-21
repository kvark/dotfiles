;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux) (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)


(operating-system
  (kernel linux)
  (kernel-arguments (list "nomodeset"))
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "yak")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "kvark")
                  (comment "Dzmitry")
                  (group "users")
                  (home-directory "/home/kvark")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service gnome-desktop-service-type)
                 (service cups-service-type)
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/mnt/nix")
                         (device (uuid
                                  "21388b65-1799-4be0-81f0-e3c8a241995d"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/mnt/data")
                         (device (uuid
                                  "94f609ac-bbf8-4e43-98ef-329458caa683"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "0325b50e-77d7-4e9f-97c9-7478f25ddb4b"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "BCAD-E3FC"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
