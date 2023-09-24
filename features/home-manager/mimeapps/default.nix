{ vars, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-sheme-handler/http" = "${vars.programs.chrome.name}.desktop";
      "text/html" = "${vars.programs.chrome.name}.desktop";
      "text/xml" = "${vars.programs.chrome.name}.desktop";
      "application/xhtml_xml" = "${vars.programs.chrome.name}.desktop";
      "image/webp" = "${vars.programs.chrome.name}.desktop";
      "x-scheme-handler/https" = "${vars.programs.chrome.name}.desktop";
      "x-scheme-handler/ftp" = "${vars.programs.chrome.name}.desktop";
    };
  };
}
