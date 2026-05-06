{ pkgs, ... }:

pkgs.python313.withPackages (python-pkgs: with python-pkgs; [
    torch
    torchvision
    torchaudio
    (python-pkgs.opencv4.override {
        enableGtk3 = true;
    })
    facenet-pytorch
    dlib


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
