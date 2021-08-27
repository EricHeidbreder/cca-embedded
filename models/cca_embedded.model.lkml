connection: "cca_embedded_looker"

# include all the views
include: "/views/**/*.view"

datagroup: cca_embedded_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cca_embedded_default_datagroup

explore: cook_hh_income_tract_black {}

explore: cook_hh_income_tract_total {}

explore: cook_hh_income_tract_white {}

explore: cook_hh_income_full {
  join: cook_county_census_tract {
    relationship: many_to_one
    type: left_outer
    sql_on: ${cook_hh_income_full.id_geography} = ${cook_county_census_tract.id_geometry} ;;
  }
}

explore: cook_county_census_tract {}
