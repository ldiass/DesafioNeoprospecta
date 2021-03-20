setwd("~/Documents/desafio_neoprospecta/FrenteIII")

tax_table_amostras <- read.delim("~/Documents/desafio_neoprospecta/FrenteIII/tax_table_amostras.tsv")

otu_table_tax_amostras <- read.delim("~/Documents/desafio_neoprospecta/FrenteIII/otu_table_tax_amostras.tsv")
row.names(otu_table_tax_amostras)<-otu_table_tax_amostras$OTU
otu_table_tax_amostras$OTU<-NULL

metadata <- read.delim("~/Documents/desafio_neoprospecta/FrenteIII/metadata.csv")
row.names(metadata)<-metadata$X.group

otu_table_tax_amostras$absolute<-rowSums(otu_table_tax_amostras)
otu_table_tax_amostras<-otu_table_tax_amostras[order(otu_table_tax_amostras$absolute, decreasing=TRUE),]
otu_table_tax_amostras<-otu_table_tax_amostras[1:50,]
otu_table_tax_amostras$absolute<-NULL
otu_table_tax_amostras$Species<-tax_table_amostras$Species[match(row.names(otu_table_tax_amostras), tax_table_amostras$X)]


otu_colNames<-colnames(otu_table_tax_amostras)
late_samples<-metadata$X.group[metadata$time=="Late"]
late_indexs<-sapply(late_samples,function(x)grep(x,otu_colNames))

latedata<-otu_table_tax_amostras[,late_indexs]
latedata$total<-rowSums(latedata)
latedata$time<-"late"
latedata$Species<-otu_table_tax_amostras$Species
latedata<-latedata[,c(11:13)]

early_indexs<-c(1:(ncol(otu_table_tax_amostras)-1))
early_indexs<-setdiff(early_indexs,late_indexs)

earlydata<-otu_table_tax_amostras[,early_indexs]
earlydata$total<-rowSums(earlydata)
earlydata$time<-"early"
earlydata$Species<-otu_table_tax_amostras$Species
earlydata<-earlydata[,c(10:12)]

group_time<-rbind(latedata,earlydata)
head(group_time)


pdf(file = "freq_per_time_bar.pdf")
ggplot(group_time, aes(fill=time, y=total, x=reorder(Species, total))) + 
  geom_bar(position="dodge", stat="identity")+
  coord_flip()+
  theme_minimal()+
  labs(title = "Most abundant species per time", y = 'Species name', x ='Count')
dev.off()
