#Relatório
###setup.sh
No arquivo setup.sh, é feita a conferências dos programas que serão chamados no terminal para avaliação das sequências. Esses programas são:
- fastqc
- trimmomatic
- multiqc

## Procedimentos
O primeiro passo, foi fazer uma sondagem inicial da qualidade das amostras. Para isso foi executado o programa fastQC em todos os arquivos .fastq do diretório. 

`$ fastqc *.fastqc`

Inspecionando alguns dos resultados, percebeu-se que o perfil das amostras era muito semelhante. Os arquivos .fastq continham leituras de 250bp, com a qualidade codificada no sistema phred+33.

|Measure |  Value |
| ------------ | ------------ |
|  Encoding | Sanger / Illumina 1.9  |
|  Sequence length | 248-251|

Logo abaixo, na seção *Per base sequence quality* estão gráficos semelhantes ao abaixo, e observa-se que a qualidade das reads está muito boa, com uma natural queda, nas bases mais próximas de 3'.

![](https://pandao.github.io/editor.md/examples/images/4.jpg)

Em seguida, o gráfico *Per base sequence content*  foi um dois mais importantes na análise. Nele observamos algumas regiões com alta porcentagem da mesma base. Em sequenciamentos genômicos é bem comum que o início das reads tenha essa característica, indicando a presença de primes ou adaptadores.  Nesse caso, os picos se distribuem por todo o comprimento das sequências, indicando que as reads pertencem a uma região conservada, como a região *barcode* 16S. No repositório [ edamame-course/FastQC](https://github.com/edamame-course/FastQC/blob/master/final/2016-06-22_FastQC_tutorial.md " edamame-course / FastQC"), o mesmo gráfico apresentou perfil semelhante para reads de sequenciamento 16S. Assim, sendo, podemos considerar que essa região tem algumas particularidades, em comparação com um sequenciamento genômico ou de RNA-Seq.
O próximo passo foi executar o programa multiqc, para poder observar de forma fácil todos arquivos fastq.

`$ multiqc .`

No resultado do multiqc, observa-se que todas as amostras seguem o mesmo padrão,  tem uma alta qualidade em geral, e algumas regiões bem conservados no gráfico *per Base Sequence Content*, correspondendo ao padrão observado anteriormente. 
![](https://pandao.github.io/editor.md/examples/images/4.jpg)
Outros indicadores de qualiade, como um baixo valor de bases não identificadas (valor 'N'), também estão presentes. Como observado no gráfico abaixo.
![](https://pandao.github.io/editor.md/examples/images/4.jpg)
