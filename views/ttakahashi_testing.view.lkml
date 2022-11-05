view: ttakahashi_testing {
  sql_table_name: public.cook_hh_income_full ;;

  dimension: pk {
    primary_key: yes
    type: number
    sql: ${TABLE}."pk" ;;
    hidden: yes
  }

  dimension: hh_income_by_race {
    hidden: yes
    label: "Household Income by Race"
    type: number
    sql: ${TABLE}."hh_income_by_race" ;;
    value_format_name: usd_0
  }

  dimension: id_geography {
    label: "Census Tract ID"
    map_layer_name: census_tract
    type: string
    sql: ${TABLE}."id_geography" ;;
  }

  measure: avg_hh_income_by_race {
    label: "Average Household Income"
    type: average
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  measure: html_testing {
    type: average
    sql: ${hh_income_by_race} ;;
    value_format: "$#.00;($#.00)"
    html:
    <ul>
      <li> value: {{ value }} </li>
      <li> rendered_value: {{ rendered_value }} </li>
      <li> linked_value: {{ linked_value }} </li>
      <li> link: {{ link }} </li>
      <li> model: {{ _model._name }} </li>
      <li> view: {{ _view._name }} </li>
      <li> explore: {{ _explore._name }} </li>
      <li> field: {{ _field._name }} </li>
      <li> dialect: {{ _dialect._name }} </li>
      <li> access filter: {{ _access_filters['company.name'] }} </li>
      <li> user attribute: {{ _user_attributes['region'] }} </li>
      <li> query timezone: {{ _query._query_timezone }} </li>
      <li> filters: {{ _filters['order.total_order_amount'] }} </li>
    </ul> ;;
  }
}
