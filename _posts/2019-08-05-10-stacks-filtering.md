---
layout: default
order: 10
title:  "General genotyping pipeline and filtering components"
date:   2019-08-05
time:   "16:30-17:30"
categories: main
instructor: "Pati"
materials: "https://docs.google.com/presentation/d/1ZfCd0jIuNm4MwdCTw0MOXtyLBBlpRB3Xt_jHWhOcQhk/pub?start=false&loop=false&delayms=60000"
material-type: "ppt"
lesson-type: Lecture
---

## alternatively we can do Q&A, future of genomics, or something else

# Here's some text of yours from another lesson

Before we move on to the next steps.... let's [talk a bit](https://docs.google.com/presentation/d/1ZfCd0jIuNm4MwdCTw0MOXtyLBBlpRB3Xt_jHWhOcQhk/pub?start=false&loop=false&delayms=60000) about post-genotyping filters and the nature of RADseq datasets and SNP matrices... 


Post-filtering in **plink**
----
We are now going to filter our matrix to reduce biases and incorrect inferences due to missing data (in individuals and SNPs)and by Minor Allele Frequency. 


1. First, we filter loci with less than 60% individuals sequenced

		./plink --file filename --geno 0.4 --recode --out filename_a --noweb


2. Second, we filter individuals that have less than 50% data

		./plink --file filename_a --mind 0.5 --recode --out filename_b --noweb


3. Third, we filter loci with MAF < 0.02 in remaining individuals

		/.plink --file filename_b --maf 0.02 --recode --out filename_c --noweb


Second output from stacks *populations*
----

Now we are going to re-run the last step of the **STACKS** pipeline, so that we can get the nice population stats with out cleaner matrix. 

We need to make a ***whitelist*** file, which is a list of the loci to include based on the plink results (i.e. on amount of missing data in locus). The whitelist file format is ordered as a simple text file containing one catalog locus per line: 

		% more whitelist
		3
		7
		521
		11
		46
		103
		972
		2653
		22
		
		
In order to get from the .map file to the whitelist file format, open *_c.map file in Text Wrangler, and do find and replace arguments using **grep**:


	search for \d\t(\d*)_\d*\t\d\t\d*$
	replace with \1



Using the **.irem** file from the second iteration of *plink* (in our example named with termination **"_b"**), remove any individuals from the first popmap if they did not pass **plink** filters so that they are excluded from the analysis (i.e. individuals with too much missing data). 


Now we can run populations again using the whitelist of loci and the updated popmap file for loci and individuals to retain based on the plink filters.

	populations -b 1 -P ./ -M ./popmap.txt  -p 1 -r 0.5 -W Pr-whitelist --write_random_snp --structure --plink --vcf --genepop --fstats --phylip
	

We will use many of these outputs for downstream analyses. Outputs are: 

	batch_2.hapstats.tsv
	batch_2.phistats.tsv
	batch_2.phistats_1-2.tsv
	batch_2.phistats_1-3.tsv
	batch_2.phistats_2-3.tsv
	batch_2.sumstats.tsv
	batch_2.sumstats_summary.tsv
	batch_2.haplotypes.tsv
	batch_2.genepop
	batch_2.structure.tsv
	batch_2.plink.map
	batch_2.plink.ped
	batch_2.phylip
	batch_2.phylip.log
	batch_2.vcf
	batch_2.fst_1-2.tsv
	batch_2.fst_1-3.tsv
	batch_2.populations.log
	batch_2.fst_summary.tsv
	batch_2.fst_2-3.tsv




