### Data Visualization - Parte 1 ###

# Pacotes Utilizados

library(ggplot2) # Pacote Gr�fico
library(nycflights13) # Dados Utilizados
library(dplyr) # Manipula??o dos Dados

# O que � a DataVis e por que ela � importante?

a<-flights

# Existem Multiplas formas de visualizar dados

a

a%>%glimpse()

View(a)

a$arr_time

a$arr_delay

table(a$arr_time)

table(a$arr_delay)

arr_time

arr_delay

# Apresentando a gr�matica dos gr�ficos
# grammar of graphs

#Um gr�fico estat�stico � um mapeamento de vari�veis de dados para atributos est�ticos de objetos geom�tricos.

ggplot(data = a, # dataset que contem as vari�veis de interesse
       mapping = aes(x = arr_time) # atributos est�ticos posi��o de X e Y, cor, forma e tamanho.
       )+ # operador que adiciona camadas aos gr�ficos
  geom_histogram() # geom_ o objeto geom�trico em quest�o


## The Big Five
# Os 5 tipos de gr�fico que todo analista deve conhecer
# Gr�ficos univariados
# histograms - histogramas;
# boxplots - gr�ficos de caixa;
# barplots - gr�ficos de barra;

#Gr�ficos Bivariados
# scatterplots - gr�ficos de dispers�o;
# linegraphs - gr�ficos de linha;

## Histogramas

# Fazendo um Histograma
ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram()

# Alterando a cor de um geom
ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram(color = "white")

# O que alterou desse histograma para o primeiro?

# Para alterar a parte interna de um geom utilizamos o argumento fill
ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram(color = "white", fill = "steelblue")

# Utilizamos o argumento bins para alterar o n�mero de colunas do histograma
ggplot(data = weather,aes(x = temp)) +
  geom_histogram(bins = 40, color = "white", fill = "steelblue")

# Utilizamos a fun��o binwidth para alterar o tamanho da coluna
ggplot(data = weather,aes(x = temp)) +
  geom_histogram(binwidth = 10, color = "white", fill = "steelblue")


# Utilizamos o layer facets para criar paineis
ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white", fill = "red") +
  facet_wrap(~ month)
  
# Podemos alterar o tamanho do painel a ser plotado
ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white", fill = "red") +
  facet_wrap(~ month, nrow = 4)

ggplot(data = weather,
       aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white", fill = "red") +
  facet_wrap(~ month, nrow = 2, ncol = 6 )

## Boxplots

# Vendo a distribui��o de uma vari�vel
ggplot(data = weather, 
       aes(y = temp)) +
  geom_boxplot()

# Vendo a distribui��o de multiplas vari�veis
ggplot(data = weather, 
       aes(x = month, y = temp)) +
  geom_boxplot()

# Qual o erro?

ggplot(data = weather,
       aes(x = factor(month), y = temp)) +
  geom_boxplot()

## Barplots

# Simulando alguns dados
frutas <- tibble(
  fruta = c("ma��", "ma��", "laranja", "ma��", "laranja"))

frutas_contadas <- tibble(
  frutas = c("ma��", "laranja"),
  numero = c(3, 2))

# Podemos Usar o geom_bar
ggplot(data = frutas,
       aes(x = fruta)) +
  geom_bar()

# Como tamb�m o geom_col
ggplot(data = frutas_contadas,
       aes(x = frutas, y = numero)) +
  geom_col()

# Qual a diferen�a entre os 2?

# geom_bar � �timo para dados n�o contados no dataframe
# geom_col � �timo para valores contados no dataframe

# Fazendo gr�ficos de propor��es

# Usando o argumento fill
ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar()

# Usando o argumento color
ggplot(data = a,
       aes(x = carrier, color = origin)) +
  geom_bar()

# Fazendo gr�ficos de barras agrupados fazendo uso do argumento position

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")

# Mantendo a propor��o nas barras

ggplot(data = flights,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = position_dodge(preserve = "single"))

## Scatterplot

#filtrando os dados do alaska 
alaska <- flights %>% 
  filter(carrier == "AS")

# executando o gr�fico
ggplot(data = alaska,
       aes(x = dep_delay, y = arr_delay)) + 
  geom_point()  

## O que fazer se os pontos se sobescreverem?

# Op��o 1 alterando a transpar�ncia com a fun��o alpha(), dentro do geom.

ggplot(data = alaska,
       aes(x = dep_delay, y = arr_delay)) + 
  geom_point(alpha = .2)

# Op��o 2 usando um geom que cause um "tremor"
ggplot(data = alaska,
       aes(x = dep_delay, y = arr_delay)) + 
  geom_jitter()  


# Op��o 3 juntando tudo
ggplot(data = alaska,
       aes(x = dep_delay, y = arr_delay)) + 
  geom_jitter(alpha = .2)


## Lineplot

#  Pegando uma s�rie temporal
clima_jan<- weather %>% 
  filter(origin == "EWR" & month == 1 & day <= 31)

ggplot(data = clima_jan,
       aes(x = time_hour, y = temp)) +
  geom_line()


## Alterando a Estrutura do Gr�fico

# Alterando os nomes dos eixos dos gr�ficos

# Fazemos uso da fun��o labs()
ggplot(data = clima_jan,
       aes(x = time_hour, y = temp)) +
  geom_line()+
  labs(title = "Titulo do Gr�fico",
       subtitle = "Subt�tulo do Gr�fico",
       x = "T�tulo do Eixo X",
       y = "T�tulo do Eixo Y",
       caption = "Legenda do Gr�fico")

# Alterando o nome da legenda dos valores
# fazemos uso da fun��o guides()

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))

# Alterando a posi��o da legenda
# Fazemos uso da fun��o theme()

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom")

# Para alterar qualquer elemento do gr�fico podemos usar a fun��o theme

# centralizando o t�tulo

ggplot(data = clima_jan,
       aes(x = time_hour, y = temp)) +
  geom_line()+
  labs(title = "Titulo do Gr�fico",
       subtitle = "Subt�tulo do Gr�fico",
       x = "T�tulo do Eixo X",
       y = "T�tulo do Eixo Y",
       caption = "Legenda do Gr�fico")+
  theme(plot.title = element_text(hjust = .5),
        plot.subtitle = element_text(hjust = .5),
        plot.caption = element_text(hjust =0))
  
# mudando a cor do fundo do gr�fico, por exemplo

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom",
        panel.background = element_rect(fill = "lightblue")
        )

# mudando a cor do painel

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom",
        panel.background = element_rect(fill = "lightblue", color = "red", size = 5)
  )

# mudando o tipo de linha do painel

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom",
        panel.background = element_rect(fill = "lightblue", color = "red",linetype = "dashed")
  )

# alterando a cor painel

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom",
        panel.background = element_rect(fill = "lightblue", color = "red",linetype = "dashed"),
        plot.background = element_rect(fill = "green")
  )

# alterando a posi��o dos valores do eixo x

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme(legend.position = "bottom",
        panel.background = element_rect(fill = "lightblue", color = "red",linetype = "dashed"),
        plot.background = element_rect(fill = "green"),
        axis.text.x = element_text(angle = 90)
        
  )

# tamb�m podemos usar temas pr� definidos

ggplot(data = a,
       aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")+
  guides(fill = guide_legend("T�tulo da Legenda"))+
  theme_light()+
  theme(legend.position = "bottom")


# por fim, podemos usar o themeset pra definir o theme de todos os nossos gr�ficos.
theme_set()