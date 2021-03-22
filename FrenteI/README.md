# Frente I

## Visão geral

Para a solução do desafio, foram implementados dois códigos em python, assim como um programa em bash que faz a automatização do processo. Para a sua execução, é necessária conexão com a internet.


## speciesFinder.py
O programa speciesFinder.py tem um propósito mais genérico e tem como objetivo buscar os identificadores na base de dados do NCBI, identificando quais organismos estão relacionados com cada uma das sequências. Muitas das funções presentes, foram basedas no repositório [taoliu/taolib](https://github.com/taoliu/taolib/blob/master/Scripts/convert_gene_ids.py). No entanto, nenhuma das funções pode ser reusada, pois haviam parâmetros incompatíveis com os necessários para a resolução do desafio.
O programa quando rodado como main recebe o nome de um arquivo .fasta, faz a identificação do identificadores da sequências, que precisam ser do tipo RefSeq, faz a busca dos organismos dessas sequências e retorna uma tabela contendo o o identificador da sequência, o nome científico da espécie a qual pertence e seus respectivos táxons.

## bacteria_filter.py
Esse programa, mais específico para esse desafio faz a identificação dos organismos aos quais pertencem as sequências usando as funções do módulo speciesFinder. Em seguida faz a filtragem dessas espécies,  retendo só as pertecentes às bactérias. A partir desses identificadores é escrita uma tabela com a OTUs e o arquivo .fasta é reescrito com apenas essas sequências. O programa recebe o nome de um arquivo na sua execução tem apenas uma função, que é de escrita do arquivo .fasta.

## run_bacteria_filter.sh
O arquivo run_bacteria_filter.sh é responsável pela automatização da análise, executando o script correto para cada arquivo fasta no diretório. Além disso, ele também garante a instalação das bibliotecas biopython e pandas.


