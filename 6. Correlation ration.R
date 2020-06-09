# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

library('DiscriMiner')

# test
a = as.vector(data[['Credit.history']])
b = as.vector(data[['Number.of.people']])
FRatio(a, b)["p_value"]
#-----------------------------

# Рассчитаем кор. отношение
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = corRatio(a, b)
    vector <- c(vector, coeff)
  }
}

corrat = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(corrat) = names(data)
corrat = as.data.frame(corrat, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(corrat, "6. Correlation ratio.xlsx", colNames=TRUE, rowNames=TRUE)


# Выполним проверку гипотезы о значимости отношения
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(FRatio(a, b)["p_value"])
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
  }
}
hyp = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(hyp) = names(data)
hyp = as.data.frame(hyp, row.names = names(data))
write.xlsx(hyp, "6. Correlation ratio. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)