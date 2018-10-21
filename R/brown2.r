brown2 <- function(R, ...) {
  
  # data frame for converting correlations to covariances
  brownCovs <- structure(list(rhos = c(-0.99, -0.98, -0.97, -0.96, -0.95, -0.94, -0.93, -0.92, -0.91, -0.9, -0.89, -0.88, -0.87, -0.86, -0.85, -0.84, -0.83, -0.82, -0.81, -0.8, -0.79, -0.78, -0.77, -0.76, -0.75, -0.74, -0.73, -0.72, -0.71, -0.7, -0.69, -0.68, -0.67, -0.66, -0.65, -0.64, -0.63, -0.62, -0.61, -0.6, -0.59, -0.58, -0.57, -0.56, -0.55, -0.54, -0.53, -0.52, -0.51, -0.5, -0.49, -0.48, -0.47, -0.46, -0.45, -0.44, -0.43, -0.42, -0.41, -0.4, -0.39, -0.38, -0.37, -0.36, -0.35, -0.34, -0.33, -0.32, -0.31, -0.3, -0.29, -0.28, -0.27, -0.26, -0.25, -0.24, -0.23, -0.22, -0.21, -0.2, -0.19, -0.18, -0.17, -0.16, -0.15, -0.14, -0.13, -0.12, -0.11, -0.1, -0.09, -0.08, -0.07, -0.06, -0.05, -0.04, -0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1),
                              covs = c(3.91479605897825, 3.83205935685214, 3.75074056778153, 3.67067930122923, 3.59178508508233, 3.51399790476864, 3.43727432374304, 3.36158111128572, 3.28689184259874, 3.21318489786612, 3.14044219707382, 3.06864835747488, 2.9977900896394, 2.92785583770892, 2.85883533111693, 2.79071948784668, 2.72350015838743, 2.65716999023168, 2.59172232014016, 2.52715107081244, 2.46345068307464, 2.40061604587827, 2.33864244301892, 2.27752551134803, 2.21726120191608, 2.15784574446495, 2.09927562143054, 2.04154754630385, 1.98465843177862, 1.92860539161983, 1.87338569563457, 1.81899678206564, 1.76543622912634, 1.71270174851689, 1.66079117731036, 1.60970246271133, 1.55943365859773, 1.50998291748303, 1.46134848362064, 1.41352868555891, 1.3665219297559, 1.32032670058197, 1.274941549604, 1.23036509830982, 1.18659602435417, 1.14363306763568, 1.10147502197182, 1.06012073388872, 1.01956909946772, 0.97981905945805, 0.94086960008641, 0.90271975036859, 0.86536858120456, 0.82881519758251, 0.79305874030262, 0.75809839097658, 0.72393336032859, 0.69056288896281, 0.6579862517543, 0.62620275091087, 0.59521171550729, 0.56501250705911, 0.5356045031968, 0.50698711369116, 0.47915977150018, 0.45212193259023, 0.42587306981084, 0.40041268660022, 0.37574029854582, 0.35185544894227, 0.32875769569476, 0.30644661720267, 0.28492181069801, 0.26418289052419, 0.24422948526159, 0.22506125685704, 0.20667786173517, 0.18907898119099, 0.17226431526291, 0.15623357840848, 0.14098650341389, 0.12652281985266, 0.11284230312543, 0.09994471394919, 0.08782984837638, 0.0764974983495, 0.06594748723031, 0.05617963953118, 0.04719379718479, 0.03898981135761, 0.03156755397469, 0.02492690463488, 0.01906775598728, 0.0139900197697, 0.00969360437748, 0.00617844900949, 0.00344450312301, 0.00149171255259, 0.00032005089554, -7.050058744e-05, 0.00032005089554, 0.00149171255258, 0.00344450312302, 0.00617844900949, 0.00969360437748, 0.0139900197697, 0.01906775598728, 0.02492690463489, 0.03156755397469, 0.03898981135761, 0.04719379718479, 0.05617963953118, 0.06594748723031, 0.07649749834951, 0.08782984837638, 0.09994471394919, 0.11284230312544, 0.12652281985266, 0.1409865034139, 0.15623357840849, 0.1722643152629, 0.18907898119099, 0.20667786173517, 0.22506125685704, 0.24422948526159, 0.26418289052419, 0.28492181069802, 0.30644661720267, 0.32875769569477, 0.35185544894227, 0.37574029854582, 0.40041268660023, 0.42587306981084, 0.45212193259023, 0.47915977150019, 0.50698711369116, 0.5356045031968, 0.56501250705911, 0.59521171550729, 0.62620275091087, 0.6579862517543, 0.69056288896281, 0.72393336032859, 0.75809839097659, 0.79305874030262, 0.82881519758251, 0.86536858120456, 0.90271975036858, 0.94086960008641, 0.97981905945806, 1.01956909946772, 1.06012073388872, 1.10147502197182, 1.14363306763567, 1.18659602435417, 1.23036509830982, 1.27494154960399, 1.32032670058196, 1.3665219297559, 1.41352868555891, 1.46134848362063, 1.50998291748303, 1.55943365859773, 1.60970246271134, 1.66079117731036, 1.71270174851688, 1.76543622912634, 1.81899678206564, 1.87338569563456, 1.92860539161982, 1.98465843177862, 2.04154754630384, 2.09927562143054, 2.15784574446496, 2.21726120191608, 2.27752551134803, 2.33864244301892, 2.40061604587827, 2.46345068307463, 2.52715107081244, 2.59172232014016, 2.65716999023168, 2.72350015838743, 2.79071948784668, 2.85883533111693, 2.92785583770892, 2.99779008963939, 3.06864835747488, 3.14044219707381, 3.21318489786613, 3.28689184259875, 3.36158111128572, 3.43727432374303, 3.51399790476865, 3.59178508508234, 3.67067930122923, 3.75074056778152, 3.83205935685214, 3.91479605897826, 4)),
                         .Names = c("rhos", "covs"), row.names = c(NA, -200L), class = "data.frame")
  
  # dimension checks
  if (!isSymmetric(R))
    stop("R is not symmetric.")
  
  # lower triangular part of R
  r <- R[lower.tri(R)]
  
  # round correlations to two decimals
  r <- round(r, 2)
  
  # replace -1 correlations with -.99
  r[r == -1] <- -0.99
  
  # convert correlations into covariances
  covs <- matrix(NA, nrow = nrow(R), ncol = ncol(R))
  covs[lower.tri(covs)] <- brownCovs[match(r, brownCovs$rho), 2]
  diag(covs) <- brownCovs$covs[brownCovs$rhos == 0]
  covs[upper.tri(covs)] <- t(covs)[upper.tri(covs)]
  
  # set diagonal of matrix to 4
  diag(covs) <- 4
  
  # return cov matrix
  return(covs)
  
}