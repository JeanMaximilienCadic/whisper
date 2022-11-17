<h1 align="center">
  <br>
  <img src="https://drive.google.com/uc?id=1GpX9TnrUt16WlduNmiwwLmSZlBkeTp-q">
  <br>
    Whisper
  <br>
  (English/Japanese/Multi-lingual)
</h1>

<p align="center">
  <a href="#modules">Modules</a> •
  <a href="#code-structure">Code structure</a> •
  <a href="#installing-the-application">Installing the application</a> •
  <a href="#makefile-commands">Makefile commands</a> •
  <a href="#environments">Environments</a> •
  <a href="#dataset">Dataset</a>•
  <a href="#running-the-application">Running the application</a>•
  <a href="#notes">Notes</a>•
</p>


# Modules

At a granular level, whisper is a library that consists of the following components:

| Component | Description |
| ---- | --- |
| **whisper** | Speech Recognition package |
| **whisper.infer** | whisper Inference from audio files |
| **whisper.tests** | Unittests |


# Code structure
```python
import os

import pkg_resources
from setuptools import setup, find_packages
from whisper import __version__

setup(
    name="whisper",
    py_modules=["whisper"],
    version=__version__,
    description="Robust Speech Recognition via Large-Scale Weak Supervision",
    long_description="".join(open("README.md", "r").readlines()),
    long_description_content_type="text/markdown",
    readme="README.md",
    python_requires=">=3.7",
    author="OpenAI, CADIC Jean Maximilien",
    include_package_data=True,
    package_data={"": ["*.flac", "*.txt", "*.json", "*.npz"]},
    url="https://github.com/openai/whisper",
    license="MIT",
    packages=find_packages(),
    install_requires=[
        str(r)
        for r in pkg_resources.parse_requirements(
            open(os.path.join(os.path.dirname(__file__), "requirements.txt"))
        )
    ],
    entry_points={
        "console_scripts": ["whisper=whisper.transcribe:cli"],
    },
)
```


# Installing the application
To clone and run this application, you'll need the following installed on your computer:
- [Git](https://git-scm.com)
- Docker Desktop
   - [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)
   - [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
   - [Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)
- [Python](https://www.python.org/downloads/)

Install bpd:
```bash
# Clone this repository and install the code
git clone https://github.com/JeanMaximilienCadic/whisper

# Go into the repository
cd whisper
```


# Makefile commands
Exhaustive list of make commands:
```
build_dockers       # Build the docker images 
sandbox             # Launch a sandbox
tests               # Test the code
```
# Environments
Install [PyTorch](https://github.com/pytorch/pytorch#installation)
Install [Nvidia Docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## Docker

> **Note**
> 
> Running this application by using Docker is recommended.

To build and run the docker image
```
make build_dockers
make sandbox
```

## PythonEnv

> **Warning**
> 
> Running this application by using PythonEnv is possible but *not* recommended.
```
pip install dist/*.whl
```

## Test
```
make tests
```


## Pretrained model
```bash
python -m whisper.infer --audio_path <PATH TO AUDIO FILE (EN/JA/Others)>
```

## Acknowledgements

Thanks to [Jong Wook Kim](https://github.com/jongwook) and [OpenAI](https://github.com/openai/whisper) for their contributions!

This is a fork from https://github.com/openai/whisper.

For any question please contact me at j.cadic[at]protonmail.ch
