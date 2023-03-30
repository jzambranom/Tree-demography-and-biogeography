model
{
  
  #priors
  mubeta[1] ~ dnorm(0, 0.0001)  
  mubeta[2] ~ dnorm(0, 0.0001)
  mubeta[3] ~ dnorm(0, 0.0001)
  mubeta[4] ~ dnorm(0, 0.0001)
  mubeta[5] ~ dnorm(0, 0.0001)
  
  
  beta.t[1] ~ dnorm(0, 0.0001)
  beta.t[2] ~ dnorm(0, 0.0001)
  
  for (k in 1:5)
  {
    tau[k] ~ dgamma(0.0001, 0.0001)
  }
  
  sigma <- 1/tau
  
  # r ~ dgamma(1, 0.1)
  
  #put here likelihood
  for (j in 1:ns)  # for each species
  {
    beta1[j] ~ dnorm(mubeta[1] + quantile[j]*beta.t[1], tau[1]) # quantile alone effect
    beta2[j] ~ dnorm(mubeta[2] + quantile[j]*beta.t[2], tau[2]) # quantile * conspecific nci effect
    beta3[j] ~ dnorm(mubeta[3], tau[3]) # heterospecific nci effect
    beta4[j] ~ dnorm(mubeta[4], tau[4]) # neighborhood range overlap effect
    beta5[j] ~ dnorm(mubeta[5], tau[5]) # size effect
    
  }
  
  for (i in 1:nf) # for each focal tree
  {
    ps[i] ~ dbern(psurv[i])
    
    logit(psurv[i]) <- z[i]
    
    z[i] <- beta1[sp[i]] 
    + beta2[sp[i]]*(cnci[i]) 
    + beta3[sp[i]]*(hnci[i]) 
    + beta4[sp[i]]*(overlap[i]) 
    + beta5[sp[i]]*size[i]  
    
    
  }
  
} 
