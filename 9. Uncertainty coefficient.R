# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

library(ryouready)

library(DescTools)
a = as.vector(data[['Purpose']])
b = as.vector(data[['Status']])
UncertCoef(a, b)

vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(UncertCoef(a, b), direction="row")
    print(coeff)
    vector <- c(vector, coeff)
  }
}

cont = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(cont) = names(data)
cont = as.data.frame(cont, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(cont, "9. Uncertainty coefficient.xlsx", colNames=TRUE, rowNames=TRUE)