{pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.hirschy = {
      name = "Hirschy";
      settings = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
      };
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        lastpass-password-manager
        ublock-origin
        sponsorblock
        enhancer-for-youtube
        return-youtube-dislikes
      ];
      search = {
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        default = "Google";
      };
      bookmarks = [
        {
          toolbar = true;
          bookmarks = [
            {
              name = "Nix sites";
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = [ "wiki" "nix" ];
                  url = "https://nixos.wiki/";
                }
            ];
            }
            {
              name = "AniWave";
              # toolbar = true;
              url = "https://aniwave.to/home";
            }
            {
              name = "Pathfinder";
              bookmarks = [
                {
                  name = "Dominion";
                  url = "https://docs.google.com/spreadsheets/d/1nNXydoOHAUUW18FTjk4O5QZnyipzyVkQ5rm2V-5bUaE/edit?pli=1";
                }
                {
                  name = "Pathbuilder2E";
                  # toolbar = true;
                  url = "https://pathbuilder2e.com/app.html?v=71a";
                }
                {
                  name = "Roll20";
                  url = "https://app.roll20.net/campaigns/search/";
                }
                {
                  name = "Mark's Books";
                  url = "https://drive.google.com/drive/folders/1uce9hs9MrRcIZebNvdQbvYLi-6vbkV9m";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
