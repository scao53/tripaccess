# datasets are unchanged

    Code
      cat(format(tidytree::as_tibble(tripaccess)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id person_id travel_disability sex    race 
      1     30000007 03        No_disability     Female Black
      2     30000008 01        No_disability     Male   White
      3     30000012 01        No_disability     Female White

---

    Code
      nrow(tripaccess)
    Output
      [1] 86521

---

    Code
      ncol(tripaccess)
    Output
      [1] 41

---

    Code
      cat(format(tidytree::as_tibble(person)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id person_id travel_disability sex    race 
      1     30000007 03        No_disability     Female Black
      2     30000008 01        No_disability     Male   White
      3     30000008 02        No_disability     Female White

---

    Code
      nrow(person)
    Output
      [1] 99564

---

    Code
      ncol(person)
    Output
      [1] 32

---

    Code
      cat(format(tidytree::as_tibble(house)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id region      number_drivers count_household_memb~1 number_vehicles
      1     30000007 South Atla~              3                      3               5
      2     30000008 East North~              2                      2               4
      3     30000012 Middle Atl~              1                      1               2
      # i abbreviated name: 1: count_household_members

---

    Code
      nrow(house)
    Output
      [1] 129695

---

    Code
      ncol(house)
    Output
      [1] 9

---

    Code
      cat(format(tidytree::as_tibble(trip)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id person_id trip_purpose          gas_price num_of_people_on_trip
      1     30000007 01        other_home_based_trip      228.                     1
      2     30000007 01        other_home_based_trip      228.                     1
      3     30000007 02        work_trip                  228.                     1

---

    Code
      nrow(trip)
    Output
      [1] 921590

---

    Code
      ncol(trip)
    Output
      [1] 8

