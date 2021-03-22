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

#Overwrite the fasta file concatenating the OTU identifier to the sequence identifier
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
    
    #Read the fasta file
    seqs = fastaReader(file_name)

    #Create a list w refseq ids
    refseq_list = []
    for item in seqs:
        refseq_list.append(item[0])

    Entrez.email = input('Type your e-mail: ')
    
    #Convert from refseq to entrez
    genes = search_genes(refseq_list)
    #get the entrez data
    entrez_data = fetch_genes(genes)
    #Filter the .xml creating a dictionary with OTUs and taxons for each refseqID
    final = organism_parser(entrez_data)

    print (str(str(len(final)) + ' taxonomes found from '
              + str(len(refseq_list)) + ' sequences'))

    #Create a pandas df. from the dictionary
    taxonomies=pd.DataFrame.from_dict(final, orient="index")
    
    #Filter for bacteria
    bac_taxons=taxonomies.loc[taxonomies[1] == 'Bacteria']
    main_name=file_name.split(".")[0]
    
    #Write a csv with the refseqs and the organism data
    bac_taxons.to_csv(main_name+"_tax_counts.csv", header=False)

    definitive_sequences=[]
    for seq in seqs:
        if (seq[0] in bac_taxons.index):
            seq_name=(seq[0],seq[1],bac_taxons.loc[seq[0],0])
            definitive_sequences.append(seq_name)
            
    #Overwrite the fasta file 
    write_fasta(file_name,definitive_sequences)
    
    		

