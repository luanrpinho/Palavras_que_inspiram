# Instalando os pacotes necessários
install.packages(c("tm", "wordcloud", "RColorBrewer", "ggplot2"))

# Carregar os pacotes necessários
library(tm)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)

# Definir o caminho do arquivo
discurso <- "C:/caminhoDoArquivo/discurso.txt"   # Substitua pelo caminho real

# Ler o conteúdo do arquivo
texto <- readLines(discurso, encoding = "UTF-8")


#Criar um Corpus
corpus <- Corpus(VectorSource(texto))

# Pré-processamento do texto
corpus <- tm_map(corpus, content_transformer(tolower))  # Converter para minúsculas
corpus <- tm_map(corpus, removePunctuation)             # Remover pontuação
corpus <- tm_map(corpus, removeNumbers)                 # Remover números
corpus <- tm_map(corpus, removeWords, stopwords("pt"))  # Remover palavras comuns em português
corpus <- tm_map(corpus, stripWhitespace)               # Remover espaços em branco extras


# Criar uma matriz de termos
dtm <- TermDocumentMatrix(corpus)
m <- as.matrix(dtm)
freq <- sort(rowSums(m), decreasing = TRUE)

# Converter para um data frame
df_freq <- data.frame(word = names(freq), freq = freq)

# Verificar as palavras mais frequentes
head(df_freq, 10)

# Filtrar as 10 palavras mais frequentes
df_freq_top10 <- head(df_freq, 10)


# Criar a nuvem de palavras
wordcloud(names(freq), 
          freq, min.freq = 2, 
          scale = c(3, 0.5),
          colors = brewer.pal(8, "PuBu"), random.order = FALSE)


# Criar o gráfico de barras para as 10 palavras mais frequentes
ggplot(df_freq_top10, aes(x = reorder(word, freq), y = freq)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() + 
  labs(title = "Top 10 Palavras Mais Frequentes", x = "Palavras", y = "Frequência") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))












