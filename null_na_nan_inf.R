##
##
## Testing Import of Nullable values in R environment
## Author: Tomaz Kastrun; 04.07.2018
## Blog: tomaztsql.wordpress.com
##
##

#reading documentation on all data types:
?NULL
?NA
?NaN
?Inf 


a <- "NA"
b <- "NULL"
c <- NULL
d <- NA
e <- NaN
f <- Inf

## Check if variables are same?
identical(a,d)
# [1] FALSE

# NA and NaN are not identical
identical(d,e)
# [1] FALSE

#checking length of data types
length(c)
# [1] 0
length(d)
# [1] 1
length(e)
# [1] 1
length(f)
# [1] 1


#checking data types
str(c); class(c); 
#NULL
#[1] "NULL"

str(d); class(d); 
#logi NA
#[1] "logical"
str(e); class(e); 
#num NaN
#[1] "numeric"
str(f); class(f); 
#num Inf
#[1] "numeric"


## Functions
is.null(1)
is.na(1)
is.nan(1)
is.infinite(1)



###################################
### GETTING DATA FROM R Environment
###################################

#empty vector
v1 <- c(NULL, NULL, NULL)
v2 <- NULL

str(v1); class(v1); mode(v1)
str(v2); class(v2); mode(v2)

v3 <- c(NA, NA, NA)
v4 <- NA

str(v3); class(v3); mode(v3)
str(v4); class(v4); mode(v4)


v5 <- c(NaN, NaN, NaN)
v6 <- NaN

str(v5); class(v5); mode(v5)
str(v6); class(v6); mode(v6)

#operation on NULL Vector
v1 <- c(NULL, NULL, NULL)
str(v1)
# NULL 

v1 <- v1+1
str(v1)
#  num(0) 

#empty data.frame
df1 <- data.frame(v1=NA,v2=NA, v3=NA)
df2 <- data.frame(v1=NULL, v2=NULL, v3=NULL)
df3 <- data.frame(v1=NaN, v2=NaN, V3=NaN)

str(df1); str(df2);str(df3)
#results
#'data.frame':	1 obs. of  3 variables:
#  $ v1: logi NA
#  $ v2: logi NA
#  $ v3: logi NA
#'data.frame':	0 obs. of  0 variables
#'data.frame':	1 obs. of  3 variables:
#  $ v1: num NaN
#  $ v2: num NaN
#  $ V3: num NaN


# adding new rows to existing dataframe
df1 <- rbind(df1, data.frame(v1=1, v2=2,v3=3))

#explore data.frame
df1

#if we try different dimension, we get an error
df1 <- rbind(df1, data.frame(v1=1, v2=2))


#adding a row to df2 (NULLable data.frame), it should be able to create
# data.frame as it wishes


df2 <- rbind(df2, data.frame(v1=1, v2=2))

#this will generate error
df2 <- rbind(df2, data.frame(v1=1, v2=NULL))

#and with NA should be fine
df2 <- rbind(df2, data.frame(v1=1, v2=NA))


## General understanding


v <- c(1:3)
v[4]
#[1] NA



#NULL
# argument in funciton
l <- list(a=1:10, b=c("a","b","c"), c=seq(0,10,0.5))
l$a
l$c
l$r



#calculaitons
a <- 0/0
b <- 1/0
c <- NULL
d <- NA

vect <- c(a,b,c,d)
vect




## Simple Calculations
g <- 0/0
str(g)
# num NaN
g <- 1/0 
str(g)
# num Inf


#Inf
2*Inf
c <- 2*NULL
str(c); class(c)
c <- NULL
str(c); class(c)

#NaN
Inf-Inf
0/0



###################################
### GETTING DATA FROM SQL SERVER
###################################

library(RODBC)
SQLcon <- odbcDriverConnect('driver={SQL Server};server=TOMAZK\\MSSQLSERVER2017;database=AzureLanding;trusted_connection=true')
#df <- sqlQuery(SQLcon, "SELECT * FROM R_Nullables")
df <- sqlQuery(SQLcon, "SELECT ID ,num1 ,num2 ,num3 ,tex1, tex2 FROM R_Nullables")
close(SQLcon)

df

#making some elementary calculations
df$num1 * 2
# [1] 2.4400 6.9068     NA 0.0000
is.na(df$num1)
# [1] FALSE FALSE  TRUE FALSE

# Text
df$text2
# NULL
df$text1
# NULL


#changing
# df <- sqlQuery(SQLcon, "SELECT ID ,num1 ,num2 ,num3 ,CAST(tex1 AS VARCHAR(100)) as text1 ,CAST(tex2 AS VARCHAR(100))  as text2 FROM R_Nullables")

df$text2
#[1] Varchar text   Varchar text 2 <NA>                         
#  Levels:  Varchar text Varchar text 2
df$text1
#[1] This is Nvarchar text      This another Nvarchar text <NA>                                                 
#  Levels:  This another Nvarchar text This is Nvarchar text


###################################
### GETTING DATA FROM TXT / CSV
###################################

setwd("C:\\Users\\Tomaz\\Documents\\06-SQL\\5-BlogPosts\\56")
dft <- read.csv("import_txt_R.txt")

dft

is.na(dft[5,])
#  text1 text2  val1  val2
#5  TRUE FALSE FALSE FALSE

str(dft)

is.na(dft[5,2])
#[1] FALSE

identical(class(dft[5,2]),class(dft[5,1]))
# [1] TRUE


