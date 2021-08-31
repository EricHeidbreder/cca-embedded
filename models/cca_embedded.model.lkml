connection: "cca_embedded_looker"

# include all the views
include: "/views/**/*.view"

datagroup: cca_embedded_default_datagroup {
  # sql_trigger: CURRENT_DATE;;
  max_cache_age: "24 hours"
}

persist_with: cca_embedded_default_datagroup

explore: cook_hh_income_full {
  view_label: "Household Income"
  label: "Household Income"

  query: year_by_year_comparison {
    label: "Median Income Year by Year"
    description: "Explore Year by Year stats using the filters to select your two years to compare."
    dimensions: [race]
    measures: [median_hh_income_comparison_year, median_hh_income_starting_year]
    pivots: [race]
    filters: [
      cook_hh_income_full.comparison_year: "2017",
      cook_hh_income_full.starting_year: "2018"
    ]
  }

  join: cook_county_census_tract {
    view_label: "Geographic Data"
    relationship: many_to_one
    type: left_outer
    sql_on: ${cook_hh_income_full.id_geography} = ${cook_county_census_tract.id_geography} ;;
  }

  # join ndt to add median income column
  join: ndt_median_hh_income {
    relationship: many_to_one
    type: left_outer
    sql_on: 1=1 ;;
  }

  join: ndt_income_lag_1y {
    relationship: many_to_one
    view_label: "Household Income"
    type: left_outer
    sql_on: ${cook_hh_income_full.id_year} = ${ndt_income_lag_1y.id_year}
          and ${cook_hh_income_full.id_race} = ${ndt_income_lag_1y.id_race}
          and ${cook_hh_income_full.id_geography} = ${ndt_income_lag_1y.id_geography} ;;
    fields: [ndt_income_lag_1y.avg_income_lag_1y]
  }

}

# explore: cook_county_census_tract {}

# explore: cook_hh_income_tract_black {}

# explore: cook_hh_income_tract_total {}

# explore: cook_hh_income_tract_white {}
