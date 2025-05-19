{
  pkgs,
  ...
}:
{
  config = {
    users.users.fallo = {
      isNormalUser = true;
    };
  };
}
