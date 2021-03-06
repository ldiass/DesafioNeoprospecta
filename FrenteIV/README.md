# Frente IV
## setup.sh
No arquivo setup.sh, é feita a conferências dos programas que serão chamados no terminal para avaliação das sequências. Esses programas e as respectivas versões usadas nos testes são:
- fastqc 0.11.9
- trimmomatic 0.39
- multiqc 1.10

## Raw FastQC
O primeiro passo, foi fazer uma sondagem inicial da qualidade das amostras. Para isso foi executado o programa fastQC em todos os arquivos .fastq do diretório. 

`$ fastqc *.fastqc`

Inspecionando alguns dos resultados, percebeu-se que o perfil das amostras era muito semelhante. Os arquivos .fastq continham leituras de 250bp, com a qualidade codificada no sistema phred+33.

|Measure |  Value |
| ------------ | ------------ |
|  Encoding | Sanger / Illumina 1.9  |
|  Sequence length | 248-251|

Logo abaixo, na seção *Per base sequence quality* estão gráficos semelhantes ao abaixo, e observa-se que a qualidade das reads está muito boa, com uma natural queda, nas bases mais próximas de 3'.

![Image](images/F3D5_S193_per_base_quality.png?raw=true)

Em seguida, o gráfico *Per base sequence content*  foi um dois mais importantes na análise. Nele observamos algumas regiões com alta porcentagem da mesma base. Em sequenciamentos genômicos é bem comum que o início das reads tenha essa característica, indicando a presença de primes ou adaptadores, mas ao longo das reads, é esperada um distribuição equilibrada entre as bases, sendo a frequência de G/C um pouco superior a de A/T.  Nessa biblioteca, os picos se distribuem por todo o comprimento das sequências, indicando que as reads podem pertencem a uma região conservada, como as regiões *barcode* 16S e ITS para metagenômica de procariotos e de fungos, respectivamente. 

![Image](images/fstQC_per_base_seq_content.png?raw=true)

No repositório [ edamame-course/FastQC](https://github.com/edamame-course/FastQC/blob/master/final/2016-06-22_FastQC_tutorial.md " edamame-course / FastQC"), o mesmo gráfico apresentou perfil semelhante para reads de sequenciamento 16S. Assim, sendo, podemos considerar que essa região tem algumas particularidades, em comparação com um sequenciamento genômico ou de RNA-Seq.

Confirmamos essas evidências analizando as sequências na tabela *Overrepresented sequences*. Nessa tabela aparece algumas sequências que chegam a estar presentes em 41% das reads, e o fastQC não relaciona elas com as sequências de adaptadores descritos. Fazendo o *BLAST microbial* da sequência "TACGGAGGATGCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGTGCGTA" os primeros alinhamentos apontam para genomas do gênero *Porphyromonas*, mas também há alinhamentos com outros gêneros com 100% de identidade, ou seja, o alinhamento perfeito.

![Image](images/blast_example.png?raw=true)

No primeiro resultado apontado, a sequência *query* alinhou com a região 324:373 de *Porphyromonas catoniae*, que é parte do gene que tem como produto o RNA ribossômico 16S.

O próximo passo foi executar o programa multiqc, para poder observar de forma fácil todos arquivos fastqc e ver ser algum deles difere dessas propriedades. O multiqc agrupa os resultados do fastQC com o seguinte comando:

`$ multiqc ./first_QC_assessement/`

No resultado do multiqc, observa-se que todas as bibliotecas seguem o mesmo padrão, apresentando uma alta qualidade em geral.

![Image](images/multiqc_per_base_sequence_quality_plot.png?raw=true)

Assim como o padrão de enriquecimento de bases é mantido como observado no gráfico abaixo *per Base Sequence Content*. Então podemos concluir que todas as bibliotecas tem uma alta qualidade e pertencem à região 16S.

![Image](images/multiqc_per_base_sequence_content_plot.png?raw=true)

A distribuição de frequência de conteúdo GC ao longo das reads, deve seguir uma distribuição similar à normal, com média em torno de 60%, em dados de sequênciamento genômico. Nesse caso, como temos regiões conservadas, acabam se formando 3 picos no gráfico. É provável que as bactérias que estejam no mesmo pico sejam agrupadas em uma análise filogenética, compartilhando essa "assinatura" de conteúdo GC no seu *barcode*.

![Image](images/multiqc_gc_content_plot.png?raw=true)

O nível de sequências duplicadas também está muito diferente, com um alto nível de duplicação em uma porcentagem significativa da biblioteca sequenciada, conforme mostra a imagem abaixo. Mas, novamente, isso não é preocupante, devido à origem da mesma.

![Image](images/multiQC_dup_levels.png?raw=true)

Outros indicadores de qualidade também tiveram resultando positivo, como a ausência de adaptadores e também um baixo valor de bases não identificadas (valor 'N'), também estão presentes. Como observado no gráfico abaixo.

![Image](images/multiQC_per_base_n_content_plot.png?raw=true)

Finalmente, no último gráfico há um heatmap, mostrando o desempenho das bibliotecas nas análises do fastQC. Todas as flags que aparecem vermelhas, já discutimos aqui que são um efeito do sequenciamento de *barcodes*. Algumas bibliotecas, no entanto, tem um 
aviso para a análise *Per tile sequence quality*.

![Image](images/multiqc-status-check-heatmap.png?raw=true)

Umas dessas bibliotecas é a F3D5_S193_L001_R1_001. No gráfico *Per tile sequence quality* dessa análise, podemos ver algumas linhas em amarelo. Isso não causa um grande impacto, uma vez que são só alguns pontos em amarelo, e não em vermelho, e também considerando que a queda de qualidade é para as posições mais próximas de 3', onde a qualidade é, intrinsicamente menor.

![Image](images/F3D5_S193_per_tile_plot.png?raw=true)

No gráfico que mostra a distruibuição do número de reads pelas bibliotecas, observa-se que as bibliotecas que aparecem em amarelo para a qualidade dos "tiles" de leitura, são as mesmas com menor número de *reads*. Isso indica que a peformance das etapas de preparação dessas bibliotecas pode não ter sido tão boa, ainda que todos os resultados sejam satisfatórios.

## Trimming
Feita essa análise da qualidade das bibliotecas, passa-se para a etapa de trimmagem das reads. Para isso, vai ser usado o trimmomatic, que foi instalado quando foi rodado o setup. Normalmente, as primeiras bases deveriam ser eliminadas das leituras com o parâmetro HEADCROP. Pois as mesmas podem pertencer a sequências conhecidas como adaptadores, ou então podem identificadores das amostras, também como conhecido como *barcode* das amostras. Esses identificadores devem ser removidos em uma etapa adicional, mas nos carece essa informação no momento.

No entanto, observamos que as bases que aparecem tão conservadas no início das leituras, são as mesmas que iniciam as sequências super-representadas, que por sua vez, alinharam com a região 16S. Portanto, essas bases iniciais são componentes do DNA das amostras e não artefatos experimentais. Por isso, não faremos nenhuma trimmagem dessas primeiras bases.

Ainda assim, podemos avaliar regiões que tenham uma qualidade média muito baixa e removê-las, mantendo só a parte de melhor qualidade no sentido 5'. Como consequência, aquelas reads que tem uma qualidade muito baixa, próxima a extremidade 3' serão eliminadas. Para essa análise, vamos considerar janelas de 5bp que devem ter uma qualidade média mínima de 30. O comprimento das reads remanescentes deve ser de pelo menos 180bp.
Para executar essa filtragem, executamos um pequeno script .sh com o seguinte código:

```shell
mkdir trimmed_SW530_ML180
for i in genomes/*.fastq; do
	filename=$(basename $i)
	trimmomatic SE -phred33 "$i" ./trimmed_SW530_ML180/$filename SLIDINGWINDOW:5:30 MINLEN:180
	fastqc ./trimmed_SW530_ML180/$filename
done

multiqc trimmed_SW530_ML180/*
```
Como resultado, observamos que a qualidade das sequências sobre em geral e principalmente próximo a extremidade 3' como o esperado. Assim como, todos os warnings na seção *Per tile sequence quality*.

![Image](images/multiqc_1trimm_per_base_sequence_quality.png?raw=true)

![Image](images/multiqc_1trimm-status-check-heatmap.png?raw=true)

Em contrapartida, temos a redução do número e do tamannho de reads. Em relação ao tamanho, eu considero que a trimmagem foi satisfatória, pois a imensa maioria das leituras teve tamanho >230 bp. No entanto é importante considerar como será feito o processamento nas próximas etapas para a identificação das taxonomias, pois como a região *barcode* é muito conservada e o sequenciamento abrange sempre a mesma região, não poderá ser compensada essas bases perdidas com o "empilhamento" como ocorre com as leituras genômicas. A diferença entre o número de reads antes e depois da trimmagem.

|Medida do número de reads|  Antes trimmagem | Pós trimmagem|
| ------------ | ------------ | ------------ |
|Média|7767|5147|
|Máxima|19620|13421|
|Q3|7891|5206.5|
|Q1|5075|3329|
|Mediana|5958|3913|
|Mínimo|3178|2098|

![Image](images/n_read_trimming.png?raw=true)

Foi observado uma redução em torno de 1/3 das reads. Esse corte parece ser proporcional ao longo de todas as sequências, independentemente do número de reads original. Eu considero que o número de reads remanescentes é satisfatório.

Esse processo de trimmagem, pode ser feito novamente com parâmetros mais ou menos restritivos. Isso depende de vários fatores, como o objetivo entre fazer análise metagenômica quantitativa ou qualitativa, a diversidade da biblioteca e também a facilidade de alinhamento das reads com o banco de genomas.
