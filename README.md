
# MATERIAIS DE APOIO

O diretório `arquivos-de-apoio` contém três sub-diretórios contendo os arquivos em formato fastq (`fqs`), fasta (`fas`) e as tabelas (`tables`) que você necessitará para executar esse desafio.


# DESCRIÇÃO DO DESAFIO

A avaliação possui o objetivo de avaliar quatro frentes de conhecimento: 1) a curadoria de bancos de dados de sequencias biológicas; 2) análise de bancos de dados de sequencias de DNA; 3) análise de dados de comunidades microbianas; e 4) questões de conhecimentos em bioinformática.

1. Curadoria de banco de dados de sequencias biológicas:
	1. Você recebeu um banco de dados para realizar a curadoria. Até o momento esse banco ainda não é totalmente confiável, pois muito provavelmente ele possui sequências de outros organismos que não são **procariotos**. Visto que esse banco deve ser utilizado para fazer a predição de resultados de sequenciamento do gene 16S (somente presente em **procariotos**), todas as sequencias que NÃO pertencem a esse gene deverão ser eliminadas. Considerando que provavelmente você terá que repetir esse trabalho para outros bancos de dados, o processo deve ser automatizado utilizando uma linguagem de programação de sua preferência. Sugerimos a utilização de **Python** ou **R**.

2. Análise de bancos de dados de sequências de DNA:
	1. Você conseguiu fazer a limpeza do banco de dados e agora o banco possui somente sequências de **procariotos**. A próxima etapa é descrever qual o conteúdo desse banco de dados. Para isso a equipe da Neoprospecta precisa visualizar duas informações:
		1. A distribuição do comprimento das sequẽncias ao longo do banco de dados (pode ser um histograma, um gráfico de densidades ou o gráfico de sua preferência);
		2. A segunda é produzir um gráfico descritivo que informe a distribuição das taxonomias mais frequentes presentes no banco de dados. Dentre essas taxonomias devem ser incluídas somente as 1% mais frequentes no gráfico, as demais devem ser descartadas.

3. Análise de dados de comunidades microbianas:
	A partir dos dados disponibilizados na tabela em anexo, você deve plotar um gráfico de barras que mostre a contagem absoluta das 50 bactérias mais abundantes agrupando-as por tempo. Para mais detalhes sobre os dados em anexo, veja o arquivo de texto Description.md disponibilizado junto com os dados.

4. Questões de conhecimentos em bioinformática:
	1. Você recebeu um resultado de sequenciamento contido em um arquivo FASTq. Desse resultado precisam ser eliminadas sequencias de baixa qualidade para que o mesmo possa ser utilizado em análises posteriores. Com esses resultados em mãos, você terá duas missões:
		1. Fazer a limpeza desses dados e gerar relatórios que descrevam a qualidade desses dados antes e após a limpeza, utilizando o(s) software(s) de sua preferência;
		2. Descrever as etapas realizadas para gerar o relatório e quais as informações contidas no mesmo.


# INFORMAÇÕES IMPORTANTES

1. Para melhor podermos avaliar seus conhecimento na resolução de problemas relacionados aos desafios impostos nesse documento, solicitamos que todos os códigos utilizados para resolver esse desafio, incluindo os resultados de questões dissertativas de bioinformática, deverão ser disponibilizados no Github e o link de acesso ao repositório enviado para os avaliadores até as 23:59 do seu último dia de desafio.
2. Caso não seja possível realizar algum dos sub-itens, não há problema em resolver uma frente parcialmente. Como já mencionado, esse desafio tem o intúito de avaliar sua capacidade de resolver problemas.
3. Durante o período de realização do desafio, dúvidas não serão respondidas por parte dos avaliadores, com exceção somente para esclarecimento pontuais ou problema com o acesso aos arquivos disponibilizados para a realização do desafio.
