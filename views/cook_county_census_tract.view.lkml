view: cook_county_census_tract {
  sql_table_name: public.cook_county_census_tract ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
    hidden: yes
  }

  dimension: id_geometry {
    label: "Census Tract ID"
    type: string
    sql: ${TABLE}."CensusTract" ;;
  }

  dimension: boundary {
    label: "Census Tract Boundary"
    type: string
    sql: ${TABLE}."CensusTractBoundary" ;;
  }

  dimension: lat {
    label: "Latitude"
    type: number
    sql: ${TABLE}."CensusTractCenterLat" ;;
  }

  dimension: lng {
    label: "Longitude"
    type: number
    sql: ${TABLE}."CensusTractCenterLng" ;;
  }

  dimension: location {
    label: "Map Coordinates"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lng} ;;
  }

  measure: count {
    label: "Number of Records"
    type: count
    drill_fields: []
  }
}
