Analyses of tree demographic models as published in:

"Biogeographic context is related to local scale tree demography, co-occurrence and functional differentiation". Ecology Letters.

DOI of paper: 

Outline

This repository contains the final datasets and scripts of the above-mentioned paper. It can recreate the tree survival and growth models including the degree of geographic range overlap and the position of the local community within species ranges, and trait information for tree species from the Wabikon Forest Dynamics Plot located in Wisconsin.

The geographic range data used in this study were originally produced by the United States Geological Survey (USGS). The data were removed from the USGS website in 2017, but a web archive of the data can be found here (https://web.archive.org/web/20170127093428/https://gec.cr.usgs.gov/data/little/).  This study used a clone of that web archive that is publicly available in the following GitHub repository (https://github.com/wpetry/USTreeAtlas). The forest plot and soil data used in this study are available via the Smithsonian's ForestGeo data repository (https://forestgeo.si.edu/explore-data).

Running the scripts 

•	The project can be cloned or for those not familiar with GitHub, a zip file of this project can be downloaded using the "Clone or download" button at the top right of this page.

•	Open the R project file in the downloaded folder. R projects automatically assigns the root directory to the directory in which the project resides. Consequently, all of the analyses should be runnable without altering paths. These are very easy to open using RStudio.

•	The script to calculate the degree of geographic range overlap and the position of the local community within species ranges can be found is stored in the Code/.

•	An R subfolder is stored in Code/Demographic models and includes R scripts to run tree survival and growth models. This script follows the methods in the Supplementary Information of the paper.

•	An RJAGS subfolder is stored in Code/Demographic models and contains individual tree survival and growth jags models. These are kept separately and are needed to run hierarchical models including species and individual level data. For instructions in downloading JAGS, see the home page at: https://mcmc-jags.sourceforge.io. We used the lastest JAGS version 4.3.1.

•	All of the data needed to run the analyses are stored in Data/.

The scripts were run in RStudio version 1.2.1335, on macOS Ventura 13.1. We are unsure whether other versions of R will support all of the packages and whether the scripts will run exactly the same.
