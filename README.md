[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/finsberg/word-count/HEAD)

# Word count example

This example project will count words in a given text and plot a bar chart of the 10
most common words.

- Inspired by and derived from https://github.com/coderefinery/word-count
  which is distributed under
  [Creative Commons Attribution license (CC-BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

## Install dependencies

### Python virtual environment
Create a virtual environement
```
python3 -m venv venv
```
and activate it. On Unix (MacOSX and Linux) you do
```
. \venv/bin/activate
```
and on Windows you do
```
.\venv\Scripts\activate
```
Next you can install the dependencies
```
python3 -m pip install -r requirements.txt
```

### Conda environment
Install the conda environment using
```
conda env create -f environment.yml
```
and activate the environment
```
conda activate word-count
```

## Exercises


### Exercise 1 

- Create an automated workflow to count all words in the [data](data) folder and save the results to a new directory called `results` using the script [count.py](code/count.py).
- Also, use the script [plot.py](code/plot.py) to create a figure for each dataset and save it in a folder called `figures`

**Note:** Make sure to use appropriate names for the results and figures. 

Solution: https://github.com/finsberg/word-count/tree/exercise-1


### Exercise 2

Create a test that verifies the implementation of `count_words` in [count.py](code/count.py). Add the test in a new folder called `tests`.

Run the test(s) with `pytest`.

**Tip 1:**
You can add the `code` directory to your python path in your test using the following snippet
```python
from pathlib import Path
import sys

here = Path(__file__).parent
sys.path.append((here / ".." / "code").as_posix())
```

**Tip 2:** You can run pytest using
```
python3 -m pytest
```

Solution: https://github.com/finsberg/word-count/tree/exercise-2

### Exercise 3
Create a GitHub action to run the test every time you push to the repo. 

- Create a folder called `.github/workflows` and add the file `tests.yml` to it with the following content.

```yml
# Simple workflow for deploying static content to GitHub Pages
name: Run tests

on: [push]

    # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
  workflow_call:


jobs:
  run:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install dependencies
        run: python3 -m pip install -r requirements.txt

      - name: Run tests
        run: python3 -m pytest tests
```

Solution: https://github.com/finsberg/word-count/tree/exercise-3

### Exercise 4

Create a GitHub workflow for running the full analysis and uploading the results and figures as artifact. Create a new file `.github/workflows/reproduce_results.yml` with the following content

```yml
# Simple workflow for deploying static content to GitHub Pages
name: Run tests

on: [push]

    # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
  workflow_call:


jobs:
  run:
    runs-on: ubuntu-22.04

    env:
      # Directory that will be published on github pages
      DATADIR: ./data
      FIGDIR: ./artifacts/figures
      RESULTDIR: ./artifacts/results


    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install dependencies
        run: python3 -m pip install -r requirements.txt

      - name: Run all experiments
        run: python3 run_all_experiments.py

      - name: Upload artifact
        if: always()
        uses: actions/upload-artifact@v3
        with:
          path: ./artifacts
          if-no-files-found: error

```

Solution: https://github.com/finsberg/word-count/tree/exercise-4