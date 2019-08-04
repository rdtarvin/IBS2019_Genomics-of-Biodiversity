---
layout: default
order: 8
title:  "exporting and filtering matrices"
date:   2019-08-05
time:   "14:00-15:00"
categories: main
instructor: "Becca & Pati"
materials: ""
material-type: ""
lesson-type: Interactive
---
<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/05-stacks-epi.html"><button>Stacks lesson</button></a><a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/09-raxml-epi.html"><button>RAxML</button></a>

Getting the output with **populations**
----

The final step in the stacks pipeline is to run the program [**populations**](http://catchenlab.life.illinois.edu/stacks/comp/populations.php), which is essentially just filtering, exporting, and summarizing data infor the formats that you specify (as in, once genotyping is already finished). However, another super nice thing about this program is that it runs populations stats for you and puts them in a nice excel-readable output!! :D yay easy pogen stats!!  

To run **populations**, we first need to develop a popmap file, which simply contains names of sequences (first column) and some population code (second column)that they belong to, tab delimited. Our sample/file names alrady contain the population information, so try to build it yourself.... how do you want to do it???



Now, let's run **populations** using the following command:

    populations -P ./denovo -M ./epi_popmap.txt -p 1 --vcf  
   

You can export in may other formats, such as STRUCTURE and GENEPOP, along with specific phylip files (but be careful in how you create these!) and full loci fasta files. Thus, the above code is the bare minimum for run populations, you can do many other things, such as filter for minimum number of individuals per population or minor allele frequency, etc. However, it's better so use other more specialized filtering programs, such as `vcftools`, `plink`, and ``, that give you much more control and options over which filters you use! 

Post-filtering in **vcftools**
----
First, let's remember the nature of RADseq datasets: what do we expect if we prepared our libraries based on a non-targeted loci protocol? What should our original SNP matrix - before we filter any final genotyped loci - look like? Could it look different depending on the divergence within our datasets?  


The filters implemented in ***populations*** are not the best. One of the main filters, `-p`, essentially filters out loci that are not present in the number of populations you specify. Thus, depending on how you define your populations, and how many individuals are sampled within populations, some loci may be completely eliminated from your matrix, simply because a single individual, sole member of a population, was poorly genotyped and thus most good loci are being dropped because of this one bad individual! Similarly, the filter `-r` is filtering out according to a specified proportion of individuals within a population, so once again is very sensitive to how you define your populations in the first place! 


Thus, it is better to have more control over filters that are implemented in your SNP matrices, and that are the least biased possible. For that, we will filter using the program [vcftools](https://vcftools.github.io/man_latest.html) which uses the input file format `.vcf`, which we already obtained by exporting in `populations`. Now we run the three most important and commonly used filters: 

1. First, let's filter loci with less than 50% individuals sequenced

		./vcftools --vcf populations.snps.vcf --max-missing 0.5 --recode --out filtered.snps


2. Second, let's filter loci with Minor Allele Frequency < 0.02 in remaining individuals and loci

		./vcftools --vcf filtered.snps.recode.vcf --maf 0.02 --recode --out filtered.snps.b
		
hmmm... nothing was actually filtered, let's change so taht now it's not frequency but absolute count using `-mac` such that: 

	 ./vcftools --vcf filtered.snps.recode.vcf --mac 1  --recode --out filtered.snps.b

What happens if we continue to increase `mac`, do we lose any loci? 


3. Other filters we can also do:

- 
- Linkage Disequilibium: very important if running certain popgen stats
- FST outliers > putatively adaptive loci
- specific unwanted loci (using *whitelists* and *blacklists*)
- many others! 

Further, aside fro filtering in these programs you can also estimate lots of things, such as individual inbreeding coefficients. 


<br><br>



<br><br>

<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/05-stacks-epi.html"><button>Stacks lesson</button></a><a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/09-raxml-epi.html"><button>RAxML</button></a>


## Appendix

If you're unable to perform the populations step, you can download the complete denovo folder (with populations output) [here](https://drive.google.com/drive/folders/1RdCsMo6YpOppUigrDgdDv7ju3xaBFD2G?usp=sharing).<br>
A full run of stacks with these data (approx 1.5GB) can be downloaded [here](https://drive.google.com/drive/folders/172ZgAdYmVJhZ_ILaKgY5EHRqV-dWnf_y?usp=sharing).<br>

There are actually several ways to look at .gz files, such as:
```
zless epiddrad_t200_R1_.fastq.gz # press 'q' to exit
gzcat epiddrad_t200_R1_.fastq.gz | head # the "|" pipes stdout to the program "head"
gzcat epiddrad_t200_R1_.fastq.gz | head -100 # shows the first 100 lines
```




