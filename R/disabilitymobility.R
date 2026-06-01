#' Disability mobility data
#'
#' Include disability and other demographic as well as mobility and trip categorical and numeric variables for data visualization and single table analysis.
#'
#' @format A data frame with 86521 rows (each row is a person) and 40 columns
#' \describe{
#'   \item{household_id}{Household identifier.}
#'   \item{person_id}{Person identifier.}
#'   \item{travel_disability}{How long does the respondent have a medical condition that makes it difficult to travel outside of home?}
#'   \item{sex}{Sex of the respondent.}
#'   \item{race}{Race of the respondent.}
#'   \item{hispanic_ethnicity}{Hispanic or Latino origin.}
#'   \item{nativity}{Born in United States.}
#'   \item{age}{Age of the respondent.}
#'   \item{education}{Educational attainment.}
#'   \item{self_rated_health}{Opinion of health.}
#'   \item{employment_status}{Primary activity in previous week.}
#'   \item{household_income}{Household income of the respondent.}
#'   \item{household_structure}{Count of household members.}
#'   \item{population_density}{Category of population density (persons per square mile) in the census block group of the households home location.}
#'   \item{urban_rural}{Household in urban or rural area.}
#'   \item{state}{Household state.}
#'   \item{driver_status}{Driver status.}
#'   \item{cane}{Does the respondent use a cane to aid their travel?}
#'   \item{manual_wheelchair}{Does the respondent use a manual wheelchair to aid their travel?}
#'   \item{crutches}{Does the respondent use a crutch to aid their travel?}
#'   \item{dog}{Does the respondent use a dog to aid their travel?}
#'   \item{motorized_wheelchair}{Does the respondent use a motorized wheelchair to aid their travel?}
#'   \item{scooter}{Does the respondent use a scooter to aid their travel?}
#'   \item{white_cane}{Does the respondent use a white cane to aid their travel?}
#'   \item{walker}{Does the respondent use a walker to aid their travel?}
#'   \item{other_accommodation}{Does the respondent use any other accommodation rather than those listed?}
#'   \item{yearly_miles_personally_driven}{Miles personally drive in all vehicles.}
#'   \item{count_of_public_transit_usage}{Count of public transit usage in last month.}
#'   \item{count_of_rideshare_app_usage}{Count of rideshare app usage in last month.}
#'   \item{count_of_bike_trips}{Count of bike trips in past week.}
#'   \item{count_of_walk_trips}{Count of walk trips in past week.}
#'   \item{count_of_online_delivery}{Count of times purchased online for delivery in last 30 days.}
#'   \item{avg_num_of_people_on_trip}{Average number of people on the respondent's trip including the respondent on the respondent's travel day. A travel day is a 24 hour day that starts at 4 am (local time) of the assigned travel day and ends at 3:59 am of the following day. The NHTS randomly assigns the travel days for one-seventh of the sample addresses to each day of the week and the remaining six-sevenths of the households to evenly across weekdays (Monday to Friday). The following variables are related to trip information on travel day.}
#'   \item{avg_trip_distance_in_miles}{Average trip distance in miles on the respondent's travel day.}
#'   \item{avg_trip_duration_in_minutes}{Average trip duration in minutes on the respondent's travel day.}
#'   \item{shopping_trip}{Whether having shopping trips on the respondent's travel day.}
#'   \item{social_recreational_trip}{Whether having social or recreational trips on the respondent's travel day.}
#'   \item{other_home_based_trip}{Whether having other home-based trips on the respondent's travel day.}
#'   \item{work_trip}{Whether having work trips on the respondent's travel day.}
#'   \item{other_non_home_based_trip}{Whether having other non home-based trips on the respondent's travel day.}
#' }
#' @source <https://nhts.ornl.gov/>
"disabilitymobility"
