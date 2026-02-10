{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.firefox;
in {
  options = {
    module.firefox.enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        id = 0;
        isDefault = true;

        settings = {
          "browser.translations.enable" = false;
          "geo.enabled" = false;
          "image.jxl.enabled" = true;
          "widget.use-xdg-desktop-portal.file-picker" = 1;

          # Disable telemetry for privacy reasons
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.enabled" = false; # enforced by nixos
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;
          "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.urlbar.eventTelemetry.enabled" = false; # (default)
          "browser.safebrowsing.downloads.remote.enabled" = false;

          # Disable some useless stuff
          "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
          "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
          "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
          "identity.fxaccounts.enabled" = false; # disable firefox login
          "identity.fxaccounts.toolbar.enabled" = false;
          "identity.fxaccounts.pairing.enabled" = false;
          "identity.fxaccounts.commands.enabled" = false;
          "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
          "browser.uitour.enabled" = false; # no tutorial please
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "privacy.userContext.ui.enabled" = true;
          "media.eme.enabled" = true;
          "browser.eme.ui.enabled" = true;

          # disable annoying web features
          "dom.push.enabled" = false; # no notifications, really...
          "dom.push.connection.enabled" = false;
          "dom.battery.enabled" = false; # you don't need to see my battery...

          # Smooth Scrolling
          "apz.overscroll.enabled" = true;
          "general.smoothScroll" = true;
          "mousewheel.default.delta_multiplier_y" = 300;

          # Performance tweaks
          "widget.dmabuf.force-enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "gfx.webrender.compositor" = true;
          "gfx.webrender.all" = true;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "browser.sessionhistory.max_total_viewers" = 4;
          "browser.cache.disk.enable" = true;
          "browser.cache.disk.smart_size.enabled" = false;
          "browser.cache.disk.capacity" = 512000;
          "browser.cache.disk.max_entry_size" = 51200;
          "network.http.rcwn.enabled" = false;
          "browser.cache.disk.metadata_memory_limit" = 500;
          "browser.cache.disk.preload_chunk_count" = 4;
          "browser.cache.memory.capacity" = 131072;
          "browser.cache.memory.max_entry_size" = 20480;
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.ssl_tokens_cache_capacity" = 10240;
          "browser.low_commit_space_threshold_percent" = 20;
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          sponsorblock
          return-youtube-dislikes
          youtube-redux
          old-reddit-redirect
        ];

        search = {
          force = true;
          default = "ddg";
          order = [
            "google"
            "ddg"
            "youtube"
            "NixOS Options"
            "Nix Packages"
            "GitHub"
            "Home Manager"
          ];

          engines = {
            "bing".metaData.hidden = true;
            "amazon.com".metaData.hidden = true;

            "youtube" = {
              icon = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@yt"];
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Nix Packages" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "NixOS Options" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "GitHub" = {
              icon = "https://github.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@gh"];

              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Home Manager" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];

              url = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };
      };
    };
  };
}
