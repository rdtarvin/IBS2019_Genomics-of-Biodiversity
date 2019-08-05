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

<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/05-stacks-epi.html"><button>Stacks lesson</button></a>		<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/09-raxml-epi.html"><button>RAxML</button></a>

Getting the output with **populations**
----

The final step in the stacks pipeline is to run the program [**populations**](http://catchenlab.life.illinois.edu/stacks/comp/populations.php), which is essentially just filtering, exporting, and summarizing data infor the formats that you specify (as in, once genotyping is already finished). However, another super nice thing about this program is that it runs populations stats for you and puts them in a nice excel-readable output!! :D yay easy pogen stats!!  

To run **populations**, we first need to develop a popmap file, which simply contains names of sequences (first column) and some population code (second column) that they belong to, tab delimited. Our sample file already contains the population information, so try to build it yourself.... how do you want to do it???

Now, let's run **populations** using the following command:

    populations -P ./denovo -M ./epi_popmap.txt -p 1 --vcf  --structure --genepop
    # -P is the path to the directory containing the Stacks files
    # -p indicates minimum number of populations a locus must be present in to process a locus
    # -M is the path to a population map
    
Here's a snippet of the .stru format

	# Stacks v2.41;  Structure v2.3; August 05, 2019
			2_32	2_70	4_23	4_68	6_176	6_223	6_248	7_85	7_124	11_204
	Etri_T6836	Etri_T6836	0	0	1	1	1	1	1	3	2	2		
	Etri_T6836	Etri_T6836	0	0	3	4	3	4	2	3	2	2		
	Etri_T6842	Etri_T6842	2	3	0	0	3	4	2	1	2	2		
	Etri_T6842	Etri_T6842	4	4	0	0	3	4	2	3	4	4		
	Eant_T6857	Eant_T6857	0	0	0	0	0	0	0	0	0	0		
	Eant_T6857	Eant_T6857	0	0	0	0	0	0	0	0	0	0		
	Eant_T6859a	Eant_T6859a	0	0	1	4	0	0	0	3	2	0		
	Eant_T6859a	Eant_T6859a	0	0	3	4	0	0	0	3	2	0		

Here's a snippet of the [.vcf format](https://samtools.github.io/hts-specs/VCFv4.2.pdf)

	##fileformat=VCFv4.2
	##fileDate=20190805
	##source="Stacks v2.41"
	##INFO=<ID=AD,Number=R,Type=Integer,Description="Total Depth for Each Allele">
	##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
	##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
	##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of Samples With Data">
	##FORMAT=<ID=AD,Number=R,Type=Integer,Description="Allele Depth">
	##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
	##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">
	##FORMAT=<ID=GL,Number=G,Type=Float,Description="Genotype Likelihood">
	##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
	##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
	##INFO=<ID=loc_strand,Number=1,Type=Character,Description="Genomic strand the corresponding Stacks locus aligns on">
	#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	Etri_T6836	Etri_T6842	Eant_T6857	Eant_T6859a	Eant_T6859b	Ahah_R0089a	Ahah_R0089b	Ahah_R0090	Ebou_R0153	Ebou_R0156	Snub_R0158	Snub_R0159
	2	33	.	C	T	.	PASS	NS=1;AF=0.500	GT:DP:AD:GQ:GL	./.	0/1:6:1,5:14:-7.26,-0.05,-1.00	./.	./.	./.	./.	./.	./.	./.	./.	./.	./.
	2	71	.	G	T	.	PASS	NS=1;AF=0.500	GT:DP:AD:GQ:GL	./.	0/1:6:1,5:25:-12.43,-0.00,-1.96	./.	./.	./.	./.	./.	./.	./.	./.	./.	./.
	4	24	.	A	G	.	PASS	NS=3;AF=0.500	GT:DP:AD:GQ:GL	0/1:12:3,9:40:-24.47,-0.00,-6.20	./.	./.	0/1:10:2,8:40:-22.07,-0.00,-3.80	0/1:13:6,7:40:-18.17,-0.00,-14.90	./.	./.	./.	./.	./.	./.	./.
	4	69	.	T	A	.	PASS	NS=3;AF=0.333	GT:DP:AD:GQ:GL	0/1:12:9,3:40:-5.82,-0.00,-24.40	./.	./.	0/0:10:10,0:32:-0.00,-2.58,-30.58	0/1:13:7,6:40:-14.52,-0.00,-18.10	./.	./.	./.	./.	./.	./.	./.
	6	177	.	G	A	.	PASS	NS=2;AF=0.250	GT:DP:AD:GQ:GL	0/1:6:3,3:40:-5.51,-0.00,-6.32	0/0:7:7,0:26:-0.00,-2.03,-17.71	./.	./.	./.	./.	./.	./.	./.	./.	./.	./.
	6	224	.	T	A	.	PASS	NS=2;AF=0.250	GT:DP:AD:GQ:GL	0/1:6:3,3:40:-5.51,-0.00,-6.32	0/0:7:7,0:26:-0.00,-2.03,-17.71	./.	./.	./.	./.	./.	./.	./.	./.	./.	./.
	6	249	.	C	A	.	PASS	NS=2;AF=0.250	GT:DP:AD:GQ:GL	0/1:6:3,3:40:-5.51,-0.00,-6.32	0/0:7:7,0:26:-0.00,-2.03,-17.71	./.	./.	./.	./.	./.	./.	./.	./.	./.	./.
	7	86	.	G	A	.	PASS	NS=3;AF=0.167	GT:DP:AD:GQ:GL	0/0:27:23,3:22:-0.01,-1.68,-42.85	0/1:7:3,4:40:-6.08,-0.00,-4.93	./.	0/0:36:36,0:40:-0.00,-10.93,-76.36	./.	./.	./.	./.	./.	./.	./.	./.


You can export in may other formats such as specific phylip files (but be careful in how you create these!) and full loci fasta files. Thus, the above code is the bare minimum for run populations, you can do many other things, such as filter for minimum number of individuals per population or minor allele frequency, etc. However, it's better so use other more specialized filtering programs, such as `vcftools`, `plink`, and ``, that give you much more control and options over which filters you use! 

Post-filtering in **vcftools**
----
First, let's remember the nature of RADseq datasets: what do we expect if we prepared our libraries based on a non-targeted loci protocol? What should our original SNP matrix - before we filter any final genotyped loci - look like? Could it look different depending on the divergence within our datasets? 

Let's go to this [mini lecture](https://docs.google.com/presentation/d/e/2PACX-1vS7BfHaXcT1ZMqvG-rrN_3Fg3n2ip66dONN6ocaJcP4Hi_dmpspbhaydAENEdEe5A/pub?start=false&loop=false&delayms=60000) to see more about patterns of missing data in GBS protocols and why filtering well is so crucial. 


The filters implemented in ***populations*** are not the best. One of the main filters, `-p`, essentially filters out loci that are not present in the number of populations you specify. Thus, depending on how you define your populations, and how many individuals are sampled within populations, some loci may be completely eliminated from your matrix, simply because a single individual, sole member of a population, was poorly genotyped and thus most good loci are being dropped because of this one bad individual! Similarly, the filter `-r` is filtering out according to a specified proportion of individuals within a population, so once again is very sensitive to how you define your populations in the first place! 


Thus, it is better to have more control over filters that are implemented in your SNP matrices, and that are the least biased possible. For that, we will filter using the program [vcftools](https://vcftools.github.io/man_latest.html) which uses the input file format `.vcf`, which we already obtained by exporting in `populations`. Now we run the three most important and commonly used filters: 

1. First, let's filter loci with less than 50% individuals sequenced

		./vcftools --vcf populations.snps.vcf --max-missing 0.5 --recode --out filtered.snps


2. Second, let's filter loci with Minor Allele Frequency < 0.02 in remaining individuals and loci

		./vcftools --vcf filtered.snps.recode.vcf --maf 0.02 --recode --out filtered.snps.b
		
	hmmm... nothing was actually filtered, let's change so that now it's not frequency but absolute count using `-mac` such that: 

		 ./vcftools --vcf filtered.snps.recode.vcf --mac 1  --recode --out filtered.snps.b

	What happens if we continue to increase `mac`, do we lose any loci? 


3. Other filters we can also do:

- missing data by individual
- Linkage Disequilibium: very important if running certain popgen stats
- FST outliers > putatively adaptive loci
- specific unwanted loci (using *whitelists* and *blacklists*)
- many others! 

Further, aside fro filtering in these programs you can also estimate lots of things, such as individual inbreeding coefficients. 


<br><br>

<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/05-stacks-epi.html"><button>Stacks lesson</button></a>		<a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/IBS2019_Genomics-of-Biodiversity/main/2019/08/05/09-raxml-epi.html"><button>RAxML</button></a>


## Appendix

If you're unable to perform the populations step, you can download the complete denovo folder (with populations output) [here](https://drive.google.com/drive/folders/1RdCsMo6YpOppUigrDgdDv7ju3xaBFD2G?usp=sharing).<br>
A full run of stacks with these data (approx 1.5GB) can be downloaded [here](https://drive.google.com/drive/folders/172ZgAdYmVJhZ_ILaKgY5EHRqV-dWnf_y?usp=sharing).<br>





