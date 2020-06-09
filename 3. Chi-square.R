# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

# Библиотека для хи-квадрат
library(stats)

# Рассчитаем хи-квадрат
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(chisq.test(a, b)[["statistic"]])
    vector <- c(vector, coeff)
  }
}

chi = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(chi) = names(data)
chi = as.data.frame(chi, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(chi, "3. Chi-square.xlsx", colNames=TRUE, rowNames=TRUE)

# Выполним проверку гипотезы о значимости взаимосвязей между переменными
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(chisq.test(a, b)[["p.value"]])
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
    print(row)
    print(col)
    print(sign)
  }
}
hyp = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(hyp) = names(data)
hyp = as.data.frame(hyp, row.names = names(data))
write.xlsx(hyp, "3. Chi-square. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)