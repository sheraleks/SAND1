# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

# Библиотека для функции взаимной информации
library(DescTools)

vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = MutInf(a, b, base=2)
    vector <- c(vector, coeff)
  }
}

MI = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(MI) = names(data)
MI = as.data.frame(MI, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(MI, "2. Mutual Information.xlsx", colNames=TRUE, rowNames=TRUE)

# Выполним проверку гипотезы о значимости показателя взаимной информации
# Устанавливается отдельно из репозитория bioconductor
library('maigesPack')

vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = bootstrapMI(a, b, 1000)
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
    print(row)
    print(col)
    print(sign)
  }
}
mi_p = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(mi_p) = names(data)
mi_p = as.data.frame(mi_p, row.names = names(data))
write.xlsx(mi_p, "2. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)
