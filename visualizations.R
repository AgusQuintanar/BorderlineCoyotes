df <- read.csv(file.choose(), stringsAsFactors = T, sep = ',')
str(df)

# Analisis Exploratorio
library(ggplot2)
library(ggthemes)

# Origen de los migrantes
table.1 <-table(df[,c("X.En.qué.país..estado..municipio.y.localidad..nació.usted..Estado")])
table.1 <- as.data.frame(table.1)
colnames(table.1) <- c("estado", "cantidad")
table.1

plot <- ggplot(data = table.1, aes(x=estado, y=cantidad, fill=cantidad))
plot <- plot + geom_bar(stat = "identity") + theme_economist()
plot + ggtitle("Origen de los migrantes devueltos") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# Edad de los migrantes
edades <- df[,c("X.Cuántos.años.cumplidos.tiene.usted.")]

plot <- ggplot(data = df, aes(x=X.Cuántos.años.cumplidos.tiene.usted.))
plot <- plot + geom_histogram() + theme_economist()
plot + xlab('Edad') + ylab('Personas') + ggtitle('Edad de los migrantes devueltos')
colnames(df[,147:148])


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

# Intentos de cruce realizados para poder entrar
plot <- ggplot(df.coyote, aes(Esta.última.vez...cuántos.intentos.de.cruce.realizó.antes.de.ser.detenido.a..por.la.migra.u.otra.autoridad.estadounidense.))
plot + geom_bar() + theme_economist() + ylab("Encuestados") + xlab("Intentos") + ggtitle("Intentos de cruce realizados antes de ser detenido por la migra")

# Número de familiares o conocidos que cruzaron con usted la frontera
plot <- ggplot(df.coyote, aes( Esta.última.vez.que.entró.a.Estados.Unidos...cuántos.familiares.o.conocidos.cruzaron.con.usted.la.frontera.))
plot + geom_bar() + theme_economist() + ylab("Encuestados") + xlab("Número de familiares o conocidos") + ggtitle("Número de familiares o conocidos que cruzaron con usted la frontera")

bincolors <- c("#a92626","#26a96c")
# *Al cruzar la frontera usted tuvo frío o calor extremo
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..tuvo.frío.o.calor.extremo.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera usted tuvo frío o calor extremo")

# *Al cruzar la frontera le faltaron alimentos o agua
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..le.faltaron.alimentos.o.agua.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera le faltaron alimentos o agua")

# Al cruzar la frontera tuvo mareos o desmayos
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..tuvo.mareos.o.desmayos.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera tuvo mareos o desmayos")

# *Al cruzar la frontera casi se ahoga en un río o canal
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..casi..se.ahogó.en.un.río.o.canal.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera casi se ahoga en un río o canal")

# *Al cruzar la frontera se perdió en el camino
plot <- ggplot(df.coyote, aes( Al.cruzar.a.Estados.Unidos...alguna.vez.usted..se.perdió.en.el.camino.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera se perdió en el camino")

# Al cruzar la frontera le atacaron animales salvajes
plot <- ggplot(df.coyote, aes( Al.cruzar.a.Estados.Unidos...alguna.vez.usted..fue.atacado.o.picado.por.animales.salvajes.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera le atacaron animales salvajes")

# Al cruzar la frontera le abandonó del pollero
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..le.abandonó.del.pollero.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera le abandonó del pollero")

# Al cruzar la frontera le asaltaron o robaron
plot <- ggplot(df.coyote, aes(Al.cruzar.a.Estados.Unidos...alguna.vez.usted..le.extorsionaron..cobro.de.cuota.o.secuestro..))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Al cruzar la frontera le asaltaron o robaron")

# Contrató usted coyote, pollero o lanchero
plot <- ggplot(df.coyote, aes(En.esta.misma.ocasión...contrató.usted.a.alguna.persona..coyote..pollero..patero..guía..lanchero..para.que.le.guiara.al.cruzar.la.frontera.))
plot + geom_bar(fill=bincolors) + theme_economist() + ylab("Encuestados") + xlab("Respuesta") + ggtitle("Contrató usted coyote, pollero o lanchero")

# Dónde hizo el trato con la persona que le guió a cruzar la frontera
plot <- ggplot(df.coyote, aes(X.Dónde.hizo.el.contacto.con.la.persona.que.le.guio.a.cruzar.la.frontera.))
plot + geom_bar() + theme_economist() + ylab("Encuestados") + xlab("Lugar") + ggtitle("Lugar donde hizo el trato con la persona que le guió a cruzar la frontera") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# Precio que cobró el coyote por ayudarlo a cruzar la frontera
precios <- df.coyote[df.coyote$X.Cuánto.pagó.o.quedó.de.pagar.a.esa.persona.por.usted..Unidad == "Dólares",]$X.Cuánto.pagó.o.quedó.de.pagar.a.esa.persona.por.usted..Cantidad
precios <- as.numeric(as.character(precios))
precios <- as.data.frame(precios)
plot <- ggplot(precios, aes(precios))
plot + geom_histogram() + theme_economist() + ylab("Encuestados") + xlab("Precio en dólares") + ggtitle("Precio que cobró el coyote por ayudarlo a cruzar la frontera (USD)")


nrow(df.coyote)

