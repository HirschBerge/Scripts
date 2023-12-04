
{ stdenv, fetchFromGitHub }:
{
  abstractdark-sddm-theme = stdenv.mkDerivation rec {
    pname = "abstractdark-sddm-theme";
    version = "";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/abstractdark-sddm-theme
    '';
    src = fetchFromGitHub {
      owner = "3ximus";
      repo = "abstractdark-sddm-theme";
      rev = "e817d4b27981080cd3b398fe928619ffa16c52e7";
      sha256 = "1si141hnp4lr43q36mbl3anlx0a81r8nqlahz3n3l7zmrxb56s2y";
    };
  };
  abstractguts-sddm-theme = stdenv.mkDerivation rec {
    pname = "abstractdark-sddm-theme";
    version = "";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/abstractguts-sddm-theme
    '';
    src = fetchFromGitHub {
      owner = "HirschBerge";
      repo = "abstractdark-sddm-theme";
      rev = "60284c29afebb7288ad0aea75bb93b064d9d0264";
      sha256 = "1c5azi6lvhmpbkdzc2ln33g32fh1ms0rbw2r3f0b9j81hwhl6fms";
    };
  };
}
