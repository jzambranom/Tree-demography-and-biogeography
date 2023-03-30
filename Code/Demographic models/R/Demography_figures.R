#####################################################################
####              Load libraries             ####
#####################################################################
library(cowplot) #version 1.0.0
library(ggplot2) #version 3.4.0
library(dplyr) #version 1.0.1.0

#####################################################################
####                       Read in data                          ####
#####################################################################
#Load results of the neighborhood analyses for survival and growth models
res_tab1 <- read.csv("survival_overlap.csv")
res_tab2 <- read.csv("growth_overlap.csv")

#Load either survival or growth data for the Wabikon plot to create bins for species population position in species range
data <- read.csv("survival_model_data.csv")


##########################################################################################
####      Create plots with results of neighborhood survival and growth plots   ####
##########################################################################################

# True if coefficient range doesn't include 0
res_tab1$signif <- res_tab1$lo * res_tab1$hi > 0
res_tab2$signif <- res_tab2$lo * res_tab2$hi > 0

#Create survival (p1) and growth (p2) plots 
theme_set(theme_cowplot(font_size=14)) #define font size

#Survival plot
p1 <- ggplot(data = filter(res_tab1, par != "Intercept"), 
             aes(x = par, y = med, ymin = lo, ymax = hi, shape = signif)) +
  labs(x = "", y = "", title = "Survival model") +
  geom_pointrange(size = 0.5) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  scale_shape_manual(values = c(1, 19), guide = FALSE) +
  coord_flip() + panel_border(colour = "black", size = 0.8,linetype = 1, remove = FALSE)+
  theme(plot.margin = unit(c(0,0,0,0), "cm")) 

#Growth plot
p2 <- ggplot(data = filter(res_tab2, par != "Intercept"), 
             aes(x = par, y = med, ymin = lo, ymax = hi, shape = signif)) +
  labs(x = "", y = "", title = "Growth model") +
  geom_pointrange(size = 0.5) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  scale_shape_manual(values = c(1, 19), guide = FALSE) +
  coord_flip() + panel_border(colour = "black", size = 0.8,linetype = 1, remove = FALSE) +
  theme(plot.margin = unit(c(0,1,0,1), "cm"))

##########################################################################################
####  Create plot with interaction between species quantile and conspecific density  ####
##########################################################################################

#create bins
bins <- mutate(data, new_bin = ntile(quantile, n=2))
bins$new_bin <- as.factor(bins$new_bin)

#Figure with interaction quantile and conspecific density
p3 <- ggplot(bins, aes(x=conspecific_density, y=status, group=new_bin, colour = new_bin)) +
  geom_smooth(method=lm, se =FALSE) +
  xlab("Conspecific Neighborhood Density") + ylab("Tree Survival") + labs(colour='Range quantile') +
  scale_color_manual(labels = c("Northern species", "Southern species"), values = c("red", "blue")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  panel_border(colour = "black", size = 0.8,linetype = 1, remove = FALSE)


#Use the ggdraw function from the cowplot package to put all the figures in a ssame plot
ggdraw() +
  draw_plot(p1, x = 0, y = .49, width = .45, height = .5) +
  draw_plot(p2, x = .5, y = .49, width = .5, height = .5) +
  draw_plot(p3, x = 0.145, y = 0, width = .47, height = 0.5) +
  draw_plot_label(label = c("A", "", "B"), size = 15,
                  x = c(0, 0.5, 0), y = c(1, 1, 0.5))




