setwd("~/Documents/desafio_neoprospecta/FrenteII")

#Install packages if they are not installed
if (!requireNamespace("dplyr", quietly = TRUE)){
  install.packages("dplyr")
}
library("dplyr")

if (!requireNamespace("ggplot2", quietly = TRUE)){
  install.packages("ggplot2")
}
library("ggplot2")

if (!requireNamespace("phylotools", quietly = TRUE)){
  install.packages("phylotools")
}
library("phylotools")

#Part I - Seq len distribution histo
#read fast
seq_bank<-read.fasta(file = "banco.fasta")
seq_bank$seq.length<-nchar(seq_bank$seq.text)

#write histogram
pdf("sequence_length_hist.pdf")
ggplot(seq_bank, aes(x=seq.length)) + 
  geom_histogram(fill="#69b3a2", color="#e9ecef")+
  theme_minimal()+
  labs(title = "Sequence length distribution", x = 'Sequence length', y ='Count')
dev.off()



#Part II - 1% most representative taxonomy chart
#Read table
banco_tax_counts <- read.csv("~/Documents/desafio_neoprospecta/FrenteII/banco_tax_counts.csv")
#Create freq table
frequency_table_taxa<-banco_tax_counts %>%
  group_by(X0) %>%          
  summarise(freq=n())

#Order by frequency and cut 1%
frequency_table_taxa<-frequency_table_taxa[order(frequency_table_taxa$freq, decreasing=TRUE),]
frequency_table_taxa<-frequency_table_taxa[1:(nrow(frequency_table_taxa)*0.01),]
#Calculate the cumulative frequency
frequency_table_taxa$cumulative <- cumsum(frequency_table_taxa$freq)

#Pareto chart for frequency
pdf(file="pareto_chart_1cent.pdf")
ggplot(frequency_table_taxa, aes(x=reorder(X0, -freq))) +
  geom_bar(aes(y=freq), fill='blue', stat="identity") +
  geom_point(aes(y=frequency_table_taxa$cumulative), color = rgb(0, 1, 0), pch=16, size=1) +
  geom_path(aes(y=frequency_table_taxa$cumulative, group=1), colour="slateblue1", lty=3, size=0.9) +
  theme(axis.text.x = element_text(angle=0, vjust=0.6)) +
  labs(title = "Frequency of the 1% most common bacterias on the bank", x = 'Species name', y ='Count')
dev.off()


