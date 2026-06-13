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
      [1] 40

---

    Code
      cat(format(tidytree::as_tibble(house)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id region number_drivers count_household_members number_vehicles
      1     30000007 05                  3                       3               5
      2     30000008 03                  2                       2               4
      3     30000012 02                  1                       1               2

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
         HOUSEID PERSONID TDTRPNUM STRTTIME ENDTIME
      1 30000007 01       01       1000     1015   
      2 30000007 01       02       1510     1530   
      3 30000007 02       01       0700     0900   

---

    Code
      nrow(trip)
    Output
      [1] 923572

---

    Code
      ncol(trip)
    Output
      [1] 115

