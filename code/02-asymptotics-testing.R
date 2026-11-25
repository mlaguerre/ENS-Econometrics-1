# WLLN illustration

set.seed(123)

#Normally distributed

mu<-0
sd<-1

means<-c()
sample_sizes<-seq(10,3000,by=10)

for (n in sample_sizes){
  x<-rnorm(n = n, mean = mu, sd = sd)
  means<-c(means, mean(x))
}

plot(sample_sizes, means, type='l')
abline(h=mu)

# Uniformly distributed

min<-0
max<-100

means<-c()
sample_sizes<-seq(10,3000,by=10)

for (n in sample_sizes){
  x<-runif(n = n, min = min, max = max)
  means<-c(means, mean(x))
}

plot(sample_sizes, means, type='l')
abline(h=((max+min)/2))



# CLT illustration
min <- 0
max <- 10
n_rep <- 1000
sample_sizes <- c(10, 100, 1000)

# Simulate the sample means
means_list <- list()
for (n in sample_sizes) {
  means <- numeric(n_rep)
  for (b in 1:n_rep) {
    x <- runif(n = n, min = min, max = max)
    means[b] <- mean(x)
  }
  means_list[[as.character(n)]] <- means
}

# Normal pdf mean
mu <- (min + max) / 2

# One panel per sample size
par(mfrow = c(1, length(sample_sizes)))

for (i in seq_along(sample_sizes)) {
  n      <- sample_sizes[i]
  sigma2 <- (max - min)^2 / 12
  sigma  <- sqrt(sigma2)
  
  xlim <- c(-12,12)
  
  h <- hist(sqrt(n)*(means_list[[i]]-mu), breaks = 30, plot = FALSE)
  ymax <- max(h$density, dnorm(0, 0, sigma))
  
  hist(sqrt(n)*(means_list[[i]]-mu), breaks = seq(-12,12,1), freq = FALSE,
       col = "lightgreen", border = "white",
       xlim = xlim, ylim = c(0, ymax * 1.05),
       main = paste("n =", n),
       xlab = "Sample mean", ylab = "Density")
  
  curve(dnorm(x, mean = 0, sd = sigma),
        add = TRUE, lwd = 2, col = "red")
  
  legend("topright",
         legend = c("Histogram of means", "Normal pdf"),
         fill   = c("lightgreen", NA),
         border = c("white", NA),
         lty    = c(NA, 1),
         lwd    = c(NA, 2),
         col    = c(NA, "red"),
         bty = "n", cex = 0.8)
}

par(mfrow = c(1, 1))  # reset layout
