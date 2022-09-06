
library(plot3D)

location <- "/home/thomas/Desktop/JSR/JSR---GA---Analysis/GA_analysis/R"
setwd(location)

initial_states <- read.csv(file = "../results/initial_states.csv")

all_projects <- c(initial_states$Project)
projects <- c("exp4j", "commons-cli", "commons-csv", "minimal-json", "java-tuple", "json-simple", "confucius", "ascii-table")

#dataframe for initial states
project_states <- data.frame(matrix(ncol = 5, nrow = 0))
colnames(project_states) <- c('ID', 'Project', '#TC', "Mutationscore", "Line Coverage")

#dataframe for rts states
rts_states <- data.frame(matrix(ncol = 15, nrow = 0))
colnames(rts_states) <- c('ID', 'Project', 
                         'max. #TCs', 'min. #TCs', "avg. #TCs",
                         'max. RF', 'min. RF', "avg. RF",
                         'max. Execution Time', 'min. Execution Time', "avg. Execution Time", "total Time",
                         'max. Mutationscore', 'min. Mutationscore', "avg. Mutationscore"
)

#evaluation over all projects
rts_states_summary <- data.frame(Crossoverrate = double(121), 
                                Mutationrate = double(121), 
                                "RF - Ranking" = double(121), 
                                "Mutation - Ranking" = double(121),
                                "Execution Time - Ranking" = double(121),
                                "RF & Mutation - Ranking" = double(121), 
                                "Overall - Ranking" = double(121)
)

project_id <- 0
for (project_name in all_projects)
{
  project_id <- project_id + 1
  
  ################### filter relevant data ######################################################################
  ts_size = initial_states[initial_states$Project == project_name, "TS"]
  initial_mutationscore = round(initial_states[initial_states$Project == project_name, "Mutationscore"], digits=3)
  initial_line_coverage = round(initial_states[initial_states$Project == project_name, "Line.Coverage"], digits=3)
  ################### add row ############ ######################################################################
  project_states[nrow(project_states) + 1,] = c(project_id, project_name, ts_size, initial_mutationscore, initial_line_coverage)
}

project_id <- 0
for (project_name in projects)
{
  project_id <- project_id + 1
  
  subFolder <- project_name
  subPath <- file.path(location, subFolder)
  
  dir.create(subPath, showWarnings = FALSE)
  
  setwd(location)
  project <- read.csv(file = paste("../results/",project_name,"_rts_states.csv", sep = "", collapse = ""))
  
  mutation_score <- project$Mutation.Score
  
  ###################  statistical values  ######################################################################
  max_mutation <- round(max(mutation_score), digits=3)
  min_mutation <- round(min(mutation_score), digits=3)
  mean_mutation <- round(mean(mutation_score), digits=3)
  
  max_scores <- subset(project, Mutation.Score == max(mutation_score))
  min_scores <- subset(project, Mutation.Score == min(mutation_score))
  
  
  #sd_mutation <- sd(mutation_score)
  
  min_rts <- round(min(project$RTS), digits=3)
  max_rts <- round(max(project$RTS), digits=3)
  mean_rts <- round(mean(project$RTS), digits=3)
  
  project_rf <- c((project$TS - project$RTS) / project$TS)
  min_rf <- round(min(project_rf), digits=3)
  max_rf <- round(max(project_rf), digits=3)
  mean_rf <- round(mean(project_rf), digits=3)
  
  project_time <- project$Time
  min_time <- round(min(project_time), digits=3)
  max_time <- round(max(project_time), digits=3)
  mean_time <- round(mean(project_time), digits=3)
  
  time_sum <- sum(project_time)
  total_time_sec <- round(time_sum, digits=3)
  total_time_min <- round(time_sum / 60, digits=3)
  total_time_h <- round(total_time_min / 60, digits=3)
  
  total_time <- c(time_sum%/%3600, (time_sum%%3600)%/%60, round((time_sum%%3600)%%60, digits = 3))
  hours_string <- paste(total_time[1],"h", sep = "", collapse = "")
  minutes_string <- paste(total_time[2],"m", sep = "", collapse = "")
  seconds_string <- paste(total_time[3],"sec", sep = "", collapse = "")
  
  total_time_string <- paste(hours_string,minutes_string,seconds_string, sep = " ", collapse = "")
  
  count_rts <- subset(project, RTS == min_rts)
  
  ################### for plotting ##############################################################################
  axis_interval <- c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
  
  setwd(subPath)
  
  mutation <- matrix(mutation_score, 11, byrow = TRUE)
  
  file_name = paste("./",project_name,"_mutationscore.pdf", sep = "", collapse = "")
  pdf(file = file_name, paper = "A4r")
  
  mutation3D <- persp3D(z = mutation, x = axis_interval, y=axis_interval, theta = 135, phi = 35, inttype = 2, 
                        ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "Mutation Score",
                        border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.6, nticks = 11,
                        cex.axis = 1, cex.lab = 1, clab = "Mutation Score",  colkey = list(side = 2, length = 0.6),
                        bty = "b2", main = paste(project_name, "Mutation Score", sep = " - "))
  dev.off()
  
  
  execution_time <- matrix(project$Time, 11, byrow = TRUE)
  
  file_name = paste("./",project_name,"_executiontime.pdf", sep = "", collapse = "")
  pdf(file = file_name, paper = "A4r")
  
  time3D <- persp3D(z = execution_time, x = axis_interval, y=axis_interval, theta = 135, phi = 35, inttype = 2, 
                    ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "Time in sec",
                    border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.8, nticks = 11,
                    cex.axis = 1, cex.lab = 1, clab = "Time in sec",  colkey = list(side = 2, length = 0.6),
                    bty = "b2",  main = paste(project_name, "Execution Time", sep = " - "))
  dev.off()
  
  
  reduction_factor <-  matrix(round(c((project$TS - project$RTS) / project$TS), digits=3), 11, byrow = TRUE)
  
  file_name = paste("./",project_name,"_reductionfactor.pdf", sep = "", collapse = "")
  pdf(file = file_name, paper = "A4r")
  
  reduction3D <- persp3D(z = reduction_factor, x = axis_interval, y=axis_interval, theta = 135, phi = 10, inttype = 2, 
                         ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "RF",
                         border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.5, nticks = 11,
                         cex.axis = 1, cex.lab = 1, clab = "Reduction Factor",  colkey = list(side = 2, length = 0.6),
                         bty = "b2",  main = paste(project_name, "Reduction Factor", sep = " - "))
  dev.off()
  
  ################### create data frame for evaluation ###########################################################
  
  rts_states[nrow(rts_states) + 1,] = c(project_id, project_name, 
                                      max_rts, min_rts, mean_rts, 
                                      max_rf, min_rf, mean_rf,
                                      max_time, min_time, mean_time, total_time_string,
                                      max_mutation, min_mutation, mean_mutation
  )
  
  rts_states_summary$Crossoverrate <- c(project$Crossoverrate)
  rts_states_summary$Mutationrate <- c(project$Mutationrate)
  rts_states_summary$RF...Ranking <- c(rank(-project_rf) + rts_states_summary$RF...Ranking)
  rts_states_summary$Mutation...Ranking <- c(rank(-mutation_score) + rts_states_summary$Mutation...Ranking)
  rts_states_summary$Execution.Time...Ranking <- c(rank(project_time) + rts_states_summary$Execution.Time...Ranking)
  rts_states_summary$RF...Mutation...Ranking <- c(rts_states_summary$RF...Ranking + rts_states_summary$Mutation...Ranking)
  rts_states_summary$Overall...Ranking <- c(rts_states_summary$RF...Ranking + rts_states_summary$Mutation...Ranking + rts_states_summary$Execution.Time...Ranking)
}

rts_states_summary$RF...Ranking <- c(rank(rts_states_summary$RF...Ranking))
rts_states_summary$Mutation...Ranking <- c(rank(rts_states_summary$Mutation...Ranking))
rts_states_summary$Execution.Time...Ranking <- c(rank(rts_states_summary$Execution.Time...Ranking))
rts_states_summary$RF...Mutation...Ranking <- c(rank(rts_states_summary$RF...Mutation...Ranking))
rts_states_summary$Overall...Ranking <- c(rank(rts_states_summary$Overall...Ranking))

######################################### export csv files ######################################################
summaryFolder <- "summary"
summaryPath <- file.path(location, summaryFolder)

dir.create(summaryPath, showWarnings = FALSE)
setwd(summaryPath)
write.csv(rts_states, "./rts_states_projects.csv", row.names = FALSE)
write.csv(rts_states_summary, "./rts_states_evaluation.csv", row.names = FALSE)
write.csv(project_states, "./initial_project_states.csv", row.names = FALSE)

######################################### export summary plots ##################################################
mutation_summary <- matrix(1- ((rts_states_summary$Mutation...Ranking -1)/121), 11, byrow = TRUE)

file_name = "./summary_mutationscore.pdf"
pdf(file = file_name, paper = "A4r")

mutation3D <- persp3D(z = mutation_summary, x = axis_interval, y=axis_interval, theta = 135, phi = 35, inttype = 2, 
                      ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "Mutation Score",
                      border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.6, nticks = 11,
                      cex.axis = 1, cex.lab = 1, clab = "Rating",  colkey = list(side = 2, length = 0.6),
                      bty = "b2", main = "Mutation Score - Summary")
dev.off()


execution_time_summary <- matrix(1- ((rts_states_summary$Execution.Time...Ranking -1)/121), 11, byrow = TRUE)

file_name = "./summary_executiontime.pdf"
pdf(file = file_name, paper = "A4r")

time3D <- persp3D(z = execution_time_summary, x = axis_interval, y=axis_interval, theta = 45, phi = 35, inttype = 2, 
                  ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "Time Score",
                  border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.8, nticks = 11,
                  cex.axis = 1, cex.lab = 1, clab = "Rating",  colkey = list(side = 2, length = 0.6),
                  bty = "b2",  main = "Execution Time - Summary")
dev.off()


reduction_factor_summary <-  matrix(1- ((rts_states_summary$RF...Ranking -1)/121), 11, byrow = TRUE)

file_name = "./summary_reductionfactor.pdf"
pdf(file = file_name, paper = "A4r")

reduction3D <- persp3D(z = reduction_factor_summary, x = axis_interval, y=axis_interval, theta = -45, phi = 25, inttype = 2, 
                       ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "RF Score",
                       border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.5, nticks = 11,
                       cex.axis = 1, cex.lab = 1, clab = "Rating",  colkey = list(side = 2, length = 0.6),
                       bty = "b2",  main = "Reduction Factor - Summary")
dev.off()


overall_score <-  matrix(1- ((rts_states_summary$Overall...Ranking -1)/121), 11, byrow = TRUE)

file_name = "./summary_parameter_ranking.pdf"
pdf(file = file_name, paper = "A4r")

reduction3D <- persp3D(z = overall_score, x = axis_interval, y=axis_interval, theta = 45, phi = 15, inttype = 2, 
                       ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "RTS Score",
                       border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.5, nticks = 11,
                       cex.axis = 1, cex.lab = 1, clab = "Rating",  colkey = list(side = 2, length = 0.6),
                       bty = "b2",  main = "Parameter Rating")
dev.off()

overall_score_without_time <-  matrix(1 - ((rts_states_summary$RF...Mutation...Ranking -1) /121), 11, byrow = TRUE)

file_name = "./summary_parameter_ranking_without_time.pdf"
pdf(file = file_name, paper = "A4r")

reduction3D <- persp3D(z = overall_score_without_time, x = axis_interval, y=axis_interval, theta = 125, phi = 25, inttype = 2, 
                       ylab = "Mutation Rate", xlab = "Crossover Rate", zlab = "RTS Score",
                       border = "black", resfac = 5, axes = TRUE, ticktype="simple", expand = 0.4, nticks = 11,
                       cex.axis = 1, cex.lab = 1, clab = "Rating",  colkey = list(side = 2, length = 0.6),
                       bty = "b2",  main = "Parameter Rating (without Time)")
dev.off()



setwd(location)

