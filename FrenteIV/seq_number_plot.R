#Install packages if they are not installed
if (!requireNamespace("ggplot2", quietly = TRUE)){
  install.packages("ggplot2")
}
library("ggplot2")

if (!requireNamespace("tidyr", quietly = TRUE)){
  install.packages("tidyr")
}
library("tidyr")

setwd("~/Documents/git_repository/DesafioNeoprospecta/FrenteIV")
seq_number_comparison <- read.csv("seq_number_comparison.csv")
colnames(seq_number_comparison)<-c("Before","After")
seq_number_comparison$seq<-c(1:nrow(seq_number_comparison))

png(filename = "n_read_trimming.png")
ggplot(data = seq_number_comparison %>% gather(Trimming, Length, -seq), 
       aes(x = seq, y = Length, fill = Trimming),show.legend = TRUE) + 
  geom_bar(stat = 'identity', position = 'dodge')+
  theme_minimal()+
  geom_hline(mapping=aes(yintercept = 5958, linetype="Before"), color = "gray")+
  geom_hline(mapping=aes(yintercept = 3913, linetype="After"),  color = "gray")+
  labs(y = 'Read counts', fill ='', x='Library', linetype="Median")
dev.off()

