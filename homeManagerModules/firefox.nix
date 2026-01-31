{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rw = {
    firefox.enable = lib.mkEnableOption "Firefox (web browser) configuration.";
  };
  config = lib.mkIf config.rw.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        personal = {
          id = 0;
          name = "personal";
          isDefault = true;
        };
        work = {
          id = 1;
          name = "work";
        };
      };
    };
    programs.firefoxpwa = {
      enable = true;
      profiles = {
        # Personal profile
        "01KGA0FRMJXWPRW4GK63CK0QSZ".sites = {
          "01KGA0G1D4QS41EA4DYG8K1V5W" = {
            name = "pgAdmin 4";
            url = "http://localhost:5050";
            manifestUrl =
              "file://"
              + (pkgs.writeText "pgadmin.webmanifest" ''
                {
                  "name": "pgAdmin 4",
                  "start_url": "http://localhost:5050",
                  "icons": [
                    {
                      "src": "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/500px-Postgresql_elephant.svg.png",
                      "sizes": "512x512",
                      "type": "image/png"
                    }
                  ]
                }
              '');
            desktopEntry.icon = pkgs.fetchurl {
              url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/500px-Postgresql_elephant.svg.png";
              sha256 = "sha256-fxQApSQen4grUg2ASJTn/6V9/+UtdY+zfMjMtKem3Ds=";
            };
          };
          "01KGA23S6BKJX25NCVQ0WA88JT" = {
            name = "Gmail";
            url = "https://mail.google.com";
            manifestUrl = "https://mail.google.com/mail/u/0/manifest.json";
            desktopEntry.icon = ../resources/assets/gmail.png;
          };
          "01KGAAKTZFT213SDPDB5JG3DJD" = {
            name = "Mail UTT";
            url = "https://mail.utt.fr";
            manifestUrl =
              "file://"
              + (pkgs.writeText "pgadmin.webmanifest" ''
                {
                  "name": "Mail UTT",
                  "start_url": "https://mail.utt.fr",
                }
              '');
            desktopEntry.icon = ../resources/assets/utt.jpg;
          };
        };

        # Work profile
        "01KG9QDN9N0ZN3TZED0JK6R9H1".sites = {
          "01KGA37JSEP0Y4F7GBF7848F5Q" = {
            name = "Outlook";
            url = "https://outlook.office365.com";
            manifestUrl = "https://outlook.office.com/mail/manifests/pwa.json";
            desktopEntry.icon = ../resources/assets/outlook.png;
          };
        };
      };
    };
  };
}
