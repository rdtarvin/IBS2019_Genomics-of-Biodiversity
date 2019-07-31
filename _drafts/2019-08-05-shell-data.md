---
layout: default
order: 8
title:  "Getting Started in Shell"
date:   2019-08-05
time:   "08:00-09:00"
categories: main
instructor: "Becca"
materials: files/fakefile.txt
material-type: ""
lesson-type: Interactive
---


### Getting started in shell  
<br>

## The linux environment

### File systems
- your computer contains a nested hierarchy of directories
- **directory** is a *folder* on your computer which contains files
- keeping track of where you are in the file structure of your computer is an important component of computing
- highest level is the **root** (denoted: `/`)
- forward slashes divide levels in the nested hierarchy of directories, e.g. `/top_level_directory/second_level_directory`
- there are several high-level directories that users don't usually go into where program files are stored
	- /usr/bin
	- /usr/lib
- every file on your computer has an address; if you are going to do an operation on a file, you need its address
- **path**: the *address* to a directory or file on your computer. There are, generally, two types of paths:
	- **absolute/full path** represents the path of a given directory or file beginning at the root directory
    - **relative path** represents the path of a given directory/file relative to the working/current directory
- for example, say you have a file "my_favorite_file.txt" located in the directory `/Users/myname/Desktop/my_directory`.
	- the **full path** to this file  is `/Users/myname/Desktop/my_directory/my_favorite_file.txt`
    - the **relative path** to this file depends on where you are on the computer
	- if you are calling this file from Desktop, the relative path would be `my_directory/my_favorite_file.txt`
	- if you are in `/Users/myname/`, the relative path becomes `Desktop/my_directory/my_favorite_file.txt`
    
Remember - *Whenever you call the full path, you can reach the file from anywhere on your computer. Relative paths will change based on your current location.*

### Unix
- commands are small programs
	- type the name of a command and hit enter
	- Unix searches for the program's text file and executes it
- programs have preset arguments which change their behavior
	- these can be found in the program's manual
- programs interact with files that are in the directory that you are in
- we use a "shell" to interact with Unix: it exchanges information between user and program through *standard streams*
- **standard input**: input to programs
- **standard output**: information on screen, i.e. what the program outputs
- standard text editor for Unix is nano
	- type `nano` to access it
	- opens a text editor within the shell
	- saving, exiting, and other functions are controlled with ctrl + letter keys
	- we will be using primarily the Atom text editor instead of nano


### Here are some commands you will use all the time, we will review them as we proceed with the lesson

Command | Translation | Examples
--------|-------------|---------
`cd` | **c**hange **d**irectory | `cd /absolute/path/of/the/directory/` <br> Go to the home directory by typing simply  `cd` or `cd ~` <br> Go up (back) a directory by typing `cd ..`
`pwd` | **p**rint **w**orking **d**irectory | `pwd`
`mkdir` | **m**ake **dir**ectory | `mkdir newDirectory` creates newDirectory in your current directory <br> Make a directory one level up with `mkdir ../newDirectory`
`cp` | **c**o<b>p</b>y | `cp file.txt newfile.txt` (and file.txt will still exist!)
`mv` | **m**o<b>v</b>e | `mv file.txt newfile.txt` (but file.txt will *no longer* exist!)
`rm` | **r**e<b>m</b>ove | `rm file.txt` removes file.txt <br> `rm -r directoryname/` removes the directory and all files within
`ls` | **l**i<b>s</b>t | `ls *.txt` lists all .txt files in current directory <br> `ls -a` lists all files including hidden ones in the current directory <br> `ls -l` lists all files in current directory including file sizes and timestamps <br> `ls -lh` does the same but changes file size format to be **h**uman-readable <br> `ls ../` lists files in the directory above the current one
`man` | **man**ual | `man ls` opens the manual for command `ls` (use `q` to escape page)
`grep` | **g**lobal **r**egular <br> **e**xpression **p**arser |  `grep ">" seqs.fasta` pulls out all sequence names in a fasta file <br> `grep -c ">" seqs.fasta` counts the number of those sequences <br> 
`cat` | con<b>cat</b>enate | `cat seqs.fasta` prints the contents of seqs.fasta to the screen (ie stdout)
`head` | **head** | `head seqs.fasta` prints the first 10 lines of the file <br> `head -n 3 seqs.fasta` prints first 3 lines
`tail` | **tail** | `tail seqs.fasta` prints the last 10 lines of the file <br> `tail -n 3 seqs.fasta` prints last 3 lines
`wc` | **w**ord **c**ount | `wc filename.txt` shows the number of new lines, number of words, and number of characters <br> `wc -l filename.txt` shows only the number of new lines <br> `wc -c filename.txt` shows only the number of characters
`sort` | **sort** | `sort filename.txt` sorts file and prints output
`uniq` | **uniq**ue | `uniq -u filename.txt` shows only unique elements of a list <br> (must use sort command first to cluster repeats)

<br>
<br>

### Handy dandy shortcuts

Shortcut | Use|
----------|-----|
Ctrl + C | kills current process
Ctrl + L <br> (or `clear`) | clears screen
Ctrl + A | Go to the beginning of the line
Ctrl + E | Go to the end of the line
Ctrl + U | Clears the line before the cursor position
Ctrl + K | Clear the line after the cursor
`*` | wildcard character
tab | completes word
Up Arrow | call last command
`.` | current directory
`..` | one level up 
`~` | home
`>` | redirects stdout to a file, *overwriting* file if it already exists
`>>` | redirects stdout to a file, *appending* to the end of file if it already exists
pipe (<code>&#124;</code>) | redirects stdout to become stdin for next command


Keep in mind:
Good judgment comes from experience
experience comes from bad judgment
go make mistakes


### Download data for this lesson
```bash
cd # go to root of file system
mkdir workshop 
cd workshop
curl -L -O https://github.com/rdtarvin/IBS2019_Genomics-of-Biodiversity/blob/master/data/epiddrad_t200_R[1-2]_.fastq.gz?raw=true
# curl is a way to transfer files using a url from the command line
# -O option makes curl write to a file rather than stdout
# -L option forces curl to follow a redirect (determined by the web address)
# [1-2] downloads files that have a 1 or a 2 in that position
```

### Looking at your raw data in the linux environment

Your files will likely be gzipped and with the file extension **.fq.gz** or **fastq.gz**. The first thing you want to do is look at the beginning of your files while they are still gzipped.

```bash
ls # list all files in current directory
ls .. # list all files in one directory above
# rename files
mv epiddrad_t200_R1_.fastq.gz?raw=true epiddrad_t200_R1_.fastq.gz
mv epiddrad_t200_R2_.fastq.gz?raw=true epiddrad_t200_R2_.fastq.gz
```
Let's move these files into a new directory

```bash
mkdir epi
mv *.gz epi
ls
cd epi
ls -lht # -l = long format, -h = human readable, -t = order by time
```
Great! Now let's look at the files.

```bash
head epiddrad_t200_R1_.fastq.gz
```

Oops, what happened?! This gibberish is because of the format of the file, which is "gz" or "g-zipped". Let's unzip


```bash
gunzip *.gz
ls -lht
```
You can see that the size of the files expanded. Now try to peek:

```bash
head epiddrad_t200_R1_.fastq.gz
```
This is the fastq format, which has four lines. 

```bash
@K00179:78:HJ2KFBBXX:5:1121:25844:7099 1:N:0:TGACCA+AGATCT
GCATGCATGCAGCTTCTTCCTTCACATGATCTTCCACACGGTGCTTAGCTTTTTATAAAGGTGACTTCACGCACCGCGTTCATTGCAGTCAGAAGTGGCTTCAAAGGGAAATGGAAATGAATGACTTTTACTTCTCCTTTTCTCTGGATC
+
AAFFFF7FF7AAJFFJJJJJJJJJJJJJFJJFFJJJF<AFF-FFJJ<JJFJFF-F--7AJJ<J<JFJJ-FFFJF-AFJFJAFJJJJJJJJFA7AFFFFFJ7JAJAJJJ<J<7FF7A-AAJJJ<FJ-77A7FFAA-AAAAFF7FJJF<AFJ

# sequencer name:run ID:flowcell ID:flowcell lane:tile number in flow cell:x-coordinate of cluster :y-coordinate pair member:filtered?:control data:index sequence
# DNA sequence
# separator, can also sometimes (not often) hold extra information about the read
# quality score for each base
```

Ok this is great but there isn't much of a point to work with the files in their unzipped (large) format. So let's rezip them.
```bash
gzip *.fastq
```
There are actually several ways to look at .gz files, such as:
```
zless epiddrad_t200_R1_.fastq.gz # press 'q' to exit
zcat epiddrad_t200_R1_.fastq.gz | head
zcat epiddrad_t200_R1_.fastq.gz | head -100 # shows the first 100 lines
```


Ok, now lets look at the full file:

```bash
cat T36R59_I93_S27_L006_R1_sub12M.fastq
```

Uh oh... let's quit before the computer crashes... it's too much to look at! `Ctrl+C`<br><br>
This is the essential computational problem with NGS data that is so hard to get over. You can't
open a file in its entirety! Here are some alternative ways to view parts of a file at a time.

```bash
# print the first 10 lines of a file
head T36R59_I93_S27_L006_R1_sub12M.fastq 

# print the first 20 lines of a file
head -20 T36R59_I93_S27_L006_R1_sub12M.fastq # '-20' is an argument for the 'head' program

# print lines 190-200 of a file
head -200 T36R59_I93_S27_L006_R1_sub12M.fastq | tail # 'pipes' the first 200 lines to a program called tail, which prints the last 10 lines

# view the file interactively
less T36R59_I93_S27_L006_R1_sub12M.fastq # can scroll through file with cursor, page with spacebar; quit with 'q'
# NOTE: here we can use less because the file is not in gzipped (remember that required the 'zless' command)

# open up manual for less program
man less # press q to quit

# print only the first 10 lines and only the first 30 characters of each line
head -200 T36R59_I93_S27_L006_R1_sub12M.fastq | cut -c -30 

# count the number of lines in the file
wc -l T36R59_I93_S27_L006_R1_sub12M.fastq # (this takes a moment because the file is large)

# print lines with AAAAA in them
grep 'AAAAA' T36R59_I93_S27_L006_R1_sub12M.fastq # ctrl+c to exit

# count lines with AAAAA in them
grep -c 'AAAAA' T36R59_I93_S27_L006_R1_sub12M.fastq 

# save lines with AAAAA in them as a separate file
grep 'AAAAA' T36R59_I93_S27_L006_R1_sub12M.fastq > AAAAA # no file extensions necessary!!

# add lines with TTTTT to the AAAAA file: '>' writes or overwrites file; '>>' writes or appends to file
grep 'TTTTT' T36R59_I93_S27_L006_R1_sub12M.fastq >> AAAAA 

# print lines with aaaaa in them
grep 'aaaaa' T36R59_I93_S27_L006_R1_sub12M.fastq 
# why doesn't this produce any output?

# count number of uniq sequences in file with pattern 'AGAT'
grep 'AGAT' T36R59_I93_S27_L006_R1_sub12M.fastq | sort | uniq | wc -l

# print only the second field of the sequence information line
head T36R59_I93_S27_L006_R1_sub12M.fastq | grep '@' | awk -F':' '{ print $2 }' 
# awk is a very useful program for parsing files; here ':' is the delimiter, $2 is the column location
```


**Challenge**
<details> 
  <summary>How would you count the number of reads in your file? </summary>
   There are lots of answers for this one. One example: in the fastq format, the character '@' occurs once per sequence, so we can just count how many lines contain '@'.<br> 
   <code>grep -c '@' T36R59_I93_S27_L006_R1_sub12M.fastq</code>
</details> 



# Assembling 2bRAD data using iPyrad

![](https://github.com/rdtarvin/RADseq_Quito_2017/blob/master/images/basic-assembly-steps.png?raw=true)<br>

In this workflow, we will use the [2bRAD native pipeline](https://github.com/z0on/2bRAD_denovo) for filtering and trimming, 
[fastx-toolkit](http://hannonlab.cshl.edu/fastx_toolkit/) for quality control, 
and then [iPyrad](http://ipyrad.readthedocs.io/index.html) for the rest of the assembly.<br><br>

Step 0. Use fastqc to check read quality.
---

```bash
# fastqc is already installed, but if you wanted to download it, this is how: 
# wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
# unzip fastqc_v0.11.5.zip

# let's take a look at fastqc options
fastqc -h
fastqc *.fastq
```

When the program is finished, take a look at what files are in the directory using `ls`.
fastqc produces a nice .html file that can be viewed in any browser. 
Since we are trying to get comfortable with the command line, let's open the file directly.

```bash
sensible-browser T36R59_I93_S27_L006_R1_sub12M_fastqc.html
```

Sequencing quality scores, "Q", run from 20 to 40. In the fastq file, these are seen as ASCII characters. 
The values are log-scaled: 20 = 1/100 errors; 30 = 1/1000 errors. Anything below 20 is garbage and anything between 20 and 30 should be reviewed.
There appear to be errors in the kmer content, but really these are just showing where the barcodes and restriction enzyme sites are. 
Let's take a look at what 2bRAD reads look like:

![](https://github.com/rdtarvin/RADseq_Quito_2017/blob/master/images/2bRAD-read.png?raw=true)

Ok, we can see that overall our data are of high quality (high Q scores, no weird tile patterns, no adaptor contamination). Time to move on to the assembly!!

Step 1. Demultiplex by barcode in **2bRAD native pipeline**
---

Copy scripts to your virtual machine Applications folder via git
```bash
cd ~/Applications
git clone https://github.com/z0on/2bRAD_denovo.git
ls
cd ../workshop/2bRAD/
```
Git is an important programming tool that allows developers to trace changes made in code. Let's take a look online.
```bash
sensible-browser https://github.com/z0on/2bRAD_denovo
```

Okay, before we start the pipeine let's move our fastqc files to their own directory
```bash
mkdir 2bRAD_fastqc
mv *fastqc* 2bRAD_fastqc # shows error stating that the folder couldn't be moved into the folder
ls # check that everything was moved
```

First we need to concatenate data that were run on multiple lanes.
- T36R59_I93_S27_L00**6**_R1_001.fastq and T36R59_I93_S27_L00**7**_R1_001.fastq
- pattern "T36R59_I93_S27_L00" is common to both read files; program concatenates into one file with (.+) saved as file name

```bash
perl ~/Applications/2bRAD_denovo/ngs_concat.pl fastq "(.+)_S27_L00" # this takes a few minutes so let's take a quick break while it does its thing.
head T36R59_I93.fq

@K00179:73:HJCTJBBXX:7:1101:28006:1209 1:N:0:TGTTAG
TNGTCCACAAGAGTGTGTCGAGCGTTGTGCCCCCCCGCATCTCTACAGAT
+
A#AAFAFJJJJJJJJJJJJJFJJJJJJFJJJJJJJJJJJFJFJJJJJAJ<
@K00179:73:HJCTJBBXX:7:1101:28026:1209 1:N:0:TGTTAG
CNAACCCGTTGTCACGTCGCAAATAAGTCGGTGCGCTGGCAATCACAGAT
+
A#AFFJJJFJJFFJJJJJJJJFFJJJJJFJFJFJFJJJJJJJJJJJJJJF
@K00179:73:HJCTJBBXX:7:1101:28047:1209 1:N:0:TGTTAG
GNGTCCCAGTGATCCGGAGCAGCGACGTCGCTGCTATCCATAGTGAAGAT
```

Now that our read files are concatenated, we need to separate our reads by barcode. 
Let's take a look again at the structure of a 2bRAD read.<br>

![](https://github.com/rdtarvin/RADseq_Quito_2017/blob/master/images/2bRAD-read.png?raw=true)


From the 2bRAD native pipeline we will use ```trim2bRAD_2barcodes_dedup2.pl``` script to separate by barcode. 
If your data are not from HiSeq4000 you would use ```trim2bRAD_2barcodes_dedup.pl```. This takes <10 min
```bash
# adaptor is the last 4 characters of the reads, here 'AGAT'
perl ~/Applications/2bRAD_denovo/trim2bRAD_2barcodes_dedup2.pl input=T36R59_I93.fq adaptor=AGAT sampleID=1
.
.
.
T36R59_ACCA: goods: 295784 ; dups: 1178405
T36R59_AGAC: goods: 260575 ; dups: 987301
T36R59_AGTG: goods: 325595 ; dups: 956574
T36R59_CATC: goods: 432507 ; dups: 1732082
T36R59_CTAC: goods: 311897 ; dups: 1837423
T36R59_GACT: goods: 322958 ; dups: 1877945
T36R59_GCTT: goods: 266101 ; dups: 1040723
T36R59_GTGA: goods: 483664 ; dups: 1871167
T36R59_GTGT: goods: 328948 ; dups: 1298015
T36R59_TCAC: goods: 274208 ; dups: 1494727
T36R59_TCAG: goods: 309572 ; dups: 1109505
T36R59_TGTC: goods: 310155 ; dups: 1800440

T36R59: total goods : 3921964 ; total dups : 17184307

```

You can see that there are a ton of duplicate reads in these files. This is OK and means that you have high 
coverage across loci. Don't confuse these duplicates with PCR duplicates, which may be a source of error (more on this later).

```bash
ls
```

Now you can see that the demultiplexed and deduplicated files are listed by barcode and have the file extension **.tr0**.


Step 2. Filter reads by quality with a program from the **fastx_toolkit**
---

```bash
fastq_quality_filter -h

# Use typical filter values, i.e., 90% of bases in a read should have a q-value aboce 20
# This is a for loop, which allows you to execute the same command with arguments across multiple files
# The 'i' variable is a place holder 
for i in *.tr0; do fastq_quality_filter -i $i -q 20 -p 90 > ${i}.trim; done

# zip the files to save space
for i in *.trim; do gzip ${i}; done
```

Now we have our 2bRAD reads separated by barcode and trimmed (steps 1 & 2)!<br>


**TASK**: The files need to be renamed for each species. 
Using the barcode file [here](https://raw.githubusercontent.com/rdtarvin/RADseq_Quito_2017/master/files/2bRAD-ipyrad_barcodes.txt) and the command `mv`, 
rename all .gz files to have the format `genX_spX-X_R1_.fastq.gz`.<br>


<br><br>

<a href="https://rdtarvin.github.io/RADseq_Quito_2017/"><button>Home</button></a>    <a href="https://rdtarvin.github.io/RADseq_Quito_2017/main/2017/08/02/afternoon-2bRAD-pyrad.html"><button>Next Lesson</button></a>
