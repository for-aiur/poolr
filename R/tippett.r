
tippett <- function(p, adjust = "none", m, R, size = 10000, seed, type = 2, 
                    emp.loop = FALSE, emp.step, ...) {

  # checking whether the number of p-values match with the dimensions of R.
  if(!missing(R) && length(p) != nrow(R))
    stop("the number of p-values to be combined does not match with the dimensions of the correlation matrix provided as R.")
  
  # checking if dependence is accounted for when a correlation matrix is supplied.
  if(adjust == "none" && !missing(R))
    warning("although you specified a correlation matrix with argument R, you chose to assume independence with adjust == 'none'. If you want to account for dependence, please specify an adjustment method. See ?tippett for details.")
  
  # if the adjust is not given, it will be set to "none".
  if(missing(adjust))
    adjust <- "none"
  
  adjust <- match.arg(adjust, c("none", "nyholt", "liji", "gao", "galwey", "empirical"))
  
  k <- length(p)
  
  # if m is provided by the user, then we don't need to check the adjustment method.
  if(!missing(m)) {
    m <- m
    test_stat <- 1 - (1 - min(p))^m
    pooled_p <- test_stat
    adjust <- paste0("meff = ", m, " (user defined)")
    
    # warning the user if the user-defined m is larger than the number of p-values.
    if(m > k)
      warning("the user-defined effective number of test is larger than the number of p-values that were combined.")
  } else {
    if(adjust == "none") {
      test_stat <- 1 - (1 - min(p))^k
      pooled_p <- test_stat
      adjust <- "none"
    } else if (adjust %in% c("nyholt", "liji", "gao", "galwey")) {
      m <- meff(R = R, method = adjust)
      test_stat <- 1 - (1 - min(p))^m
      pooled_p <- test_stat
      adjust <- paste0("meff = ", m, " (", adjust, ")")
    } else if (adjust == "empirical") {
      # checking if the user wants to use a stepwise algorithm for empirical 
      # adjustment.
      if(!missing(emp.step)) {
        # checking if emp.step is a list.
        if(!is.list(emp.step))
          stop("emp.dist should be a list.")
        
        # checking if there are two vectors in the emp.step.
        if(!length(emp.step) == 2)
          stop("emp.dist should include two lists. Please see ?tippett.")
        
        # checking if the lengths of the vectors in the emp.step are correct.
        if(!(length(emp.step[[1]]) - length(emp.step[[2]])) %in% c(-1, 1))
          stop("the lengths of the vectors in emp.step are not correct. Please see ?tippett.")
        
        # checking if the vectors have names.
        if(is.null(names(emp.step))) {
          # if they don't have names, they will be named.
          names(emp.step)[which.max(unlist(lapply(emp.step, length)))] <- "size"
          names(emp.step)[which.min(unlist(lapply(emp.step, length)))] <- "thres"
        } else {
          # if the names of the vectors are not correct, they will be corrected.
          if(!all(names(emp.step) %in% c("size", "thres"))) {
            names(emp.step)[which.max(unlist(lapply(emp.step, length)))] <- "size"
            names(emp.step)[which.min(unlist(lapply(emp.step, length)))] <- "thres"
          }
        }
        
        # setting the seed before starting to generate sets to obtain mutually exclusive sets.
        if(!missing(seed))
          set.seed(seed)
        
        for(i in 1:length(emp.step$thres)) {
          size <- emp.step$size[i]
          emp_dist <- empirical(R = R, method = "tippett", type = type, 
                                size = size, emp.loop = emp.loop)
          
          test_stat_tmp  <- 1 - (1 - min(p))^k
          pooled_p_tmp  <- (sum(emp_dist <= test_stat_tmp) + 1) / (size + 1)
          
          if(pooled_p_tmp > emp.step$thres[i]) {
            test_stat <- test_stat_tmp
            pooled_p <- pooled_p_tmp
            adjust <- "empirical"
            ci <- as.numeric(binom.test(sum(emp_dist <= test_stat) + 1, size + 1)$conf.int)
            test_stat <- pooled_p
            break
          }
        }
        # if the threshold could not be achieved in the loop, then we are going
        # to use the largest sample size. 
        if(!exists("pooled_p")) {
          size <- tail(emp.step$size, n = 1)
          emp_dist <- empirical(R = R, method = "tippett", type = type, 
                                size = size, seed = seed, emp.loop = emp.loop)
          
          test_stat  <- 1 - (1 - min(p))^k
          pooled_p  <- (sum(emp_dist <= test_stat) + 1) / (size + 1)
          ci <- as.numeric(binom.test(sum(emp_dist <= test_stat) + 1, size + 1)$conf.int)
          test_stat <- pooled_p
          adjust <- "empirical"
        }
      } else {
        tmp <- list(...)
        
        # if an empirical distribution is not provided by the user, we will use 
        # empirical() to generate an empirical distribution.
        if(is.null(tmp$emp.dis)) {
          emp_dist <- empirical(R = R, method = "tippett", type = type, 
                                size = size, seed = seed, emp.loop = emp.loop)
          
        } else { # otherwise, the function will use the user-given empirical distribution.
          emp_dist <- tmp$emp.dist
        }
        
        test_stat <- 1 - (1 - min(p))^k
        pooled_p <- (sum(emp_dist <= test_stat) + 1) / (size + 1)
        ci <- as.numeric(binom.test(sum(emp_dist <= test_stat) + 1, size + 1)$conf.int)
        test_stat <- pooled_p
        adjust <- "empirical"
      }
    }
  }
  if(exists("ci")) {
    res <- list(p = pooled_p, ci = ci, test_stat = test_stat, adjust = adjust)
  } else {
    res <- list(p = pooled_p, test_stat = test_stat, adjust = adjust)
  }
  class(res) <- "combp"
  return(res)
}
