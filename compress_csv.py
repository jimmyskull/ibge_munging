# -*- coding: utf-8 -*-
import pandas as pd
import logging

# Reads CSV file |input_fname| and writes it XZ compressed.
def compress_csv(input_fname):
    logging.info(f'Reading {input_fname!r}')
    data = pd.read_csv(input_fname)
    output_fname = f'{input_fname}.xz'
    logging.info(f'Writing {output_fname!r}')
    data.to_csv(output_fname, compression='xz')
    logging.info(f'Done compressing and writing {output_fname!r}')

logging.basicConfig(
    filename='compress_csv.log',
    filemode='a',
    format='%(asctime)s %(levelname)s %(message)s',
    level=logging.DEBUG)

compress_csv('data/dom2015.csv')
compress_csv('data/pes2015.csv')
