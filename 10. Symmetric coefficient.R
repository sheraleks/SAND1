# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

library(DescTools)


vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    mytable = table(a, b)
    coeff = as.numeric(UncertCoef(a, b, direction="symmetric"))
    print(coeff)
    vector <- c(vector, coeff)
  }
}

cont = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(cont) = names(data)
cont = as.data.frame(cont, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(cont, "10. Symmetric coefficient.xlsx", colNames=TRUE, rowNames=TRUE)