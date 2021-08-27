view: cook_hh_income_tract_white {
  sql_table_name: public.cook_hh_income_tract_white ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
  }

  dimension: geography {
    type: string
    sql: ${TABLE}."geography" ;;
  }

  dimension: hh_income_by_race {
    type: number
    sql: ${TABLE}."hh_income_by_race" ;;
  }

  dimension: id_geography {
    type: string
    sql: ${TABLE}."id_geography" ;;
  }

  dimension: id_race {
    type: number
    sql: ${TABLE}."id_race" ;;
  }

  dimension: id_year {
    type: number
    sql: ${TABLE}."id_year" ;;
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
    type: count
    drill_fields: []
  }
}
