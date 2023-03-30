#####################################################################
####              Load libraries             ####
#####################################################################
library(MCMCpack) #version 1.6-0
library(coda) #version 0.19-4
library(dplyr) #version 1.0.10
library(rjags) #version 4-12
library(runjags) #version 2.2.0-3
load.module("glm")

#####################################################################
####                       Read in data                          ####
#####################################################################
#Survival data for the Wabikon plot
data_survival <- read.csv("Data/Demography/survival_model_data.csv")


#Create column with species as integer
data_survival$species <- as.integer(as.factor(data_survival$Species))

####Create species level information
spcol <- which(colnames(data_survival) == "species")
##For range overlap
rangecol <- which(colnames(data_survival) == "quantile") 
sp_range <- unique(data_survival[, c(spcol, rangecol)]) %>%
  arrange(species)

##For first trait axis
first_axis <- which(colnames(data_survival) == "first_trait_axis")
sp_first <- unique(data_survival[, c(spcol, first_axis)]) %>%
  arrange(species)

##For second trait axis
second_axis <- which(colnames(data_survival) == "second_trait_axis")
sp_second <- unique(data_survival[, c(spcol, second_axis)]) %>%
  arrange(species)

##########################################################################################
####      Survival model including range quantile, neighborhood metrics and traits    ####
##########################################################################################
#Create list with individual tree and species level data
data_mod1 <- list(nf = nrow(data_survival), ns = nrow(sp_range), 
                  ps = data_survival$status, size = data_survival$initial_size, 
                  cnci = data_survival$conspecific_density, hnci = data_survival$heterospecific_density, 
                  overlap = data_survival$logSES_range_overlap, 
                  sp = data_survival$species, quantile = sp_range$quantile, 
                  PC1 = sp_first$first_trait_axis, PC2 = sp_second$second_trait_axis)


n.adapt=10000
n.update=10000
n.iter=25000

mod1 <- jags.model("Code/Demographic models/RJAGS/survival_geography_traits_JAGS.R", data=data_mod1, n.chains=6, n.adapt=n.adapt)
update(mod1, n.update)
results_mod1 <- coda.samples(mod1, c("beta.t", "mubeta", "tau", "sigma"), n.iter=n.iter)
results_dic_mod1 <- dic.samples(mod1, n.iter, "pD") 


##################################################################################
####      Survival model including range quantile and neighborhood metrics    ####
##################################################################################
#Create list with individual tree and species level data
data_mod2 <- list(nf = nrow(data_survival), ns = nrow(sp_range), 
             ps = data_survival$status, size = data_survival$initial_size, 
             cnci = data_survival$conspecific_density, hnci = data_survival$heterospecific_density, 
             overlap = data_survival$logSES_range_overlap, 
             sp = data_survival$species, quantile = sp_range$quantile)


n.adapt=10000
n.update=10000
n.iter=25000

mod2 <- jags.model("Code/Demographic models/RJAGS/survival_geography_JAGS.R", data=data_mod2, n.chains=6, n.adapt=n.adapt)
update(mod2, n.update)
results_mod2 <- coda.samples(mod2, c("beta.t", "mubeta", "tau", "sigma"), n.iter=n.iter)
results_dic_mod2 <- dic.samples(mod2, n.iter, "pD") 



##################################################
####      Survival model including  traits    ####
##################################################
#Create list with individual tree and species level data
data_mod3 <- list(nf = nrow(data_survival), ns = nrow(sp_range), 
                  ps = data_survival$status, size = data_survival$initial_size, 
                  cnci = data_survival$conspecific_density, hnci = data_survival$heterospecific_density, 
                  sp = data_survival$species, 
                  PC1 = sp_first$first_trait_axis, PC2 = sp_second$second_trait_axis)


n.adapt=10000
n.update=10000
n.iter=25000

mod3 <- jags.model("Code/Demographic models/RJAGS/survival_traits_JAGS.R", data=data_mod3, n.chains=6, n.adapt=n.adapt)
update(mod3, n.update)
results_mod3 <- coda.samples(mod3, c("beta.t", "mubeta", "tau", "sigma"), n.iter=n.iter)
results_dic_mod3 <- dic.samples(mod3, n.iter, "pD") 

