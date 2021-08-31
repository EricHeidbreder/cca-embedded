view: cook_county_census_tract {
  sql_table_name: public.cook_county_census_tract ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
    hidden: yes
  }

  dimension: id_geography {
    hidden: yes
    label: "Census Tract ID"
    type: string
    sql: ${TABLE}."CensusTract" ;;
  }

  dimension: boundary {
    hidden: yes
    label: "Census Tract Boundary"
    type: string
    sql: ${TABLE}."CensusTractBoundary" ;;
  }

  dimension: lat {
    hidden: yes
    label: "Latitude"
    type: number
    sql: ${TABLE}."CensusTractCenterLat" ;;
  }

  dimension: lng {
    hidden: yes
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

  dimension: zip {
    label: "Zip Code"
    type: zipcode
    sql: ${TABLE}."zip";;
  }

  measure: count {
    label: "Number of Records"
    type: count
    drill_fields: []
  }
}
