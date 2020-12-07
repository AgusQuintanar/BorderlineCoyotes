df <- read.csv(file.choose(), stringsAsFactors = T, sep = ',')
str(df)

# ¿Coyotes ayudaron a cruzar?

coyote.column <- "En.esta.misma.ocasión...contrató.usted.a.alguna.persona..coyote..pollero..patero..guía..lanchero..para.que.le.guiara.al.cruzar.la.frontera."
table(df[,c(coyote.column)])
# Elegimos solo datos con respuesta valida a la pregunta
df.coyote <- subset(df, En.esta.misma.ocasión...contrató.usted.a.alguna.persona..coyote..pollero..patero..guía..lanchero..para.que.le.guiara.al.cruzar.la.frontera.  == 'Sí'| En.esta.misma.ocasión...contrató.usted.a.alguna.persona..coyote..pollero..patero..guía..lanchero..para.que.le.guiara.al.cruzar.la.frontera.  == 'No')
table(df.coyote[,c(coyote.column)])
# Seleccion de datos necesarios
df.coyote <- df.coyote[,125:150]
df.coyote


summary(df.coyote)

## MODELO

# Juntar todos los percances y sumarlos
df.coyote.model <- df.coyote[df.coyote$X.Cuánto.pagó.o.quedó.de.pagar.a.esa.persona.por.usted..Unidad == "Dólares",]
df.model <- df.coyote.model[,c(7:17, 25)]
str(df.model)

# Debido a que los datos son respuestas binarias no se necesita one hot encoding
bintoint <- function (c){
  if(c == 'Sí'){
    return(1)
  }
  else return(0)
}

df.model.copy <- df.model
ncol(df.model.copy)

accum <- sapply(df.model.copy[,c(12)], bintoint)

for(i in 1:11){
  accum <- accum + sapply(df.model.copy[,c(i)], bintoint)
}

total.accidentes <- accum
precio <- as.numeric(as.character(df.model$X.Cuánto.pagó.o.quedó.de.pagar.a.esa.persona.por.usted..Cantidad))
df.train <- data.frame(total.accidentes, precio)

head(df.train)

plot <- ggplot(df.train, aes(precio, total.accidentes)) + geom_point()
plot <- plot + theme_economist() + xlab("Precio pagado al coyote (USD)") + ylab("Total de accidentes") + ggtitle("Precio del coyote y total de accidentes en el cruce de la frontera")
plot

model <- lm(total.accidentes ~ precio, data = df.train)
model

summary(model)

plot + stat_smooth(method = lm)