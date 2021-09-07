# If necessary, uncomment the line below to include explore_source.
# include: "cca_embedded.model.lkml"

view: ndt_income_lag_1y {
  derived_table: {
    explore_source: cook_hh_income_full {
      column: id_geography {}
      column: id_year {}
      column: id_race {}
      column: avg_hh_income_by_race {}
      derived_column: avg_income_lag_1y {
        sql: LAG(avg_hh_income_by_race, 1) OVER(PARTITION BY id_race, id_geography ORDER BY id_year) ;;
      }
    }
  }
  dimension: pk3__geo_year_race {
    primary_key: yes
    type: string
    sql: CONCAT(${id_geography}, ${id_year}, ${id_race}) ;;
  }

  dimension: id_geography {
    hidden: yes
    label: "Geographic Data Map Coordinates"
    type: number
  }
  dimension: id_year {
    hidden: yes
    label: "Household Income Year"
    type: number
  }
  dimension: id_race {
    hidden: yes
    label: "Household Income Race"
    type: number
  }
  dimension: avg_income_base {
    hidden: yes
    label: "Average Household Income Base"
    value_format_name: usd_0
    type: number
    sql: ${TABLE}."avg_hh_income_by_race" ;;
  }
  dimension: avg_income_lag_1y {
    hidden: yes
    label: "Average Income Last Year"
    value_format_name: usd_0
    type: number
  }
  measure: pct_change_from_last_year {
    label: "Median % Change From Last Year"
    group_label: "Median"
    type: number
    sql: AVG(${avg_income_base} / ${avg_income_lag_1y} - 1) ;;
    value_format_name: percent_2
  }
  measure: med_income_lag_1y {
    group_label: "Median"
    label: "Median Income Last Year"
    type: median
    sql: ${avg_income_lag_1y} ;;
    value_format_name: usd_0
  }
}
