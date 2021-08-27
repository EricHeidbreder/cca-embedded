view: cook_county_census_tract {
  sql_table_name: public.cook_county_census_tract ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
  }

  dimension: census_tract {
    type: number
    sql: ${TABLE}."CensusTract" ;;
  }

  dimension: census_tract_boundary {
    type: string
    sql: ${TABLE}."CensusTractBoundary" ;;
  }

  dimension: census_tract_center_lat {
    type: number
    sql: ${TABLE}."CensusTractCenterLat" ;;
  }

  dimension: census_tract_center_lng {
    type: number
    sql: ${TABLE}."CensusTractCenterLng" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
