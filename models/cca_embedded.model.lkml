connection: "cca_embedded_looker"

# include all the views
include: "/views/**/*.view"

datagroup: cca_embedded_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cca_embedded_default_datagroup



explore: cook_hh_income_full {
  view_label: "Household Income"
  label: "Household Income"

  join: cook_county_census_tract {
    view_label: "Geographic Data"
    relationship: many_to_one
    type: left_outer
    sql_on: ${cook_hh_income_full.id_geography} = ${cook_county_census_tract.id_geometry} ;;
  }

  # join ndt to add median income column
  join: ndt_median_hh_income {
    relationship: many_to_one
    type: left_outer
    sql_on: 1=1 ;;
  }
}

# explore: cook_county_census_tract {}

# explore: cook_hh_income_tract_black {}

# explore: cook_hh_income_tract_total {}

# explore: cook_hh_income_tract_white {}
