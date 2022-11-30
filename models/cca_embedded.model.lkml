connection: "cca_embedded_looker"

# include all the views
include: "/views/**/*.view"

datagroup: cca_embedded_default_datagroup {
  sql_trigger: SELECT 1 ;;
}

map_layer: census_tract {
  file: "/map_layers/CookCountyCensusTract.json"
  format: topojson
  label: "Census Tract"
  # property_key: "GEOID"
  property_label_key: "NAMELSAD"
}

persist_with: cca_embedded_default_datagroup

explore: cook_hh_income_full {
  view_label: "Household Income"
  label: "Household Income"

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
    fields: [ndt_income_lag_1y.pct_change_from_last_year, ndt_income_lag_1y.med_income_lag_1y]
  }

}
