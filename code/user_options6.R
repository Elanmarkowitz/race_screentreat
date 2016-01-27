############################################################################
## File Name: user_options.R

## File Purpose: Specify inputs for run_file.R
## Author: Jeanette Birnbaum
## Date: 10/14/2014
## Edited on: 

## Additional Comments: 
#############################################################################

############################################################
# Establish model version if this file is not being called 
# by a wrapper
############################################################
# Use if not using a wrapper
if (!'using_wrapper'%in%ls()) {
    warning('Empyting the workspace')
    rm(list=ls())
    
    # SET THE FOLLOWING 4 INPUTS IF NOT USING WRAPPER
    model_type <- 'race_screentreat'                                # model to use
    model_version <- 'race_example'                                 # name of specific run
    rootdir <- 'C:/Users/Elan/Documents/GitHub'                     # directory containing model (race_screentreat)
    input_data_file <- 'input_temp_ERHER2_withAI_Ynames_Races.csv'  # input file name, stored in the examples subfolder of the model directory
    
    setwd(file.path(rootdir, model_type, 'code'))
    source('no_wrapper_lib.R')
    base_path <- file.path(rootdir, model_type, 'examples')
    set_up_no_wrapper(model_type, model_version, rootdir, input_data_file, base_path)
    treat_file = file.path(base_path, input_data_file)
}

############################################################
# Input data files
############################################################
if(!'treat_file'%in%ls())
  treat_file = file.path(base_path, model_version, 'input', 'input.csv') 
incidence_file = file.path(rootdir, 'race_screentreat/data/bc_1975-1979_incidence_by_race.csv')
library_file = file.path(rootdir, 'race_screentreat/code/screentreat_library.R')
life_table_file = '' #specify a file if you do not wish to use cantrance defaults

############################################################
# Simulation features
############################################################
nsim = 2
times = c(10,25)
pop_size = 10000
study_year = 2000

############################################################
# Population features
############################################################

pop_chars = 
    list(age=data.frame(age=c(50), prop=c(1)),
         male=data.frame(male=c(0), prop=c(1)))

# Is age in the data age at clinical incidence? 
# If not, provide incidence table
age_is_ageclin = FALSE
if (!age_is_ageclin) {
    inc_table = read.csv(incidence_file, header=TRUE, 
                         stringsAsFactors=FALSE)
}

############################################################
# Screening, treatment and cancer mortality
############################################################

# Stage shift for each race
HR_advanced <- c(
  White = 0.85,
  Black = 0.85
)


# within stage effects for each race
instage_screen_benefit_early <- c(
  White=1,
  Black=1
)

instage_screen_benefit_advanced <- c(
  White=1,
  Black=1
)


# Add lead time? Default is undefined or FALSE
# If true, add mean lead time in years
lead_time = FALSE
if (lead_time) lt_mean = (40/12)

# Treatment HRs and distributions by subgroup-stage
treat_chars = read.csv(treat_file, header=TRUE, 
                        stringsAsFactors=FALSE)

# Survival distribuion: exponential or weibull?
surv_distr = 'exponential'

# Baseline mortality rates and population proportions for each race
# by subgroup-stages. Subgroup stages specified here must
# match those given in the scrtrt_file
control_notreat <- list(
    White = data.frame(stage=c(rep('Early',4),     # The number must match the number of subgroups
                               rep('Advanced',4)), # The number must match the number of subgroups
                       subgroup=rep(c('ER+HER2+',  
                                      'ER+HER2-',
                                      'ER-HER2+',
                                      'ER-HER2-'),2),
                       mortrate=c(rep(.01992,4),rep(0.10693, 4)), 
                       prop=c(0.04, 0.38, 0.02, 0.06,    # proportion of population in each subcategory
                              0.06, 0.34, 0.03, 0.07)),
    
    Black = data.frame(stage=c(rep('Early',4),     # The number must match the number of subgroups
                               rep('Advanced',4)), # The number must match the number of subgroups
                       subgroup=rep(c('ER+HER2+',
                                      'ER+HER2-',
                                      'ER-HER2+',
                                      'ER-HER2-'),2),
                       mortrate=c(rep(.01992,4),rep(0.10693, 4)),
                       prop=c(0.04, 0.38, 0.02, 0.06,
                              0.06, 0.34, 0.03, 0.07))
)



############################################################
# Other-cause mortality
############################################################

ocd_HR = 1

############################################################
# Run model
############################################################

source(file.path(rootdir, 'race_screentreat/code/run_file.R'))

