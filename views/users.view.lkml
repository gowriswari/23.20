view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    #sql: ${TABLE}.age ;;
    sql: ${TABLE}.age * 56478367;;
  }
  dimension: hh_mm_ss {
    sql: TIME_FORMAT(SEC_TO_TIME(${age}), '%H:%i:%s');;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    drill_fields: [created_month,created_year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: conact_testing{
    type: string
    sql: concat(${first_name}, ",", " ",${city}) ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [detail*]
    link: {
      label:"Explore top 20 rows"
      url: "{{ link }}&limit=20"
    }
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    filters: [users.conact_testing: "Ashton\, Ada"]
    drill_fields: [detail*]
    link: {
      label:"Explore top 20 rows"
      url: "{{ link }}&limit=20"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }

}
