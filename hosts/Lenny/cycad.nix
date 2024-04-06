/*
Cycad's home manager module for Lenny.
This imports Cycad's default home manager module which imports the other modules.
Modules can be enabled or disabled here.
*/
{ ... }:
{
  imports = [
    ../../home/cycad
  ];

  # Enable all cliPrograms modules
  cliPrograms.enable = true;

  # Enable all guiPrograms modules
  guiPrograms.enable = true;

  # Disable specific modules
  hyprland.enable = false;

}