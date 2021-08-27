# If necessary, uncomment the line below to include explore_source.

# include: "cca_embedded.model.lkml"

view: ndt_median_hh_income {
  derived_table: {
    explore_source: cook_hh_income_full {
      column: median_hh_income_by_race {}
      bind_all_filters: yes
    }
  }

  dimension: median_hh_income_by_race {
    label: "Household Income Median Household Income by Race"
    value_format: "$#,##0"
    type: number
  }
}
