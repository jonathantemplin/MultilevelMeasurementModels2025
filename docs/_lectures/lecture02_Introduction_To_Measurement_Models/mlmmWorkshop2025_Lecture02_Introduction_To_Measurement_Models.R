# clear workspace =====================================================================================================
rm(list = ls())

# set options =========================================================================================================
options(width = 120, digits = 8, scipen = 9, show.signif.stars = FALSE, mc.cores = 4)

# Package installation ================================================================================================
needed_packages = 
  c("ggplot2", "mirt")
for (i in 1:length(needed_packages)){
  haspackage = require(needed_packages[i], character.only = TRUE)
  if (haspackage == FALSE) {
    install.packages(needed_packages[i])
  }
  library(needed_packages[i], character.only = TRUE)
}

# load modeling data ==================================================================================================
load("modelingData.RData")


# determine data specs ================================================================================================
correctReponseItems = names(modelingData)[grep(x = names(modelingData), pattern = "score")]
correctResponseData = modelingData[correctReponseItems]
nItems = length(correctReponseItems)
nObs = nrow(correctResponseData)

# non-Bayesian analyses ===============================================================================================

# 1PL analysis with mirt
model1PL_MIRT = mirt(data = correctResponseData, model = 1, itemtype = "Rasch")
coef(model1PL_MIRT, IRTpars = FALSE)
coef(model1PL_MIRT, IRTpars = TRUE)
plot(model1PL_MIRT, type = "trace") 
plot(model1PL_MIRT, type = "infoSE") 
M2(model1PL_MIRT)

# 2PL analysis with mirt
model2PL_MIRT = mirt(data = correctResponseData, model = 1, itemtype = "2PL")
coef(model2PL_MIRT, IRTpars = FALSE)
coef(model2PL_MIRT, IRTpars = TRUE)
plot(model2PL_MIRT, type = "trace") 
plot(model2PL_MIRT, type = "infoSE") 
M2(model2PL_MIRT)

# model comparison
anova(model1PL_MIRT, model2PL_MIRT)

