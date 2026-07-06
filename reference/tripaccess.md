# Tripaccess data

Include disability and other demographic as well as mobility and trip
categorical and numeric variables for data visualization and single
table analysis.

## Usage

``` r
tripaccess
```

## Format

A data frame with 86521 rows (each row is a person) and 40 columns

- household_id:

  Household identifier.

- person_id:

  Person identifier.

- travel_disability:

  How long does the respondent have a medical condition that makes it
  difficult to travel outside of home?

- sex:

  Sex of the respondent.

- race:

  Race of the respondent.

- hispanic_ethnicity:

  Hispanic or Latino origin.

- nativity:

  Born in United States.

- age:

  Age of the respondent.

- education:

  Educational attainment.

- self_rated_health:

  Opinion of health.

- employment_status:

  Primary activity in previous week.

- household_income:

  Household income of the respondent.

- household_structure:

  Count of household members.

- population_density:

  Category of population density (persons per square mile) in the census
  block group of the households home location.

- urban_rural:

  Household in urban or rural area.

- state:

  Household state.

- driver_status:

  Driver status.

- cane:

  Does the respondent use a cane to aid their travel?

- manual_wheelchair:

  Does the respondent use a manual wheelchair to aid their travel?

- crutches:

  Does the respondent use a crutch to aid their travel?

- dog:

  Does the respondent use a dog to aid their travel?

- motorized_wheelchair:

  Does the respondent use a motorized wheelchair to aid their travel?

- scooter:

  Does the respondent use a scooter to aid their travel?

- white_cane:

  Does the respondent use a white cane to aid their travel?

- walker:

  Does the respondent use a walker to aid their travel?

- other_accommodation:

  Does the respondent use any other accommodation rather than those
  listed?

- yearly_miles_personally_driven:

  Miles personally drive in all vehicles.

- count_of_public_transit_usage:

  Count of public transit usage in last month.

- count_of_rideshare_app_usage:

  Count of rideshare app usage in last month.

- count_of_bike_trips:

  Count of bike trips in past week.

- count_of_walk_trips:

  Count of walk trips in past week.

- count_of_online_delivery:

  Count of times purchased online for delivery in last 30 days.

- avg_num_of_people_on_trip:

  Average number of people on the respondent's trip including the
  respondent on the respondent's travel day. A travel day is a 24 hour
  day that starts at 4 am (local time) of the assigned travel day and
  ends at 3:59 am of the following day. The NHTS randomly assigns the
  travel days for one-seventh of the sample addresses to each day of the
  week and the remaining six-sevenths of the households to evenly across
  weekdays (Monday to Friday). The following variables are related to
  trip information on travel day.

- avg_trip_distance_in_miles:

  Average trip distance in miles on the respondent's travel day.

- avg_trip_duration_in_minutes:

  Average trip duration in minutes on the respondent's travel day.

- shopping_trip:

  Whether having shopping trips on the respondent's travel day.

- social_recreational_trip:

  Whether having social or recreational trips on the respondent's travel
  day.

- other_home_based_trip:

  Whether having other home-based trips on the respondent's travel day.

- work_trip:

  Whether having work trips on the respondent's travel day.

- other_non_home_based_trip:

  Whether having other non home-based trips on the respondent's travel
  day.

## Source

<https://nhts.ornl.gov/>

## Examples

``` r
if (require("tidyverse")) {
# Filtered to people who have a travel disability
tripaccess_disabled <- tripaccess |>
  filter(travel_disability != "No_disability")

# Summary statistics of public transit usage by disabled people who use a walker
tripaccess_disabled |>
  filter(walker == "True") |>
  group_by(travel_disability) |>
  summarize(public_transit_usage_median = median(count_of_public_transit_usage),
  public_transit_usage_mean = mean(count_of_public_transit_usage),
  public_transit_usage_sd = sd(count_of_public_transit_usage))
}
#> # A tibble: 3 × 4
#>   travel_disability                public_transit_usage…¹ public_transit_usage…²
#>   <chr>                                             <dbl>                  <dbl>
#> 1 6_months_or_less_disability                           0                   6.18
#> 2 Lifelong_disability                                   0                   7.78
#> 3 More_than_6_months_of_disability                      0                   5.09
#> # ℹ abbreviated names: ¹​public_transit_usage_median, ²​public_transit_usage_mean
#> # ℹ 1 more variable: public_transit_usage_sd <dbl>
```
