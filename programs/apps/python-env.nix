{ pkgs, ... }:

let
    opencv4Full-gtk = pkgs.python313Packages.opencv4Full.override {
        enableGtk3 = true;
    };
in
pkgs.python313.withPackages (python-pkgs: with python-pkgs; [
    torch
    torchvision
    torchaudio
    opencv4Full-gtk
    facenet-pytorch
    dlib
    (insightface.override {
        opencv4 = opencv4Full-gtk;
    });

    # ── QOL ────────────────────────────────────
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

    # ── HTTP / Web ─────────────────────────────
    requests
    httpx
    aiohttp
    beautifulsoup4
    lxml

    # ── Data / Math ────────────────────────────
    numpy
    pandas
    scipy
    scikit-learn
    matplotlib
    seaborn
    tabulate
    sympy
    statsmodels

    # ── Dev / Testing ──────────────────────────
    pytest
    pytest-cov
    hypothesis
    black
    ruff
    mypy
    tox

    # ── Serialization / Formats ────────────────
    pyyaml
    tomli
    toml
    orjson
    msgpack
    jsonschema
    openpyxl
    pillow

    # ── System / Utils ─────────────────────────
    psutil
    watchdog
])
