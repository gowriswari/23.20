view: derived_testing {
 derived_table: {
    sql: select order_items.id as ID,order_items.sale_price as Sales_price from order_items ;;
    persist_for: "1 hours"
    indexes: ["id"]
  }

 # datagroup_trigger: "gowri_1_default_datagroup"
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: sales_price {
    type: number
    sql: ${TABLE}.Sales_price ;;
  }

  set: detail {
    fields: [
        id,
  sales_price
    ]
  }
}
