##############################################################
## set_up_no_wrapper
##############################################################

set_up_no_wrapper = function #Creates necessary files and directories
(type, #model type
 name, #name for this current model
 root, #root directory
 input,#input data file name
 base  #base path
){
  # create directories
  dir.create(file.path(base, name))
  dir.create(file.path(base, name, 'input'))
  dir.create(file.path(base, name, 'output'))
  
  #copy data
  file.copy(file.path(base, input),
            file.path(base, name, 'input', 'input.csv'),
            overwrite=TRUE)
  file.copy(file.path(root, type, 'code', 'run_file.R'),
            file.path(base, name, 'input', 'run_file.R'),
            overwrite=TRUE)
}

