view: cook_county_census_tract {
  sql_table_name: public.cook_county_census_tract ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
  }

  dimension: id_geometry {
    type: string
    sql: ${TABLE}."CensusTract" ;;
  }

  dimension: boundary {
    type: string
    sql: ${TABLE}."CensusTractBoundary" ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}."CensusTractCenterLat" ;;
  }

  dimension: lng {
    type: number
    sql: ${TABLE}."CensusTractCenterLng" ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lng} ;;

  }

  measure: count {
    type: count
    drill_fields: []
  }
}
