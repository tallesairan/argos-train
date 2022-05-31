#!/usr/bin/env python3

from pathlib import Path
import json
import subprocess
import shutil
import sys
import argostrain
from argostrain.dataset import *
from argostrain import data
from argostrain import opennmtutils
from argostrain import settings

import stanza

settings.RUN_PATH.mkdir(exist_ok=True)
settings.CACHE_PATH.mkdir(exist_ok=True)

 
# Fix Oversize
MAX_DATA_SIZE = 998185 * (10 ** 7)

# bypass source target check for testing
#assert not settings.SOURCE_PATH.is_file() and not settings.TARGET_PATH.is_file()

from_code = input("From code (ISO 639): ")
to_code = input("To code (ISO 639): ")
from_name = input("From name: ")
to_name = input("To name: ")
version = input("Version: ")
package_version = version
argos_version = "1.5"


subprocess.run(
    [
        "./../OpenNMT-py/tools/average_models.py",
        "-m",
        "run/openmt.model_step_49000.pt",
        "run/openmt.model_step_50000.pt",
        "-o",
        "run/averaged.pt",
    ]
)

subprocess.run(
    [
        "ct2-opennmt-py-converter",
        "--model_path",
        "run/averaged.pt",
        "--output_dir",
        "run/model",
        "--quantization",
        "int8",
    ]
)

package_version = '1.2'

package_version_code = package_version.replace(".", "_")
model_dir = f"translate-{from_code}_{to_code}-{package_version_code}"
model_path = Path("run") / model_dir


# Include a Stanza sentence boundary detection model
stanza_model_located = False
stanza_lang_code = from_code
while not stanza_model_located:
    try:
        stanza.download(stanza_lang_code, dir="run/stanza", processors="tokenize")
        stanza_model_located = True
    except:
        print(f"Could not locate stanza model for lang {stanza_lang_code}")
        print(
            "Enter the code of a different language to attempt to use its stanza model."
        )
        print(
            "This will work best for with a similar language to the one you are attempting to translate."
        )
        print(
            "This will require manually editing the Stanza package in the finished model to change its code"
        )
        stanza_lang_code = input("Stanza language code (ISO 639): ")


subprocess.run(["cp", "-r", "run/stanza", model_path])

subprocess.run(["cp", "run/metadata.json", model_path])
subprocess.run(["cp", "run/README.md", model_path])

package_path = (
    Path("run") / f"translate-{from_code}_{to_code}-{package_version_code}.argosmodel"
)

shutil.make_archive(model_dir, "zip", root_dir="run", base_dir=model_dir)
subprocess.run(["mv", model_dir + ".zip", package_path])

# Make .argoscheckpoint zip

latest_checkpoint = opennmtutils.get_checkpoints()[-1]
print(latest_checkpoint)
print(latest_checkpoint.name)
print(latest_checkpoint.num)

print(f"Package saved to {str(package_path.resolve())}")
