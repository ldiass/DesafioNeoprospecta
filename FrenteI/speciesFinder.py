#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module Description
Identification of species and taxonomy based on Entrez nuccore database. With support for refseq IDs.
Code based on:
https://github.com/taoliu/taolib/blob/master/Scripts/convert_gene_ids.py

This code is free software
@status:  experimental
@version: 0.1
@author:  Luis Dias Ferreira Soares
@contact: ldiass@live.com
"""

import sys
from Bio import Entrez
import argparse

#Read the fasta file and return a list with tuples for the sequences and its IDs
def fastaReader(filename):
    seqs = []
    try:
        inputfile = open(filename)
	# Creates a list of tuples with the ID and the sequence

        for line in inputfile:
            if line[0] == '>':
                line = line[1:-1]
                seqs.insert(0, (line, inputfile.readline().replace('\n'
                            , '')))
        inputfile.close()
    except:
        print('File not found')
        raise
    return seqs

#Query the refseqs on nucleotide database, returning a list of entrez IDs
def search_genes(id_list):
    if len(id_list) > 100000:
        print('Max number of sequences (100,000) exceeded, split your fasta')
        sys.exit()
    term = ' OR '.join([x for x in id_list])
    esearch_result = Entrez.esearch(db='nucleotide', term=term,
                                    retmod='xml', retmax=100000)
    parsed_result = Entrez.read(esearch_result)
    return parsed_result['IdList']

#Post the list of entrezID on Entrez and query them on nuccore database, returning a list with .xml for each sequence containing data from different sources
def fetch_genes(id_list):
    request = Entrez.epost('nuccore', id=','.join(id_list))
    result = Entrez.read(request)
    webEnv = result['WebEnv']
    queryKey = result['QueryKey']
    efetch_result = Entrez.efetch(db='nuccore', webenv=webEnv,
                                  query_key=queryKey, retmode='xml')
    genes = Entrez.read(efetch_result, validate=False)
    return genes

#Parse the .xml list and gather the OTU, the taxonomy data. Return a dictionary with the refseq as key.
def organism_parser(entrez_dic):
    results = {}
    for item in entrez_dic:
        taxonomies=[item['GBSeq_organism']]
        taxonomies =taxonomies+item['GBSeq_taxonomy'].split('; ')        
        results[item['GBSeq_accession-version']] = taxonomies
    return results

#Write a .csv file with the refseq, the its OTU and taxonomy data
def write_taxonomy(file_name, taxonomy_dic):
    f = open(file_name[:-5] + '_taxonomy.csv', 'w')
    for (refSeq, taxonomy) in list(taxonomy_dic.items()):
        row = refSeq + ','
        row = row + str(taxonomy) + '\n'
        f.write(row)
    f.close()


if __name__ == '__main__':    
    parser = argparse.ArgumentParser(description='Species finder')
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
    print(str(str(len(refseq_list)) + ' taxonomies found from '
              + str(len(final)) + ' sequences'))
    write_taxonomy(file_name, final)

