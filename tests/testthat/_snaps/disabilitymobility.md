# datasets are unchanged

    Code
      cat(format(tidytree::as_tibble(disabilitymobility)[1:3, c("household_id",
        "person_id")])[-3L], sep = "\n")
    Output
      # A tibble: 3 x 2
        household_id person_id
      1     30000007 03       
      2     30000008 01       
      3     30000012 01       

