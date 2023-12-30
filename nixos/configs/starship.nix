  {config, pkgs, ...}:
 
 {
  programs.starship = {
      enable = true;
      settings = {
        # "$schema" = "https://starship.rs/config-schema.json";
        add_newline = true;
        command_timeout = 500;
        continuation_prompt = "[∙](bright-black) ";
        format = "[](0xCBA6F7)$username$hostname$localip$shlvl$singularity$kubernetes[](fg:0x9A348E bg:0xDA627D)$directory$vcsh[](fg:0xDA627D bg:0xFCA17D)$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch[](fg:0x86BBD8 bg:0x06969A)$docker_context$package$buf[](fg:0xFCA17D bg:0x86BBD8)$c$cmake$cobol$container$daml$dart$deno$dotnet$elixir$elm$erlang$golang$haskell$helm$java$julia$kotlin$lua$nim$nodejs$ocaml$perl$php$pulumi$purescript$python$rlang$red$ruby$rust$scala$swift$terraform$vlang$vagrant$zig$nix_shell$conda$spack$memory_usage$aws$gcloud$openstack$azure$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery[](fg:0x06969A bg:0x33658A)$time$status$shell$character";
        right_format = "";
        scan_timeout = 30;
        aws = {
          format = "[$symbol($profile )(($region) )([$duration] )]($style)";
          symbol = "🅰 ";
          style = "#cba6f7";
          disabled = false;
          expiration_symbol = "X";
          force_display = false;
        };
        aws.region_aliases = {};
        aws.profile_aliases = {};
        azure = {
          format = "[$symbol($subscription)([$duration])]($style) ";
          symbol = "ﴃ ";
          style = "#89b4fa";
          disabled = true;
        };
        battery = {
          format = "[$symbol$percentage]($style) ";
          charging_symbol = " ";
          discharging_symbol = " ";
          empty_symbol = " ";
          full_symbol = " ";
          unknown_symbol = " ";
          disabled = false;
          display = [
            {
              style = "#f38ba8";
              threshold = 10;
            }
          ];
        };
        buf = {
          format = "[$symbol ($version)]($style)";
          version_format = "v$raw";
          symbol = "";
          style = "#89b4fa";
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "buf.yaml"
            "buf.gen.yaml"
            "buf.work.yaml"
          ];
          detect_folders = [];
        };
        c = {
          format = "[$symbol($version(-$name) )]($style)";
          version_format = "v$raw";
          style = "fg:149 bold bg:0x86BBD8";
          symbol = " ";
          disabled = false;
          detect_extensions = [
            "c"
            "h"
          ];
          detect_files = [];
          detect_folders = [];
        };
        character = {
          format = "$symbol ";
          vicmd_symbol = "[❮](#D2F7A6)";
          disabled = false;
          success_symbol = "[➜](#D2F7A6) ";
          error_symbol = "[✗](#f38ba8) ";
        };
        cmake = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "△ ";
          style = "#89b4fa";
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "CMakeLists.txt"
            "CMakeCache.txt"
          ];
          detect_folders = [];
        };
        cmd_duration = {
          min_time = 2000;
          format = "⏱ [$duration]($style) ";
          style = "#cba6f7";
          show_milliseconds = false;
          disabled = false;
          show_notifications = false;
          min_time_to_notify = 45000;
        };
        cobol = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "⚙️ ";
          style = "#89b4fa";
          disabled = false;
          detect_extensions = [
            "cbl"
            "cob"
            "CBL"
            "COB"
          ];
          detect_files = [];
          detect_folders = [];
        };
        conda = {
          truncation_length = 1;
          format = "[$symbol$environment]($style) ";
          symbol = " ";
          style = "#D2F7A6";
          ignore_base = true;
          disabled = false;
        };
        container = {
          format = "[$symbol [$name]]($style) ";
          symbol = "⬢";
          style = "#f38ba8 dimmed";
          disabled = false;
        };
        crystal = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🔮 ";
          style = "#f38ba8";
          disabled = false;
          detect_extensions = ["cr"];
          detect_files = ["shard.yml"];
          detect_folders = [];
        };
        dart = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🎯 ";
          style = "#89b4fa";
          disabled = false;
          detect_extensions = ["dart"];
          detect_files = [
            "pubspec.yaml"
            "pubspec.yml"
            "pubspec.lock"
          ];
          detect_folders = [".dart_tool"];
        };
        deno = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🦕 ";
          style = "#D2F7A6";
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "deno.json"
            "deno.jsonc"
            "mod.ts"
            "deps.ts"
            "mod.js"
            "deps.js"
          ];
          detect_folders = [];
        };
        directory = {
          disabled = false;
          fish_style_pwd_dir_length = 0;
          format = "[$path]($style)[$read_only]($read_only_style) ";
          home_symbol = "~";
          read_only = " ";
          read_only_style = "red";
          repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
          style = "#74c7ec bg:0xDA627D";
          truncate_to_repo = true;
          truncation_length = 3;
          truncation_symbol = "…/";
          use_logical_path = true;
          use_os_path_sep = true;
        };
        directory.substitutions = {
          # Here is how you can shorten some long paths by text replacement;
          # similar to mapped_locations in Oh My Posh:;
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          # Keep in mind that the order matters. For example:;
          # "Important Documents" = "  ";
          # will not be replaced, because "Documents" was already substituted before.;
          # So either put "Important Documents" before "Documents" or use the substituted version:;
          # "Important  " = "  ";
          "Important " = " ";
        };
        docker_context = {
          format = "[$symbol$context]($style) ";
          style = "#89b4fa bg:0x06969A";
          symbol = " ";
          only_with_files = true;
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
          ];
          detect_folders = [];
        };
        dotnet = {
          format = "[$symbol($version )(🎯 $tfm )]($style)";
          version_format = "v$raw";
          symbol = "🥅 ";
          style = "#89b4fa";
          heuristic = true;
          disabled = false;
          detect_extensions = [
            "csproj"
            "fsproj"
            "xproj"
          ];
          detect_files = [
            "global.json"
            "project.json"
            "Directory.Build.props"
            "Directory.Build.targets"
            "Packages.props"
          ];
          detect_folders = [];
        };
        elixir = {
          format = "[$symbol($version (OTP $otp_version) )]($style)";
          version_format = "v$raw";
          style = "#cba6f7 bg:0x86BBD8";
          symbol = " ";
          disabled = false;
          detect_extensions = [];
          detect_files = ["mix.exs"];
          detect_folders = [];
        };
        elm = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          style = "#74c7ec bg:0x86BBD8";
          symbol = " ";
          disabled = false;
          detect_extensions = ["elm"];
          detect_files = [
            "elm.json"
            "elm-package.json"
            ".elm-version"
          ];
          detect_folders = ["elm-stuff"];
        };
        env_var = {};
        env_var.SHELL = {
          format = "[$symbol($env_value )]($style)";
          style = "grey bold italic dimmed";
          symbol = "e:";
          disabled = true;
          variable = "SHELL";
          default = "unknown shell";
        };
        env_var.USER = {
          format = "[$symbol($env_value )]($style)";
          style = "grey bold italic dimmed";
          symbol = "e:";
          disabled = true;
          default = "unknown user";
        };
        erlang = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = " ";
          style = "#f38ba8";
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "rebar.config"
            "erlang.mk"
          ];
          detect_folders = [];
        };
        fill = {
          style = "bold black";
          symbol = ".";
          disabled = false;
        };
        gcloud = {
          format = "[$symbol$account(@$domain)(($region))(($project))]($style) ";
          symbol = "☁️ ";
          style = "#89b4fa";
          disabled = false;
        };
        gcloud.project_aliases = {};
        gcloud.region_aliases = {};
        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
          symbol = " ";
          style = "#cba6f7 bg:0xFCA17D";
          truncation_length = 9223372036854775807;
          truncation_symbol = "…";
          only_attached = false;
          always_show_remote = false;
          ignore_branches = [];
          disabled = false;
        };
        git_commit = {
          commit_hash_length = 7;
          format = "[($hash$tag)]($style) ";
          style = "#D2F7A6";
          only_detached = true;
          disabled = false;
          tag_symbol = " 🏷  ";
          tag_disabled = true;
        };
        git_metrics = {
          added_style = "#D2F7A6";
          deleted_style = "#f38ba8";
          only_nonzero_diffs = true;
          format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
          disabled = false;
        };
        git_state = {
          am = "AM";
          am_or_rebase = "AM/REBASE";
          bisect = "BISECTING";
          cherry_pick = "🍒PICKING(#f38ba8)";
          disabled = false;
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          merge = "MERGING";
          rebase = "REBASING";
          revert = "REVERTING";
          style = "#cba6f7";
        };
        git_status = {
          ahead = "🏎💨$count";
          behind = "😰$count";
          conflicted = "🏳";
          deleted = "🗑";
          disabled = false;
          diverged = "😵";
          # format = "([[$all_status$ahead_behind]]($style) )";
          ignore_submodules = false;
          modified = "📝";
          renamed = "👅";
          staged = "[++($count)](green)";
          stashed = "📦";
          style = "#f38ba8 bg:0xFCA17D";
          untracked = "🤷";
          up_to_date = "✓";
        };
        golang = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = " ";
          style = "#74c7ec bg:0x86BBD8";
          disabled = false;
          detect_extensions = ["go"];
          detect_files = [
            "go.mod"
            "go.sum"
            "glide.yaml"
            "Gopkg.yml"
            "Gopkg.lock"
            ".go-version"
          ];
          detect_folders = ["Godeps"];
        };
        haskell = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "λ ";
          style = "#cba6f7 bg:0x86BBD8";
          disabled = false;
          detect_extensions = [
            "hs"
            "cabal"
            "hs-boot"
          ];
          detect_files = [
            "stack.yaml"
            "cabal.project"
          ];
          detect_folders = [];
        };
        helm = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "⎈ ";
          style = "bold white";
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "helmfile.yaml"
            "Chart.yaml"
          ];
          detect_folders = [];
        };
        hg_branch = {
          symbol = " ";
          style = "#cba6f7";
          format = "on [$symbol$branch]($style) ";
          truncation_length = 9223372036854775807;
          truncation_symbol = "…";
          disabled = true;
        };
        hostname = {
          disabled = false;
          format = "[$ssh_symbol](#89b4fa dimmed bold)[$hostname]($style) ";
          ssh_only = false;
          style = "#D2F7A6";
          trim_at = ".";
        };
        java = {
          disabled = false;
          format = "[$symbol($version )]($style)";
          style = "red dimmed bg:0x86BBD8";
          symbol = " ";
          version_format = "v$raw";
          detect_extensions = [
            "java"
            "class"
            "jar"
            "gradle"
            "clj"
            "cljc"
          ];
          detect_files = [
            "pom.xml"
            "build.gradle.kts"
            "build.sbt"
            ".java-version"
            "deps.edn"
            "project.clj"
            "build.boot"
          ];
          detect_folders = [];
        };
        jobs = {
          threshold = 1;
          symbol_threshold = 0;
          number_threshold = 2;
          format = "[$symbol$number]($style) ";
          symbol = "✦";
          style = "#89b4fa";
          disabled = false;
        };
        julia = {
          disabled = false;
          format = "[$symbol($version )]($style)";
          style = "#cba6f7 bg:0x86BBD8";
          symbol = " ";
          version_format = "v$raw";
          detect_extensions = ["jl"];
          detect_files = [
            "Project.toml"
            "Manifest.toml"
          ];
          detect_folders = [];
        };
        kotlin = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🅺 ";
          style = "#89b4fa";
          kotlin_binary = "kotlin";
          disabled = false;
          detect_extensions = [
            "kt"
            "kts"
          ];
          detect_files = [];
          detect_folders = [];
        };
        kubernetes = {
          disabled = false;
          format = "[$symbol$context( ($namespace))]($style) in ";
          style = "#74c7ec";
          symbol = "⛵ ";
        };
        kubernetes.context_aliases = {};
        line_break = {
          disabled = false;
        };
        localip = {
          disabled = false;
          format = "[@$localipv4]($style) ";
          ssh_only = false;
          style = "#cba6f7";
        };
        lua = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🌙 ";
          style = "#89b4fa";
          lua_binary = "lua";
          disabled = false;
          detect_extensions = ["lua"];
          detect_files = [".lua-version"];
          detect_folders = ["lua"];
        };
        memory_usage = {
          disabled = false;
          format = "$symbol[$ram( | $swap)]($style) ";
          style = "white bold dimmed";
          symbol = " ";
          # threshold = 75;
          threshold = -1;
        };
        nim = {
          format = "[$symbol($version )]($style)";
          style = "#cba6f7 bg:0x86BBD8";
          symbol = " ";
          version_format = "v$raw";
          disabled = false;
          detect_extensions = [
            "nim"
            "nims"
            "nimble"
          ];
          detect_files = ["nim.cfg"];
          detect_folders = [];
        };
        nix_shell = {
          format = "[$symbol$state( ($name))]($style) ";
          disabled = false;
          impure_msg = "[impure](#f38ba8)";
          pure_msg = "[pure](#D2F7A6)";
          style = "#89b4fa";
          symbol = " ";
        };
        nodejs = {
          format = "[$symbol($version )]($style)";
          not_capable_style = "#f38ba8";
          style = "#D2F7A6 bg:0x86BBD8";
          symbol = " ";
          version_format = "v$raw";
          disabled = false;
          detect_extensions = [
            "js"
            "mjs"
            "cjs"
            "ts"
            "mts"
            "cts"
          ];
          detect_files = [
            "package.json"
            ".node-version"
            ".nvmrc"
          ];
          detect_folders = ["node_modules"];
        };
        ocaml = {
          format = "[$symbol($version )(($switch_indicator$switch_name) )]($style)";
          global_switch_indicator = "";
          local_switch_indicator = "*";
          style = "#cba6f7";
          symbol = "🐫 ";
          version_format = "v$raw";
          disabled = false;
          detect_extensions = [
            "opam"
            "ml"
            "mli"
            "re"
            "rei"
          ];
          detect_files = [
            "dune"
            "dune-project"
            "jbuild"
            "jbuild-ignore"
            ".merlin"
          ];
          detect_folders = [
            "_opam"
            "esy.lock"
          ];
        };
        openstack = {
          format = "[$symbol$cloud(($project))]($style) ";
          symbol = "☁️  ";
          style = "#cba6f7";
          disabled = false;
        };
        package = {
          format = "[$symbol$version]($style) ";
          symbol = "📦 ";
          style = "#fab387";
          display_private = false;
          disabled = false;
          version_format = "v$raw";
        };
        perl = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🐪 ";
          style = "149 bold";
          disabled = false;
          detect_extensions = [
            "pl"
            "pm"
            "pod"
          ];
          detect_files = [
            "Makefile.PL"
            "Build.PL"
            "cpanfile"
            "cpanfile.snapshot"
            "META.json"
            "META.yml"
            ".perl-version"
          ];
          detect_folders = [];
        };
        php = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🐘 ";
          style = "147 bold";
          disabled = false;
          detect_extensions = ["php"];
          detect_files = [
            "composer.json"
            ".php-version"
          ];
          detect_folders = [];
        };
        pulumi = {
          format = "[$symbol($username@)$stack]($style) ";
          version_format = "v$raw";
          symbol = " ";
          style = "bold 5";
          disabled = false;
        };
        purescript = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "<=> ";
          style = "bold white";
          disabled = false;
          detect_extensions = ["purs"];
          detect_files = ["spago.dhall"];
          detect_folders = [];
        };
        python = {
          format = "[$symbol$pyenv_prefix($version )(($virtualenv) )]($style)";
          python_binary = [
            "python"
            "python3"
            "python2"
          ];
          pyenv_prefix = "pyenv ";
          pyenv_version_name = true;
          style = "#cba6f7";
          symbol = "🐍 ";
          version_format = "v$raw";
          disabled = false;
          detect_extensions = ["py"];
          detect_files = [
            "requirements.txt"
            ".python-version"
            "pyproject.toml"
            "Pipfile"
            "tox.ini"
            "setup.py"
            "__init__.py"
          ];
          detect_folders = [];
        };
        red = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🔺 ";
          style = "#f38ba8";
          disabled = false;
          detect_extensions = [
            "red"
            "reds"
          ];
          detect_files = [];
          detect_folders = [];
        };
        rlang = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          style = "#89b4fa";
          symbol = "📐 ";
          disabled = false;
          detect_extensions = [
            "R"
            "Rd"
            "Rmd"
            "Rproj"
            "Rsx"
          ];
          detect_files = [".Rprofile"];
          detect_folders = [".Rproj.user"];
        };
        ruby = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "💎 ";
          style = "#f38ba8";
          disabled = false;
          detect_extensions = ["rb"];
          detect_files = [
            "Gemfile"
            ".ruby-version"
          ];
          detect_folders = [];
          detect_variables = [
            "RUBY_VERSION"
            "RBENV_VERSION"
          ];
        };
        rust = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🦀 ";
          style = "#f38ba8 bg:0x86BBD8";
          disabled = false;
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
          detect_folders = [];
        };
        scala = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          disabled = false;
          style = "#f38ba8";
          symbol = "🆂 ";
          detect_extensions = [
            "sbt"
            "scala"
          ];
          detect_files = [
            ".scalaenv"
            ".sbtenv"
            "build.sbt"
          ];
          detect_folders = [".metals"];
        };
        shell = {
          format = "[$indicator]($style) ";
          bash_indicator = "bsh";
          cmd_indicator = "cmd";
          elvish_indicator = "esh";
          fish_indicator = "";
          ion_indicator = "ion";
          nu_indicator = "nu";
          powershell_indicator = "_";
          style = "white bold";
          tcsh_indicator = "tsh";
          unknown_indicator = "mystery shell";
          xonsh_indicator = "xsh";
          zsh_indicator = "zsh";
          disabled = false;
        };
        shlvl = {
          threshold = 2;
          format = "[$symbol$shlvl]($style) ";
          symbol = "↕️  ";
          repeat = false;
          style = "#cba6f7";
          disabled = true;
        };
        singularity = {
          format = "[$symbol[$env]]($style) ";
          style = "#89b4fa";
          symbol = "📦 ";
          disabled = false;
        };
        spack = {
          truncation_length = 1;
          format = "[$symbol$environment]($style) ";
          symbol = "🅢 ";
          style = "#89b4fa";
          disabled = false;
        };
        status = {
          format = "[$symbol$status]($style) ";
          map_symbol = true;
          not_executable_symbol = "🚫";
          not_found_symbol = "🔍";
          pipestatus = false;
          pipestatus_format = "[$pipestatus] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
          pipestatus_separator = "|";
          recognize_signal_code = true;
          signal_symbol = "⚡";
          style = "#f38ba8 bg:#89b4fa";
          success_symbol = "🟢 SUCCESS";
          symbol = "🔴 ";
          disabled = true;
        };
        sudo = {
          format = "[as $symbol]($style)";
          symbol = "🧙 ";
          style = "#89b4fa";
          allow_windows = false;
          disabled = true;
        };
        swift = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🐦 ";
          style = "bold 202";
          disabled = false;
          detect_extensions = ["swift"];
          detect_files = ["Package.swift"];
          detect_folders = [];
        };
        terraform = {
          format = "[$symbol$workspace]($style) ";
          version_format = "v$raw";
          symbol = "💠 ";
          style = "bold 105";
          disabled = false;
          detect_extensions = [
            "tf"
            "tfplan"
            "tfstate"
          ];
          detect_files = [];
          detect_folders = [".terraform"];
        };
        time = {
          format = "[$symbol $time]($style) ";
          style = "#cba6f7 bg:0x33658A";
          use_12hr = false;
          disabled = false;
          utc_time_offset = "local";
          # time_format = "%R"; # Hour:Minute Format;
          time_format = "%T"; # Hour:Minute:Seconds Format;
          time_range = "-";
        };
        username = {
          format = " [$user]($style) ";
          show_always = true;
          style_root = "#f38ba8 bg:0x9A348E";
          style_user = "#cba6f7 bg:0x9A348E";
          disabled = false;
        };
        vagrant = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "⍱ ";
          style = "#74c7ec";
          disabled = false;
          detect_extensions = [];
          detect_files = ["Vagrantfile"];
          detect_folders = [];
        };
        vcsh = {
          symbol = "";
          style = "#cba6f7";
          format = "[$symbol$repo]($style) ";
          disabled = false;
        };
        vlang = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "V ";
          style = "#89b4fa";
          disabled = false;
          detect_extensions = ["v"];
          detect_files = [
            "v.mod"
            "vpkg.json"
            ".vpkg-lock.json"
          ];
          detect_folders = [];
        };
        zig = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "↯ ";
          style = "#cba6f7";
          disabled = false;
          detect_extensions = ["zig"];
          detect_files = [];
          detect_folders = [];
        };
        custom = {
        };
      };
    };
}
