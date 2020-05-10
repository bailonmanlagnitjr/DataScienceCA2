# bailon manlagnit
# Read to a data frame. 
#setwd("C:/Users/bailo/OneDrive/Documents/DataScienceCA")

file_data <- read.csv("Residential_Property_Housing.csv", skip = 1, header = FALSE)
head(file_data)

# check the type of file
class(file_data)

# display the structure of the file
str(file_data)

# add column names
col_names = c("Datacode", "SA_NAME", "GEOGID", "Elect_Div_Cd", "Elect_Div_Nm","County",
              "NUTS_III", "NUTS_II", "Planning_Reg", "TOA_Bungalow", "TOA_Flat_Apt", "TOA_Bedsit",
              "TOA_Mob", "TOA_Unk", "TOA_Tot","PTOA_Bungalow", "PTOA_Flat_Apt", "PTOA_Bedsit",
              "PTOA_Mob", "PTOA_Unk","YB_P19", "YB_1945","YB_4660", "YB_6170", "YB_7180",
              "YB_8190", "YB_9100", "YB_0105", "YB_06Plus", "YB_Unk", "YB_Tot","PYB_P19", "PYB_1945","PYB_4660", 
              "PYB_6170", "PYB_7180", "PYB_8190", "PYB_9100", "PYB_0105", "PYB_06Plus", "PYB_Unk", "Owner_Occupied", 
              "Occ_OOwM", "Occ_OOwoM", "Occ_RentPL", "Occ_RentLA", "Occ_RentVB", "Occ_Free", "Occ_RentAll",
              "Occ_Unk", "Occ_Tot", "POcc_OO", "POcc_OOwM", "POcc_OOwoM", "POcc_RentPL", "POcc_RentLA", 
              "POcc_RentVB", "POcc_Free", "POcc_RentAll", "POcc_Unk", "Bdrm1", "Bdrm2", "Bdrm3", "Bdrm4",
              "Bdrm5", "Bdrm6", "Bdrm7", "Bdrm8plus", "UnkRoom", "TotRoom", "P1Room", "P2Room", "P3Room", "P4Room",
              "P5Room", "P6Room", "P7Room", "P8Room", "PUnkRoom", "Ht_none", "Ht_Oil", "Ht_Gas", "Ht_Elect", 
              "Ht_Coal", "Ht_Peat", "Ht_Lqd", "Ht_Wood", "Ht_Oth", "Ht_Unk", "Ht_Tot", "PHt_none", "PHt_Oil", 
              "PHt_Gas", "PHt_Elect", "PHt_Coal", "PHt_Peat", "PHt_Lqd", "PHt_Wood", "PHt_Oth", "PHt_Unk", 
              "Water_Pub", "Water_GrpP", "Water_GrpLA", "Water_Priv", "Water_None", "Water_Unk", "Water_Tot", 
              "PWater_Pub", "PWater_GrpP", "PWater_GrpLA", "PWater_Priv", "PWater_None", "PWater_Unk", "Sew_Pub",
              "Sew_IndSep", "Sew_OthInd", "Sew_Oth", "Sew_None", "Sew_Unk", "Sew_Tot", "PSew_Pub", "PSew_IndSep",
              "PSew_OthInd", "PSew_Oth", "PSew_None", "PSew_Unk", "Nght_Occ", "Nght_Unocc", "Nght_Tot", 
              "PNght_Occ", "PNght_Unocc")
colnames(file_data) <- col_names
head(file_data)



# Read population dataset 
pop_file_data <- read.csv("Ireland_Population_2011.csv")
apop_file_data <- subset(pop_file_data, select=c(SA_NAME, 
                                                 Elect_Div_Cd, 
                                                 Elect_Div_Nm, 
                                                 County, 
                                                 Total_Population_2011))
str(apop_file_data)
head(apop_file_data)

#######################################################################################################################
# merge the residential property-housing data with the population data
afile_data <- merge(file_data, apop_file_data) 
head(afile_data)

# Remove the columns which are percentages
nfile_data <- subset(afile_data, select=-c(Datacode, SA_NAME, GEOGID, Elect_Div_Cd, Elect_Div_Nm, PTOA_Bungalow, PTOA_Flat_Apt, PTOA_Bedsit,
                                          PTOA_Mob, PTOA_Unk, PYB_P19, PYB_1945, PYB_4660, 
                                          PYB_6170, PYB_7180, PYB_8190, PYB_9100, PYB_0105,
                                          PYB_06Plus, PYB_Unk, POcc_OO, POcc_OOwM, POcc_OOwoM, 
                                          POcc_RentPL, POcc_RentLA, POcc_RentVB, POcc_Free, POcc_RentAll, POcc_Unk,
                                          P1Room, P2Room, P3Room, P4Room,P5Room, P6Room, P7Room, P8Room, PUnkRoom, 
                                          PHt_none, PHt_Oil, PHt_Gas, PHt_Elect, PHt_Coal, PHt_Peat, PHt_Lqd, PHt_Wood, 
                                          PHt_Oth, PHt_Unk, PWater_Pub, PWater_GrpP, PWater_GrpLA, PWater_Priv, PWater_None, 
                                          PWater_Unk, PSew_Pub, PSew_IndSep, PSew_OthInd, PSew_Oth, PSew_None, PSew_Unk,
                                          PNght_Occ, PNght_Unocc))
head(nfile_data)

str(nfile_data)

# change to character from factor
nfile_data$County <- as.character(nfile_data$County)
nfile_data$NUTS_III <- as.character(nfile_data$NUTS_III)
nfile_data$NUTS_II <- as.character(nfile_data$NUTS_II)
nfile_data$Planning_Reg <- as.character(nfile_data$Planning_Reg)

# convert NUTS_III to numeric: 1-Border, 2-Dublin, 3-Mid-East, 4-Midlands, 5-Mid-West, 6-South-East, 7-South-West, 8-West
nfile_data$NUTS_III[nfile_data$NUTS_III == "Border"] <- "1"
nfile_data$NUTS_III[nfile_data$NUTS_III == "Dublin"] <- "2"
nfile_data$NUTS_III[nfile_data$NUTS_III == "Mid-East"] <- "3"
nfile_data$NUTS_III[nfile_data$NUTS_III == "Midlands"] <- "4"
nfile_data$NUTS_III[nfile_data$NUTS_III == "Mid-West"] <- "5"
nfile_data$NUTS_III[nfile_data$NUTS_III == "South-East"] <- "6"
nfile_data$NUTS_III[nfile_data$NUTS_III == "South-West"] <- "7"
nfile_data$NUTS_III[nfile_data$NUTS_III == "West"] <- "8"

# convert NUTS_II to numeric: 1-BMW, 2-SE
nfile_data$NUTS_II[nfile_data$NUTS_II == "BMW"] <- "1"
nfile_data$NUTS_II[nfile_data$NUTS_II == "SE"] <- "2"

# convert planning region to numeric: 1-Eastern and Midlands, 2-North and West, 3-Southern
nfile_data$Planning_Reg[nfile_data$Planning_Reg == "Eastern and Midlands"] <- "1"
nfile_data$Planning_Reg[nfile_data$Planning_Reg == "North and West"] <- "2"
nfile_data$Planning_Reg[nfile_data$Planning_Reg == "Southern"] <- "3"

head(nfile_data)
str(nfile_data)

# move to ofile_data
ofile_data <- nfile_data

# get the summary of the data
summary(ofile_data)

str(ofile_data)
head(ofile_data)

# TOA - Total of accomodation - reduce the number of columns related to this by combining
# "TOA_Bungalow", "TOA_Flat_Apt", "TOA_Bedsit","TOA_Mob", "TOA_Unk", "TOA_Tot"
# to 2 columns only: "TOA_Bungalow" and "TOA_Other"
ofile_data$TOA_Other <- ofile_data$TOA_Flat_Apt + ofile_data$TOA_Bedsit + ofile_data$TOA_Mob + ofile_data$TOA_Unk

# delete the other columns not needed
pfile_data <- subset(ofile_data, select=-c(TOA_Flat_Apt, TOA_Bedsit, TOA_Mob, TOA_Unk, TOA_Tot))
str(pfile_data)
head(pfile_data)



# YB - Year built - reduce the number of columns related to this by combining
# "YB_P19", "YB_1945","YB_4660", "YB_6170", "YB_7180", "YB_8190", "YB_9100", "YB_0105", "YB_06Plus", "YB_Unk"
# to only 2 columns: those built up to Year 2000 (YB_Pre2000) and those After YB_Post2000
pfile_data$YrBlt_Pre2000 <- pfile_data$YB_P19 + 
                          pfile_data$YB_1945 + 
                          pfile_data$YB_4660 + 
                          pfile_data$YB_6170 + 
                          pfile_data$YB_7180 + 
                          pfile_data$YB_8190 + 
                          pfile_data$YB_9100

pfile_data$YrBlt_Post2000 <- pfile_data$YB_0105 + pfile_data$YB_06Plus + pfile_data$YB_Unk

# delete the column not needed
qfile_data <- subset(pfile_data, select=-c(YB_P19, YB_1945,YB_4660, YB_6170, YB_7180, YB_8190, 
                                          YB_9100, YB_0105, YB_06Plus, YB_Unk, YB_Tot))
str(qfile_data)
head(qfile_data)

# OCC - Occupancy 
# drop some columns - "Occ_RentPL", "Occ_RentLA", "Occ_RentVB", "Occ_Tot"
rfile_data <- subset(qfile_data, select=-c(Occ_RentPL, Occ_RentLA, Occ_RentVB, Occ_Unk, Occ_Tot))
str(rfile_data)
head(rfile_data)

# Number of rooms - combine the columns to form only 2 columns: (1)those with 6 and below (2) more than 6
# "TotRoom"
rfile_data$Bdrm6less  <-  rfile_data$Bdrm1 + 
                          rfile_data$Bdrm2 +  
                          rfile_data$Bdrm3 + 
                          rfile_data$Bdrm4 + 
                          rfile_data$Bdrm5 + 
                          rfile_data$Bdrm6
rfile_data$Bdrm6more  <-  rfile_data$Bdrm7 + 
                          rfile_data$Bdrm8plus +  
                          rfile_data$UnkRoom

# remove columns not needed
sfile_data <- subset(rfile_data, select=-c(Bdrm1, Bdrm2, Bdrm3, Bdrm4, Bdrm5, Bdrm6, Bdrm7, Bdrm8plus, UnkRoom, TotRoom))
str(sfile_data)
head(sfile_data)

# HT - heating of the residentail property - we will reduce to 2 columns: Oil and others
sfile_data$Ht_Others  <-  sfile_data$Ht_none + 
                          sfile_data$Ht_Gas + 
                          sfile_data$Ht_Elect + 
                          sfile_data$Ht_Coal +
                          sfile_data$Ht_Peat +
                          sfile_data$Ht_Lqd +
                          sfile_data$Ht_Wood +
                          sfile_data$Ht_Oth +
                          sfile_data$Ht_Unk
# remove other columns
tfile_data <- subset(sfile_data, select=-c(Ht_none, Ht_Gas, Ht_Elect, Ht_Coal, Ht_Peat, Ht_Lqd, Ht_Wood, Ht_Oth, Ht_Unk, Ht_Tot)) 
str(tfile_data)
head(tfile_data)

# Residential property Water  source - we will reduce to 2 columns
# "Water_Pub", "Water_GrpP", "Water_GrpLA", "Water_Priv", "Water_None", "Water_Unk", "Water_Tot",
tfile_data$Water_Others  <-   tfile_data$Water_Pub + 
                              tfile_data$Water_GrpP +
                              tfile_data$Water_GrpLA + 
                              tfile_data$Water_None + 
                              tfile_data$Water_Unk 
tfile_data <- subset(tfile_data, select=-c(Water_Pub, Water_GrpP, Water_GrpLA, Water_None, Water_Unk, Water_Tot))
str(tfile_data)
head(tfile_data)

# Sewage Facilities: we will reduce to 2 columns - Sew_IndSep and Sew_Others
# "Sew_Pub", "Sew_IndSep", "Sew_OthInd", "Sew_Oth", "Sew_None", "Sew_Unk", "Sew_Tot"
tfile_data$Sew_Others  <-   tfile_data$Sew_Pub + 
                            tfile_data$Sew_OthInd +
                            tfile_data$Sew_Oth + 
                            tfile_data$Sew_None + 
                            tfile_data$Sew_Unk 
tfile_data <- subset(tfile_data, select=-c(Sew_Pub, Sew_OthInd, Sew_Oth, Sew_None, Sew_Unk, Sew_Tot))
str(tfile_data)
head(tfile_data)                                           

# remove night occupancy total
tfile_data <- subset(tfile_data, select=-c(Nght_Tot))
str(tfile_data)
head(tfile_data)                                           

# reorder the columbs so that related fields are beside each other
ufile_data <- tfile_data[,c(1,2,3,4,5,19,20,21,7,8,6,9,10,11,24,22,23,12,25,13,26,14,15,16,17,18)]
str(ufile_data)
head(ufile_data)                                           

# sort
ufile_data <- ufile_data[order(ufile_data$County), ]
str(ufile_data)
head(ufile_data)                                           


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# use aggregate to create sums of the columns per county, NUTS_III, NUTS_II, Planning registration:
cfile_data <- aggregate( as.matrix(ufile_data[,5:24]), as.list(ufile_data[,1:4]), FUN = sum)

# sort
vfile_data <- cfile_data[order(cfile_data$County), ]

#remove NA rows
vfile_data <- vfile_data[!is.na(vfile_data$County), ]
head(vfile_data$County, 34)
str(vfile_data)
nrow(vfile_data)

# There are 4 areas that belong to Dublin, 2 each for Cork, Galway, Limerick, and Waterford
# We need to consolidate them further
vfile_data$County[vfile_data$County == "Dublin City"] <- "Dublin"
vfile_data$County[vfile_data$County == "D?n Laoghaire-Rathdown"] <- "Dublin"
vfile_data$County[vfile_data$County == "Fingal"] <- "Dublin"
vfile_data$County[vfile_data$County == "South Dublin"] <- "Dublin"
vfile_data$County[vfile_data$County == "Cork City"] <- "Cork"
vfile_data$County[vfile_data$County == "Cork County"] <- "Cork"
vfile_data$County[vfile_data$County == "Galway City"] <- "Galway"
vfile_data$County[vfile_data$County == "Galway County"] <- "Galway"
vfile_data$County[vfile_data$County == "Limerick City"] <- "Limerick"
vfile_data$County[vfile_data$County == "Limerick County"] <- "Limerick"
vfile_data$County[vfile_data$County == "Waterford City"] <- "Waterford"
vfile_data$County[vfile_data$County == "Waterford County"] <- "Waterford"
vfile_data$County[vfile_data$County == "Laoighis"] <- "Laois"


# run aggregation again
wfile_data <- aggregate( as.matrix(vfile_data[,5:24]), as.list(vfile_data[,1:4]), FUN = sum)
wfile_data <- wfile_data[!is.na(wfile_data$County), ]
head(wfile_data)
str(wfile_data)
nrow(wfile_data)

# move to another variable
pre_residential_data <- wfile_data

########################################################################################################################################
# Read housing sales dataset 
sales_data <- read.csv("Residential_Property_Value_of_sales_Monthly.csv")
str(sales_data)

# accumulate the the 2011 monthly sales to annual sales
sales_data$Annual_Sales <- sales_data$X2011M01 + sales_data$X2011M02 + sales_data$X2011M03 + sales_data$X2011M04 + sales_data$X2011M05 + sales_data$X2011M06 +
  sales_data$X2011M07 + sales_data$X2011M08 + sales_data$X2011M08 + sales_data$X2011M10 + sales_data$X2011M11 + sales_data$X2011M12
str(sales_data)


# get only the needed columns: county and sales_data
nsales_data <- subset(sales_data, select = c(County, Annual_Sales))
str(nsales_data)
head(nsales_data)

# accumulate the 2011 annual sales by county
msales_data <- aggregate(nsales_data$Annual_Sales, by=list(nsales_data$County), sum)
head(msales_data)
nrow(msales_data)
str(msales_data)

col_names = c("County", "Sales_in_Mil_2011")
colnames(msales_data) <- col_names
head(msales_data)


# merge the sales data into the main dataset
residential_data <- merge(wfile_data, msales_data) 
head(residential_data)
str(residential_data)
nrow(residential_data)

# Adjust tipperary by half
residential_data$Sales_in_Mil_2011[residential_data$County == "Tipperary"] <- residential_data$Sales_in_Mil_2011[residential_data$County == "Tipperary"]/2
head(residential_data$Sales_in_Mil_2011[residential_data$County == "Tipperary"])

# save to a csv file
write.csv(residential_data,"adjusted_residential_data.csv",row.names = F,quote = F)


########################################################################################################################################

tot_prop <- subset(residential_data,  select = c(County, TOA_Bungalow, TOA_Other))
head(tot_prop)

tot_prop$TOA_Tot <- tot_prop$TOA_Bungalow + tot_prop$TOA_Other
head(tot_prop)

# create a variable to hold the grand total for the number of accomodation per county
agg = sum(as.numeric(tot_prop$TOA_Tot), na.rm = TRUE)
agg

# create a new column called TOA_Prop as the total number of accomodation per county expressed as a portion of the total
tot_prop$TOA_Prop <- tot_prop$TOA_Tot/agg
head(tot_prop)

# plot Total accomodation per county
library(ggplot2)
library(viridis)

ggplot(tot_prop, aes(x = County, y = TOA_Tot)) +  theme(axis.text.x=element_text(angle=45,hjust=1)) + 
  geom_bar(stat="identity", color="red", fill="white") +
  ggtitle("Total residential accomodation per County") +
  xlab("County") + ylab("Total Residential Accomodation")

# plot Total accomodation per county (proportion)
ggplot(tot_prop, aes(x = County, y = TOA_Prop)) +  theme(axis.text.x=element_text(angle=45,hjust=1)) + 
  geom_bar(stat="identity", color="blue", fill="white") +
  ggtitle("Proportion of residential accomodation per County") +
  xlab("County") + ylab("Proportion")

########################################################################################################################################

# Use sapply() to check for numeric across the variables
numeric_var_list <- sapply(pre_residential_data, is.numeric)
numeric_var_list


# change to numeric
pre_residential_data$NUTS_III <- as.numeric(pre_residential_data$NUTS_III)
pre_residential_data$NUTS_II <- as.numeric(pre_residential_data$NUTS_II)
pre_residential_data$Planning_Reg <- as.numeric(pre_residential_data$Planning_Reg)

# rerun to use sapply() to check for numeric across the variables
numeric_var_list <- sapply(pre_residential_data, is.numeric)
numeric_var_list

# Get a subset of the data - only for numeric
numeric_data <- pre_residential_data[numeric_var_list]
colnames(numeric_data)
numeric_data

#  Use the lapply() function to return a named list where each list member has a corresponding name
lapply(numeric_data, summary)





# get numeric variables
data_numeric_var <- sapply(pre_residential_data, is.numeric)
data_numeric_var

# extract only the numeric columns
pca_data_file <- pre_residential_data[, data_numeric_var]
pca_data_file
str(pca_data_file)

# create pca
pca <- prcomp(pca_data_file, center = TRUE, scale. = TRUE)
summary(pca)
head(pca)
str(pca)

# eigenvalues
library("factoextra")
eig_values <- get_eigenvalue(pca)
eig_values

# Scree plot
fviz_eig(pca, addlabels = TRUE, ylim = c(0, 80))

# To extract components of pca, use get_pca_var()
pca_for_variables <- get_pca_var(pca)
pca_for_variables

# using correlation plot to display representation of variables 
library("corrplot")
corrplot(pca_for_variables$cos2, is.corr = FALSE)

# graph of variables
fviz_pca_var(pca, col.var = "blue")

# co2 graph for the first 3 components
fviz_cos2(pca, choice = "var", axes = 1:3)

# biplot to show quality on the factor map
fviz_pca_var(pca, col.var = "cos2",
             gradient.cols = c("red", "Blue", "Green"), 
             repel = TRUE # Avoid text overlapping
)  

# by the contribution
fviz_pca_var(pca, col.var = "contrib",
             gradient.cols = c("red", "Blue", "Green"),
)

#
head(pca_for_variables$contrib, 23)

################## variable contrib


fviz_contrib(pca, choice = "var", axes = 1, top = 23)

#
fviz_contrib(pca, choice = "var", axes = 2, top = 23)

fviz_contrib(pca, choice = "var", axes = 1:5, top = 23)

#
################################################################################################################
# Normality test 
# Visual assessment on the first 5
library(ggpubr)
ggqqplot(pre_residential_data$TOA_Bungalow) + ggtitle("TOA_Bungalow")
ggqqplot(pre_residential_data$TOA_Other) + ggtitle("TOA_Other")
ggqqplot(pre_residential_data$YrBlt_Pre2000) + ggtitle("YrBlt_Pre2000")
ggqqplot(pre_residential_data$YrBlt_Post2000) + ggtitle("YrBlt_Post2000")
ggqqplot(pre_residential_data$Occ_OOwM) + ggtitle("Occ_OOwM")

# using Shapiro-Wilks test for normality
apply(pca_data_file, 2, shapiro.test)

t.test(residential_data$TOA_Bungalow)

# statistical method: KRUSKAL 
kruskal.test(NUTS_III ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(NUTS_II ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(TOA_Bungalow ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(TOA_Other ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(YrBlt_Pre2000 ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(YrBlt_Post2000 ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Occ_OOwM ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Occ_OOwoM ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Owner_Occupied ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Occ_Free ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Occ_RentAll ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Ht_Oil ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Ht_Others ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Bdrm6more ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Water_Priv ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Water_Others ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Sew_IndSep ~ Sales_in_Mil_2011, data = residential_data)
kruskal.test(Sew_Others ~ Sales_in_Mil_2011, data = residential_data)

# power test
#install.packages("pwr")
str(residential_data)
library(pwr)

# find power
pwr.f2.test(u = 23, v = 3,  f2 = 0.3/(1 - 0.3), sig.level = 0.001)

# find number of samples
pwr.f2.test(u = 23, f2 = 0.3/(1 - 0.3), sig.level = 0.001, power = 0.8)
