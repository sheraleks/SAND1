# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

library('MESS')
library('vcdExtra')

# Рассчитаем кор. Гудмена-Краскала
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    myTable = table(a, b)
    coeff = as.numeric(gkgamma(myTable)[3])
    vector <- c(vector, coeff)
  }
}

gud = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(gud) = names(data)
gud = as.data.frame(gud, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(gud, "5. Gudmen-Kruskall.xlsx", colNames=TRUE, rowNames=TRUE)


# Выполним проверку гипотезы о значимости коэффициента

vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    myTable = table(a, b)
    coeff = as.numeric(gkgamma(myTable)[2])
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
  }
}
hyp = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(hyp) = names(data)
hyp = as.data.frame(hyp, row.names = names(data))
write.xlsx(hyp, "5. Gudmen-Kruskall. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)