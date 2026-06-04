# datasets are unchanged

    Code
      cat(format(tidytree::as_tibble(disabilitymobility)[1:3, 1:5])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 5
        household_id person_id travel_disability sex    race 
      1     30000007 03        No_disability     Female Black
      2     30000008 01        No_disability     Male   White
      3     30000012 01        No_disability     Female White

---

    Code
      nrow(disabilitymobility)
    Output
      [1] 86521

---

    Code
      ncol(disabilitymobility)
    Output
      [1] 40

