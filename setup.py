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
