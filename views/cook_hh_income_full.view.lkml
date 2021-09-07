view: cook_hh_income_full {
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

  dimension: race_original {
    hidden: yes
    type: string
    sql: ${TABLE}."race" ;;
  }

  dimension: race {
    type: string
    sql:
      CASE
          WHEN ${race_original} = 'Total' THEN 'Non Black/White'
      ELSE ${race_original} END
    ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."year" ;;
    value_format: "####"
  }

  dimension: year_string {
    description: "Dimension used in building parameter suggestions"
    hidden: yes
    type: string
    sql: ${TABLE}."year" ;;
    suggestions: ["2018", "2017", "2016", "2015", "2014", "2013"]
  }

  # parameter: starting_year {
  #   view_label: "Year by Year Comparisons"
  #   description: "Alters the starting year of your analysis"
  #   label: " Starting Year"
  #   type: unquoted
  #   suggest_dimension: year_string
  #   default_value: "2018"
  # }

  # parameter: comparison_year {
  #   view_label: "Year by Year Comparisons"
  #   description: "Alters the comparison year of your analysis"
  #   label: "Comparison Year"
  #   type: unquoted
  #   suggest_dimension: year_string
  #   default_value: "2017"
  # }

  parameter: hh_income_by_race_bucket_size {
    type: number
    default_value: "5000"
  }

  dimension: hh_income_by_race_bucket_lower {
    type: number
    hidden: yes
    sql: FLOOR(${hh_income_by_race} / {% parameter hh_income_by_race_bucket_size %})
      * {% parameter hh_income_by_race_bucket_size %} ;;
    value_format_name: usd_0
  }

  dimension: hh_income_by_race_bucket_upper {
    type: number
    hidden: yes
    sql: ${hh_income_by_race_bucket_lower} + {% parameter hh_income_by_race_bucket_size %} ;;
    value_format_name: usd_0
  }

  dimension: hh_income_by_race_buckets {
    label: "Income Buckets"
    type: string
    sql: CONCAT(${hh_income_by_race_bucket_lower}, ' - ', ${hh_income_by_race_bucket_upper});;
  }

  measure: number_of_records {
    type: count
  }

  measure: sum_hh_income_by_race {
    label: "Sum of Household Income"
    type: sum
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  measure: avg_hh_income_by_race {
    label: "Average Household Income"
    type: average
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  measure: median_hh_income_by_race {
    group_label: "Median"
    label: "Median Household Income"
    type: median
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  # No longer using these

  # measure: median_hh_income_starting_year {
  #   # label will update based on the parameter you have selected, this only displays in visualizations
  #   label: "Median Houshold Income {{ cook_hh_income_full.starting_year._parameter_value }}"
  #   view_label: "Year by Year Comparisons"
  #   group_label: " Starting Year"
  #   group_item_label: "Median Household Income"
  #   type: median
  #   sql:
  #   CASE
  #     WHEN ${year} = {% parameter starting_year %}
  #     THEN ${hh_income_by_race}
  #   END
  #     ;;
  #   value_format_name: usd_0
  # }

  # measure: median_hh_income_comparison_year {
  #   # label will update based on the parameter you have selected, this only displays in visualizations
  #   label: "Median Houshold Income {{ cook_hh_income_full.comparison_year._parameter_value }}"
  #   view_label: "Year by Year Comparisons"
  #   group_label: "Comparison Year"
  #   group_item_label: "Median Household Income"
  #   type: median
  #   sql:
  #   CASE
  #     WHEN ${year} = {% parameter comparison_year %}
  #     THEN ${hh_income_by_race}
  #   END
  #   ;;
  #   value_format_name: usd_0
  # }

  # measure: pct_change_comparison_to_starting {
  #   view_label: "Year by Year Comparisons"
  #   label: "Pct Change {{ cook_hh_income_full.comparison_year._parameter_value }} - {{ cook_hh_income_full.starting_year._parameter_value }}"
  #   description: "Percent change between two comparison years"
  #   type: number
  #   sql: ${median_hh_income_starting_year} / ${median_hh_income_comparison_year} - 1 ;;
  #   value_format_name: percent_2
  # }

  measure: min_hh_income_by_race {
    label: "Minimum Household Income"
    type: min
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  measure: max_hh_income_by_race {
    label: "Maximum Household Income"
    type: max
    sql: ${hh_income_by_race} ;;
    value_format_name: usd_0
  }

  measure: hh_income_by_race_25th_percentile {
    label: "25th Percentile Household Income"
    type: percentile
    percentile: 25
    sql: ${hh_income_by_race} ;;
  }

  measure: hh_income_by_race_75th_percentile {
    label: "75th Percentile Household Income"
    type: percentile
    percentile: 75
    sql: ${hh_income_by_race} ;;
  }

}
