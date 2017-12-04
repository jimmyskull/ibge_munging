See the contents of the R and Python file.

Converting and compressing take together 10 minutes.

### Scripts

```
R -f convert_to_csv.R
python compress_csv.py
```

### Final files

```
import pandas as pd
homes = pd.read_csv('data/dom2015.csv.xz')
homes.shape
people = pd.read_csv('data/pes2015.csv.xz')
people.shape
```

```
>>> homes = pd.read_csv('dom2015.csv.xz')
>>> homes.shape
(151189, 86)
>>> people = pd.read_csv('pes2015.csv.xz')
>>> people.shape
(356904, 436)
```
