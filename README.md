# Glass Calc and Composition Generator

Each script and its function are listed below:
Composition_generator_120624.R -> code that generates many combinations of compositions based on specific inputs and then stores only those that add up to 100. I would kindly like to thank Chat GPT for its help in generating this code as my version was going to take 700,000 years.
Glass_Calc R.R -> A script that runs a wide array of other subfunctions for selected compositions
Glass_Calc_Function.R <- A function that takes in comp_wt and performs Glass_Calc_R The format needs to be: Each col is an individual composition titled wt_# Each row is an oxide (usually weight fraction)

BulkFiltering_stage1_060724.R -> This script is designed to be fed the input of Composition_generator_120624.R It then filters our compositions that dont meet certain cryteria such as: A given ratio between certain oxides
BulkFiltering_stage2_080724.R -> Takes an input from BulkFiltering_stage1_060724.R and performs additional filtering

Calc_16.R -> Subfunction: A function that takes in a df of oxide percentages and  returns the  ratio: Al2O3/(Na2O+Li2O+CaO)
DC_calc.R -> Subfunction: A script that takes in the required oxide weight percentages and returns difference based on correlation or DC
ND_calc.R -> Subfunction: function that will take in df with two columns the first includes oxide list, the second contains wt% the ratio ND = SiO2/(SiO2+Na2O+Al2O3) is calculated
OB_calc.R -> Subfunction: function that will take in df with two columns the first includes oxide list, the second contains mol% the OB is then calculated in a loop
SM_calc.R -> Subfunction: function that takes in a df with 2 columns one contains oxide list and one cotnains wt% it will then calculate SM value and return in wt%
SM_maths.R -> Subfunction: Function that takes in all the parameters required to calculate SM and then calculates SM. Can be used for both optimised and conservative.

oxide2elem.R -> Subfunction: A script that takes in an oxide and returns individual elements as well as returning stats about it required in other scripts
extract_component_value.R -> function that takes in a component name (such as an oxide) and a df with 2 columns one contains oxide list and one cotnains wt% or mol% as required. it will then return the w% or mol% of the corresponding oxide or altenratively 0 if not present
wt2mol.R -> Subfunction: function that takes in a df with 2 columns one contains oxide list and one cotnains wt% it will spit out similar df containing mol%

## Installation

Download and run any of the main functions with correct input in R. The subfunctions are simply called by the main programs as required

## Usage
Requires correct input usually a csv with col: named "Composition" containing a glass making oxide and subsequent cols named wt_1,wt_2 etc...
All .csv have been excluded but some are required for functionality. These have been added to Required CSVs.rar and need to be unzipped, name unchanged.

## License

At this point no licence, please do not re-use as I am uploading to github for referencing purposes.

## Contact

Jack Cornwall - hello@jackcornwall.co.uk or j.cornwall@shu.ac.uk