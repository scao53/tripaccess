# Person data

Include disability, mobility, and other demographic categorical and
numeric variables.

## Usage

``` r
person
```

## Format

A data frame with 99564 rows (each row is a person) and 32 columns

- household_id:

  Household identifier. Use this variable to join the person dataset and
  the house dataset. Use both this variable and person_id to join the
  person dataset and the trip dataset.

- person_id:

  Person identifier. Use both this variable and household_id to join the
  person dataset and the trip dataset.

- travel_disability:

  How long the respondent has had a medical condition that makes it
  difficult to travel outside of home. Values include
  6_months_or_less_disability, More_than_6_months_of_disability,
  Lifelong_disability, and No_disability.

- sex:

  Sex of the respondent. Values include Male and Female.

- race:

  Race of the respondent. Values include White, Black, Asian, American
  Indian, Hawaiian/Pacific Islander, Multiracial, and Other.

- hispanic_ethnicity:

  Hispanic or Latino origin. Values include Hispanic and Non-Hispanic.

- nativity:

  Born in United States. Values include Yes and No.

- age:

  Age of the respondent. Filtered to ages 18 to 61.

- education:

  Educational attainment. Values include Less than a high school
  graduate, High school graduate or GED, Some college or associates
  degree, Bachelor's degree, and Graduate degree or professional degree.

- self_rated_health:

  Opinion of health. Values include Excellent, Very good, Good, Fair,
  and Poor.

- employment_status:

  Primary activity in previous week. Values include Employed and
  Unemployed.

- household_income:

  Household income. Values include Under \$10,000, \$10,000 to \$34,999,
  \$35,000 to \$74,999, \$75,000 to \$149,999, and \$150,000 and over.

- household_structure:

  Count of household members. Values include Lives alone and Does not
  live alone.

- population_density:

  Category of population density (persons per square mile) in the census
  block group of the household's home location. Values include 0-99,
  100-499, 500-999, 1,000-1,999, 2,000-3,999, 4,000-9,999,
  10,000-24,999, and 25,000 and over.

- urban_rural:

  Household in urban or rural area. Values include Urban and Rural.

- state:

  Household state. Includes the 50 states and Washington, DC.

- driver_status:

  Driver status. Values include Drives and Does not drive.

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

  Derived from the original W_NONE variable. Indicates whether no listed
  mobility aid was reported.

- yearly_miles_personally_driven:

  Miles personally driven in all vehicles. Values range from 0 to
  200000.

- count_of_public_transit_usage:

  Count of public transit usage in last month. Values range from 0 to
  30.

- count_of_rideshare_app_usage:

  Count of rideshare app usage in last month. Values range from 0 to 99.

- count_of_bike_trips:

  Count of bike trips in past week. Values range from 0 to 99.

- count_of_walk_trips:

  Count of walk trips in past week. Values range from 0 to 200.

- count_of_online_delivery:

  Count of times purchased online for delivery in last 30 days. Values
  range from 0 to 99.

## Source

<https://nhts.ornl.gov/>

## Examples

``` r
if (require("tidyverse")) {
# Summary statistics of public transit use by travel disability status
transit_summary <- person |>
  group_by(travel_disability) |>
  summarize(
    people = n(),
    public_transit_users = sum(count_of_public_transit_usage > 0),
    public_transit_use_prop = mean(count_of_public_transit_usage > 0),
    public_transit_usage_median = median(count_of_public_transit_usage),
    public_transit_usage_mean = mean(count_of_public_transit_usage),
    public_transit_usage_sd = sd(count_of_public_transit_usage)
  )
# Test whether public transit use differs by travel disability status
prop.test(
  x = transit_summary$public_transit_users,
  n = transit_summary$people
)
}
#> 
#>  4-sample test for equality of proportions without continuity correction
#> 
#> data:  transit_summary$public_transit_users out of transit_summary$people
#> X-squared = 184.91, df = 3, p-value < 2.2e-16
#> alternative hypothesis: two.sided
#> sample estimates:
#>    prop 1    prop 2    prop 3    prop 4 
#> 0.1486200 0.2411290 0.1702986 0.1312206 
#> 
```
