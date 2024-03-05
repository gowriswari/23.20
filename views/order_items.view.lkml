view: order_items {
  sql_table_name: demo_db.order_items ;;
  #required_access_grants: [explore_testing]
  drill_fields: [id]
#label: "high school test results"
  parameter: tt1 {
    type: string
    allowed_value: {
      label: "Less than 500"
      value: "< 500"
    }
    allowed_value: {
      label: "Less than 10,000"
      value: ">500"
    }
  }
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
    drill_fields: [returned_date,choice*,inventory_item_id]
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


############ CUSTOMER CASE CHECKING ########

  dimension: sale_price {
    can_filter: yes
    type: number
    #drill_fields: [choice*, orders.id, inventory_items.id#label: "hhgchgjhdghdgfhjsd"
    sql: ${TABLE}.sale_price ;;
  }

  dimension: metric {
    type: number
    sql: 1000000000*(${TABLE}.sale_price) ;;
  }

  measure: gbv_YTD_trends {
    group_label: "Formatted GBV"
    label:"YTD1"
    type: number
    sql: ${TABLE}.sale_price ;;
    html:
        {% assign metric = sale_price._rendered_value | plus: 0 %}

                    <p style="text-align: center; font-size: 14px; margin-bottom: 0px;">
                    <font color="black">
                    {% if metric > 1000000000 %}
                        ${{metric | divided_by: 1000000000 | round:1 }}B
                      {% elsif metric >= 1000000 and metric < 1000000000 %}
                        ${{metric | divided_by: 1000000 | round:1 }}M
                      {% elsif metric >= 1000 and metric < 1000000 %}
                        ${{metric | divided_by: 1000 | round:1 }}K
                      {% elsif metric >= 0 and metric < 1000 %}
                        ${{metric | round:1 }}
                      {% elsif metric > -1000 and metric < 0 %}
                          ${{metric | round:1 }}
                      {% elsif metric > -1000000 and metric <= -1000 %}
                          ${{metric | divided_by: 1000 | round:1 }}k
                      {% elsif metric > -1000000000 and metric <= -1000000 %}
                          ${{metric | divided_by: 1000000 | round:1 }}M
                      {% elsif metric <= -1000000000 %}
                          ${{metric | divided_by: 1000000000 | round:1 }}B
                      {% else %}
                        ${{metric}}
                      {% endif %}</font><br>
                    </p>;;
  }

  dimension: delta{
    type: number
    sql: 1000000*(${TABLE}.sale_price) ;;
  }


  measure: gbv_YTD_Summary_Formatted {
    group_label: "Formatted GBV"
    label:"YTD2"
    type: number
    sql: `Summary YTD Totals` ;;
    #sql: 1000*${sale_price} ;;
    html:
    {% assign delta = sale_price_vs_2019._rendered_value | plus: 0 %}
    {% assign metric = sale_price._rendered_value | plus: 0 %}
    {% assign 2019_metric = sale_price_2019._rendered_value | plus: 0 %}

    @{summary_aggregated_formatting}
    ;;
  }

dimension: gbv_indicator {
  type: number
  sql: 1000*${sale_price} ;;
}

########
  measure: count {
    type: count
    drill_fields: [choice*, choice1*,orders.id, inventory_items.id]
  }
measure: summary {
  type: sum
  sql: ${sale_price}+${delta} ;;
}
  set: choice {
    fields: [users.age,count]
  }
  set:  choice1{
    fields: [phone,returned_date,sale_price]
  }
}
