{ pkgs, ... }:

let
  py = pkgs.python313Packages;

  opencv = py.opencv4.override {
    enableGtk3 = true;
  };

  opencv-python = py.opencv-python.override {
    opencv4 = opencv;
  };

  insightface = py.insightface.overridePythonAttrs (old: {
    propagatedBuildInputs =
      builtins.filter
        (p: (p.pname or "") != "opencv-python")
        old.propagatedBuildInputs
      ++ [ opencv-python ];
  });

in

pkgs.python313.withPackages (ps: with ps; [
  torch
  torchvision
  torchaudio

  opencv

  facenet-pytorch
  dlib
  insightface

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