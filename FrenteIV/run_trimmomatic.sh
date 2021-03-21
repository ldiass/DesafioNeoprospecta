#!/bin/bash
mkdir ./trimmed_SW530_ML180

for i in genomes/*.fastq; do
	filename=$(basename $i)
	trimmomatic SE -phred33 "$i" ./trimmed_SW530_ML180/$filename SLIDINGWINDOW:5:30 MINLEN:180
	fastqc ./trimmed_SW530_ML180/$filename
done

multiqc trimmed_SW530_ML180/*

