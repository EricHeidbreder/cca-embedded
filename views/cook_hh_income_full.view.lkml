view: cook_hh_income_full {
  sql_table_name: public.cook_hh_income_full ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
    hidden: yes
  }

  dimension: hh_income_by_race {
    label: "Household Income by Race"
    type: number
    sql: ${TABLE}."hh_income_by_race" ;;
  }

  dimension: id_geography {
    label: "Census Tract ID"
    type: string
    sql: ${TABLE}."id_geography" ;;
  }

  dimension: id_race {
    type: number
    sql: ${TABLE}."id_race" ;;
    hidden: yes
  }

  dimension: id_year {
    type: number
    sql: ${TABLE}."id_year" ;;
    hidden: yes
  }

  dimension: race {
    type: string
    sql: ${TABLE}."race" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."year" ;;
  }

  measure: count {
    label: "Number of Records"
    type: count
    drill_fields: []
  }

  measure: sum_hh_income_by_race{
    label: "Sum of Household Income by Race"
    type: sum
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }
}
