#' House data
#'
#' Include household characteristics categorical and numeric variables.
#'
#' @format A data frame with 129695 rows (each row is a household) and 9 columns
#' \describe{
#'   \item{household_id}{Household identifier. Use this variable to join the house dataset and the person dataset as well as join the house dataset and the trip dataset.}
#'   \item{region}{2010 Census division classification for the respondent's home address.}
#'   \item{number_drivers}{Number of drivers in household.}
#'   \item{count_household_members}{Count of household members.}
#'   \item{number_vehicles}{Count of household vehicles.}
#'   \item{household_life_cycle}{Life Cycle classification for the household, derived by attributes pertaining to age, relationship, and work status.}
#'   \item{count_adult_household_members}{Count of adult household members at least 18 years old.}
#'   \item{number_workers}{Number of workers in household.}
#'   \item{count_young_child}{Count of persons with an age between 0 and 4 in household.}
#' }
#' @source <https://nhts.ornl.gov/>
"house"
