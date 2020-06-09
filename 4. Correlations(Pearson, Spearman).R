# Библиотека для загрузки файлов Excel
library(readxl)
data = read_excel("1. Coded data.xlsx")

# Библиотека для корреляции
library(stats)

# Рассчитаем кор. Пирсона
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(cor.test(a, b)["estimate"])
    vector <- c(vector, coeff)
  }
}

pearson = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(pearson) = names(data)
pearson = as.data.frame(pearson, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(pearson, "4. Pearson.xlsx", colNames=TRUE, rowNames=TRUE)

# Выполним проверку гипотезы о значимости коэффициента корреляции Пирсона
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(cor.test(a, b)[["p.value"]])
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
  }
}
hyp = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(hyp) = names(data)
hyp = as.data.frame(hyp, row.names = names(data))
write.xlsx(hyp, "4. Pearson. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)

# Рассчитаем кор. Спирмена
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(cor.test(a, b, method="spearman")["estimate"])
    vector <- c(vector, coeff)
  }
}

spearman = matrix(vector,nrow=ncol(data),ncol=ncol(data))

colnames(spearman) = names(data)
spearman = as.data.frame(spearman, row.names = names(data))

# Библиотека для записи файлов Excel
library(openxlsx)
write.xlsx(spearman, "4. Spearman.xlsx", colNames=TRUE, rowNames=TRUE)

# Выполним проверку гипотезы о значимости коэффициента корреляции Пирсона
vector <- c()
for (row in names(data))
{
  for (col in names(data))
  {
    a = as.vector(data[[row]])
    b = as.vector(data[[col]])
    coeff = as.numeric(cor.test(a, b, method="spearman")[["p.value"]])
    sign = "-"
    if (coeff <= 0.05) sign = "+"
    vector <- c(vector, sign)
  }
}
hyp = matrix(vector,nrow=ncol(data),ncol=ncol(data))
colnames(hyp) = names(data)
hyp = as.data.frame(hyp, row.names = names(data))
write.xlsx(hyp, "4. Spearman. Hypothesis testing.xlsx", colNames=TRUE, rowNames=TRUE)