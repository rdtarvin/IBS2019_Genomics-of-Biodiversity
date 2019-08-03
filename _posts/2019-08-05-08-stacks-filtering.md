---
layout: default
order: 8
title:  "exporting and filtering matrices"
date:   2019-08-05
time:   "14:00-15:00"
categories: main
instructor: "Becca & Pati"
materials: "https://docs.google.com/presentation/d/1ZfCd0jIuNm4MwdCTw0MOXtyLBBlpRB3Xt_jHWhOcQhk/pub?start=false&loop=false&delayms=60000"
material-type: "ppt"
lesson-type: Interactive
---


Getting the output with **populations**
----

The final step in the stacks pipeline is to run the program **populations**, which is essentially just filtering, exporting, and summarizing data infor the formats that you soecify (as in, genotyping is already finished). However, another super nice thing about this program is that it runs populations stats for you and puts them in a nice excel-readable output!! :D yay easy pogen stats!!  

To run **populations**, we first need to develop a popmap file, which simply contains names of sequences (first column) and some population code (second column)that they belong to, tab delimited. Our sample/file names alrady contain the population information, so try to build it yourself.... how do you want to do it???



Now, let's run **populations** using the following command:

    populations -P ./denovo -M ./epi_popmap.txt  --vcf  # takes ~3min
    # you can also produce outputs for STRUCTURE and GENEPOP, along with specific phylip files (but be careful in how you create these!) and full loci fasta files
    # this is the bare minimum for run populations, you can also filter for minimum number of individuals per population or minor allele frequency, etc. 
    # Pati will go more into filtering later


<br><br>



<br><br>

<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/06-stacks-pipeline.html"><button>Previous Lesson</button></a><a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/09-raxml-epi.html"><button>Next Lesson</button></a>


## Appendix

If you're unable to perform the populations step, you can download the complete denovo folder (with populations output) [here](https://drive.google.com/drive/folders/1RdCsMo6YpOppUigrDgdDv7ju3xaBFD2G?usp=sharing).<br>
A full run of stacks with these data (approx 1.5GB) can be downloaded [here](https://drive.google.com/drive/folders/172ZgAdYmVJhZ_ILaKgY5EHRqV-dWnf_y?usp=sharing).<br>

There are actually several ways to look at .gz files, such as:
```
zless epiddrad_t200_R1_.fastq.gz # press 'q' to exit
gzcat epiddrad_t200_R1_.fastq.gz | head # the "|" pipes stdout to the program "head"
gzcat epiddrad_t200_R1_.fastq.gz | head -100 # shows the first 100 lines
```




Post-filtering in **vcftools**
----
First, let's remember the nature of RADseq datasets: what do we expect if we prepared our libraries based on a non-targeted loci protocol? What should our original SNP matrix - before we filter any final genotyped loci - look like? Could it look different depending on the divergence within our datasets?  



The filters implemented in ***populations*** are not the best. One of the main filters, `-p`, essentially filters out loci that are not present in the number of populations you specify. Thus, depending on how you define your populations, and how many individuals are sampled within populations, some loci may be completely eliminated from your matrix, simply because a single individual, sole member of a population, was poorly genotyped and thus most good loci are being dropped because of this one bad individual! Similarly, the filter `-r` is filtering out according to a specified proportion of individuals within a population, so once again is very sensitive to how you define your populations in the first place! 


Thus, it is better to have more control over filters that are implemented in your SNP matrices, and that are the least biased possible. For that, we will filter using the program [vcftools]() which uses the input file format `.vcf`, which we exported using populations, and run the three most important and commonly used filters: 

1. First, filter loci with less than 60% individuals sequenced

		./plink --file filename --geno 0.4 --recode --out filename_a --noweb


2. Then, filter individuals that have less than 50% data

		./plink --file filename_a --mind 0.5 --recode --out filename_b --noweb


3. Third, filter loci with Minor Allele Frequency < 0.02 in remaining individuals and loci

		/.plink --file filename_b --maf 0.02 --recode --out filename_c --noweb

4. Other filters: We can also filter by 

- Linkage Disequilibium: very important if running certain popgen stats
- 
