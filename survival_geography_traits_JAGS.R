model
{
  
  #priors
  mubeta[1] ~ dnorm(0, 0.0001)  
  mubeta[2] ~ dnorm(0, 0.0001)
  mubeta[3] ~ dnorm(0, 0.0001)
  mubeta[4] ~ dnorm(0, 0.0001)
  mubeta[5] ~ dnorm(0, 0.0001)
  mubeta[6] ~ dnorm(0, 0.0001)
  mubeta[7] ~ dnorm(0, 0.0001)
  
  beta.t[1] ~ dnorm(0, 0.0001)
  beta.t[2] ~ dnorm(0, 0.0001)
  beta.t[3] ~ dnorm(0, 0.0001)
  beta.t[4] ~ dnorm(0, 0.0001)
  
  for (k in 1:7)
  {
    tau[k] ~ dgamma(0.0001, 0.0001)
  }
  
  sigma <- 1/tau
  
  # r ~ dgamma(1, 0.1)
  
  #put likliehod here likelihood
  for (j in 1:ns)  # for each species
  {
    beta1[j] ~ dnorm(mubeta[1] + quantile[j]*beta.t[1], tau[1]) # quantile alone effect
    beta2[j] ~ dnorm(mubeta[2] + quantile[j]*beta.t[2], tau[2]) # quantile * conspecific nci effect
    beta3[j] ~ dnorm(mubeta[3] + PC1[j]*beta.t[3], tau[3]) # traits effect PC1
    beta4[j] ~ dnorm(mubeta[4] + PC2[j]*beta.t[4], tau[4]) # traits effect PC2
    beta5[j] ~ dnorm(mubeta[5], tau[5]) # heterospecific effect
    beta6[j] ~ dnorm(mubeta[6], tau[6]) # neighborhood range overlap effect
    beta7[j] ~ dnorm(mubeta[7], tau[7]) # size effect
    
  }
  
  for (i in 1:nf) # for each focal tree
  {
    ps[i] ~ dbern(psurv[i])
    
    logit(psurv[i]) <- z[i]
    
    z[i] <- beta1[sp[i]] 
    + beta2[sp[i]]*(cnci[i]) 
    + beta3[sp[i]] 
    + beta4[sp[i]]
    + beta5[sp[i]]*(hnci[i]) 
    + beta6[sp[i]]*(overlap[i]) 
    + beta7[sp[i]]*size[i]  
    
    
  }
  
} 
