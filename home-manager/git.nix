{ account, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = account.realname;
        email = account.email;
      };
    };
  };
}