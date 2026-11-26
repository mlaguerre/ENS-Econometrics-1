#Properties of the t-test

set.seed(123)

rejection_frequency <- function(beta1, n=50, n_rep=1, alpha=0.05, x_params=c(0,10), eps_params=c(0,1)){
  x_min <- x_params[1]
  x_max <- x_params[2]
  eps_mu <- eps_params[1]
  eps_sd <- eps_params[2]
  is_rejected <- replicate(n_rep, {
    x <- runif(n = n, min = x_min, max = x_max)
    eps<-rnorm(n = n, mean = eps_mu, sd = eps_sd)
    y<-1+ beta1*x + eps
    m<-lm(y ~ x)
    t<-(coef(m)["x"] - 0)/sqrt(vcov(m)["x", "x"])
    pval <-2*pt(-abs(t), df = m$df.residual)
    pval < alpha
  }) 
  mean(is_rejected)
}

#Size

n<-50
n_rep <- 1000
beta1 <- 0

size <- rejection_frequency(beta1, n=n, n_rep=n_rep)
cat("Empirical size:", size, "(n=50) \n")

# Power

n_beta<-40
beta1_list<-seq(-0.2,0.2,length.out=n_beta)

power <- sapply(beta1_list, rejection_frequency, n=n, n_rep=n_rep)

plot(beta1_list, power, type='l', ylab="Empirical power",
     xlab="Beta", main="Power w.r.t. beta")
abline(h=0.05, lty=2)

# Consistency
n_list <- c(50, 100, 1000)

power_mat <- sapply(n_list, function(n){sapply(beta1_list, rejection_frequency, n=n, n_rep=n_rep)})
colnames(power_mat) <- paste0("n = ", n_list)

matplot(beta1_list,power_mat,type='l', 
        col=c("darkblue", "darkgreen", "darkred"), ylab="Empirical power",
        xlab="Beta", lty=1, lwd=1.5,
        main="Power w.r.t. beta and sample size")
abline(h=0.05, lty=2)
legend("bottomright", legend = colnames(power_mat), col = c("darkblue", "darkgreen", "darkred"), lty = 1)

# Unbiasedness 

idx_beta0 <- beta1_list == 0

apply(power_mat[!idx_beta0,], 2, min)




