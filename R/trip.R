#' Trip data
#'
#' Include trip related categorical and numeric variables.
#'
#' @format A data frame with 921590 rows (each row is a trip) and 8 columns
#' \describe{
#'   \item{household_id}{Household identifier. Use both this variable and person_id to join the trip dataset and the person dataset. Use this variable to join the trip dataset and the house dataset.}
#'   \item{person_id}{Person identifier. Use both this variable and household_id to join the trip dataset and the person dataset.}
#'   \item{trip_purpose}{Generalized purpose of trip on travel day. A travel day is a 24-hour day that starts at 4:00 a.m. (local time) of the assigned travel day and ends at 3:59 a.m. of the following day. The NHTS randomly assigns the travel days for one-seventh of the sample addresses to each day of the week and the remaining six-sevenths of the households to evenly across weekdays (Monday-Friday).}
#'   \item{gas_price}{Price of gasoline, in cents, on respondent's travel day.}
#'   \item{num_of_people_on_trip}{Number of people on trip including respondent on respondent's travel day.}
#'   \item{trip_miles}{Trip distance in miles on respondent's travel day, derived from route geometry returned. Google Maps was used for routing the shortest path for motorized travel on the road network. Non-motorized modes, like walk and bike, had the shortest path calculated using network routes paths.}
#'   \item{trip_duration}{Trip duration in minutes on respondent's travel day.}
#'   \item{trip_miles_personally_driven_vehicle}{Trip distance in miles for personally driven vehicle trips on respondent's travel day. -1 = Appropriate skip.}
#' }
#' @source <https://nhts.ornl.gov/>
#' @examples
#' if (require("tidyverse")) {
#' # Filtered to shorter trips for a clearer introductory visualization
#' short_trips <- trip |>
#'   filter(trip_miles <= 50,
#'          trip_duration <= 180)
#'
#' # Filtered to trips with positive distance and duration
#' positive_distance_trips <- short_trips |>
#'   filter(trip_miles > 0,
#'          trip_duration > 0)
#'
#' # Fit a simple linear regression model
#' duration_miles_model <- lm(trip_duration ~ trip_miles,
#'                            data = positive_distance_trips)
#' summary(duration_miles_model)
#'
#' # Correlation between trip distance and trip duration
#' cor(positive_distance_trips$trip_miles, positive_distance_trips$trip_duration)
#' }
"trip"
