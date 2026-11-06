{
  config,
  autoPatchelfHook,
  boost,
  bzip2,
  cereal,
  cmake,
  eigen_5,
  kdePackages,
  fetchFromGitLab,
  fmt,
  freeglut,
  glew,
  lib,
  libepoxy,
  libGL,
  lz4,
  magic-enum,
  nix-update-script,
  opencv,
  pkg-config,
  stdenv,
  onetbb,
  libx11,
  cudaPackages,
  enableCuda ? config.cudaSupport,
}:

let
  opencv' = opencv.override { enableGtk3 = true; };
in
stdenv.mkDerivation {
  pname = "basalt-monado";
  version = "0-unstable-2025-09-25";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "ultradev";
    repo = "basalt";
    rev = "ed54fb5bcd7911c00848f24f53ad9fc916ed656a";
    hash = "sha256-AopiitemPG2WUJ77UsEX13PeYvrvbJ/0301eSEeFL8g=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    cmake
    kdePackages.extra-cmake-modules
    pkg-config
  ];

  buildInputs = [
    boost
    bzip2
    cereal
    eigen_5
    fmt
    freeglut
    glew
    libepoxy
    libGL
    lz4
    magic-enum
    opencv'.cxxdev
    onetbb
    libx11
  ]
  ++ lib.optionals enableCuda [
    cudaPackages.cuda_nvcc
  ];

  cmakeFlags = [
    (lib.cmakeBool "BASALT_INSTANTIATIONS_DOUBLE" false)
    (lib.cmakeBool "BUILD_TESTS" false)
    (lib.cmakeFeature "EIGEN_ROOT" "${eigen_5}/include/eigen3")
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Fork of Basalt improved for tracking XR devices with Monado";
    homepage = "https://gitlab.freedesktop.org/mateosss/basalt";
    license = lib.licenses.bsd3;
    mainProgram = "basalt_vio";
    maintainers = [ lib.maintainers.locochoco ];
    platforms = lib.platforms.linux;
  };
}
