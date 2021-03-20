#!/usr/bin/env python
"""Module Description
Deplet non-bacteria sequences from multifasta.

This code is free software
@status:  experimental
@version: 0.1
@author:  Luis Dias Ferreira Soares
@contact: ldiass@live.com
"""

import sys
import argparse
import pandas as pd
from speciesFinder import *
from Bio import Entrez

def write_fasta(file_name, seq_list):
    f = open(file_name, 'w')
    for seq in seq_list:
        row=">"+seq[0]+"_"+seq[2]+'\n'+seq[1]+'\n'
        f.write(row)
    f.close()
    print(file_name+" written")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Bacteria filter')
    parser.add_argument('filename', metavar='filename', type=str, nargs=1,
                        help='Path to file with the multifasta databank')
    args = parser.parse_args()    
    file_name = args.filename[0]
    seqs = fastaReader(file_name)

    refseq_list = []
    for item in seqs:
        refseq_list.append(item[0])

    Entrez.email = input('Type your e-mail: ')
    genes = search_genes(refseq_list)
    entrez_data = fetch_genes(genes)
    final = organism_parser(entrez_data)

    print (str(str(len(final)) + ' taxonomes found from '
              + str(len(refseq_list)) + ' sequences'))

    taxonomies=pd.DataFrame.from_dict(final, orient="index")
    
    bac_taxons=taxonomies.loc[taxonomies[1] == 'Bacteria']
    main_name=file_name.split(".")[0]
    bac_taxons.to_csv(main_name+"_tax_counts.csv", header=False)

    definitive_sequences=[]
    for seq in seqs:
        if (seq[0] in bac_taxons.index):
            seq_name=(seq[0],seq[1],bac_taxons.loc[seq[0],0])
            definitive_sequences.append(seq_name)

    write_fasta(file_name,definitive_sequences)
    
    		

