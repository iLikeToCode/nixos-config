{
  pkgs,
  ...
}:

let
  pkgs' = import pkgs.path {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        opencv = prev.opencv.override {
          enableGtk3 = true;
        };
      })
    ];
  };

in

pkgs'.python313.withPackages (ps: with ps; [
  torch
  torchvision
  torchaudio

  opencv4
  facenet-pytorch
  dlib
  insightface

  pygame

  flake8
  rich
  typer
  click
  loguru
  python-dotenv
  tqdm
  humanize
  attrs
  pydantic

  requests
  httpx
  aiohttp
  beautifulsoup4
  lxml

  numpy
  pandas
  scipy
  scikit-learn
  matplotlib
  seaborn
  tabulate
  sympy
  statsmodels

  pytest
  pytest-cov
  hypothesis
  black
  ruff
  mypy
  tox

  pyyaml
  tomli
  toml
  orjson
  msgpack
  jsonschema
  openpyxl
  pillow

  psutil
  watchdog
])