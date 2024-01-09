
view: derived_testing {
  derived_table: {
    sql: select order_items.id as ID,order_items.sale_price as Sales_price from order_items ;;
  }

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
