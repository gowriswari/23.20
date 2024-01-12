view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  dimension: looker_image {
    type: string
    sql: ${TABLE}.sale_price;;
    html: <img src="https://storage.googleapis.com/gygygyihijooojooooj/cost_trends_top_services.jpeg" /> ;;
  }

  ########

  dimension_group: created_date_friday {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: case when ${returned_week} ='Friday' then ${returned_date}ed_date}
      when ${returned_week} ='Saturday' then dateadd(days,6,${returned_date})
      when ${returned_week} ='Sunday' then dateadd(days,5,${returned_date})
      when ${returned_week} ='Monday' then dateadd(days,4,${returned_date})
      when ${returned_week} ='Tuesday' then dateadd(days,3,${returned_date})
      when ${returned_week} ='Wednesday' then dateadd(days,2,${returned_date})
      when ${returned_week} ='Thursday' then dateadd(days,1,${returned_date})
      end ;;
  }

  parameter: date_granularity {
    type: string
    description: "To apply date granularity"
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: created_date_granularity {
    type: date
    label_from_parameter: date_granularity
    sql:
    CASE
    WHEN {% parameter date_granularity %} = 'Day' THEN ${returned_date}
    WHEN {% parameter date_granularity %} = 'Month' THEN last_day(to_date(${returned_date}),'month')
    WHEN {% parameter date_granularity %} = 'Quarter' THEN last_day(to_date(${returned_date}),'quarter')
    WHEN {% parameter date_granularity %} = 'Year' THEN last_day(to_date(${returned_date}),'year')
    END ;;
  }


  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
