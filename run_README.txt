
1) Setting up a new model

- Open code/wrapper.R and fill out model description
	* Specify user_options_file, stored in screentreat/code
	* Specify input_data_file, stored in screentreat/examples

- open user options file and set model options
	* change model_version in the top section to reflect 
		what you put in the wrapper
	* if making a small modification to another version, vimdiff this file
		with the user_options.R file from that one 
		(stored in examples/[version]/input) to make sure everything
		else is indeed the same

- Open input data file and fill out treatment info/make sure it's the right one

For an example of a data file with races, look at 
examples/input_temp_ERHER2_withAI_Ynames_Races.csv

Subgroups can be set to any grouping but must match the subgroups in the user_options file.

Races can be any set of populations but must match the races used in user_options file.

The columns of the data file must be:
subgroups: The subgroups for the trial
stage: must be 'Early' and 'Advanced'
tx: The treatments. Every treatment should have a row corresponding to each subgroup-stage pair.
HR_[Race]: At least 1 column containing the treatment HR for that race. [Race] should be replaced by the name of the race.
Prop_[Race]_[Trial]: At least 1 column. Gives the proportion of each subgroup-stage pair that receives a given treatment. [Race] should match a [Race] from the HR columns. [Trial] is just the name for the trial (can be the same as [Race]).

Currently unable to specify differnt other cause death rates.

- Source wrapper.R to set up (run=FALSE) or set up and run (run=TRUE) the model


2) Re-running the model with changes

- Manually edit version_guide.csv (within screentreat) and model_info.csv (within the screentreat/examples/[model] folder)
- Rerun model using 1 of 2 options:

* OPTION 1 (preferred, I think)
- Edit the user_options.R file that is stored within screentreat/examples/[model]/input
- If necessary, edit the input.csv file stored in that same folder
- Then source that file to re-run model

* OPTION 2 
- Edit code/user_options.R, making sure the model_version variable at the top is correct
- Source code/wrapper.R to re-run the model

* DO NOT:
- Edit code/user_options.R and then source it. This doesn't update the code stored within the model folder, so they get out of sync.