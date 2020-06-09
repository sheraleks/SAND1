# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

library(DescTools)

a = as.vector(data[['Credit.history']])
b = as.vector(data[['Number.of.people']])
ContCoef(a, b)

# Рассчитаем коэфф
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = ContCoef(a, b)
    vector <- c(vector, coeff)
  }
}

cont = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(cont) = names(data)
cont = as.data.frame(cont, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(cont, "7. Contingency coefficient.xlsx", colNames=TRUE, rowNames=TRUE)