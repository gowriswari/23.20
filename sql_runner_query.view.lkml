
view: sql_runner_query {
  derived_table: {
    sql: SELECT
          (DATE(
              history.COMPLETED_AT_TIMESTAMP
            )) AS history_completed_date,
          dashboard.id AS dashboard_id,
              (CASE WHEN (dashboard.preferred_viewer != 'dashboards-next') OR (dashboard.preferred_viewer IS NULL)  THEN 'Yes' ELSE 'No' END) AS dashboard_is_legacy,
          dashboard.id  AS dashboard_link,
              (DATE(dashboard.DELETED_AT )) AS dashboard_deleted_date,
              (CASE WHEN ((dashboard.DELETED_AT) IS NOT NULL) OR ((dashboard.id) IS NULL AND (dashboard.DELETED_AT) IS NULL)  THEN 'Yes' ELSE 'No' END) AS dashboard_moved_to_trash
      FROM history
      LEFT JOIN dashboard ON
              (CASE WHEN REGEXP_CONTAINS (history.dashboard_id, '^[0-9]+$')
                THEN CAST(history.dashboard_id AS INT64)
                ELSE 0
                END)
      
            = dashboard.id
      WHERE (((dashboard.DELETED_AT) IS NOT NULL) OR ((dashboard.id) IS NULL AND (dashboard.DELETED_AT) IS NULL) )
      GROUP BY
          1,
          2,
          3,
          4,
          5,
          6
      ORDER BY
          1 DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: history_completed_date {
    type: date
    datatype: date
    sql: ${TABLE}.history_completed_date ;;
  }

  dimension: dashboard_id {
    type: number
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: dashboard_is_legacy {
    type: string
    sql: ${TABLE}.dashboard_is_legacy ;;
  }

  dimension: dashboard_link {
    type: number
    sql: ${TABLE}.dashboard_link ;;
  }

  dimension: dashboard_deleted_date {
    type: date
    datatype: date
    sql: ${TABLE}.dashboard_deleted_date ;;
  }

  dimension: dashboard_moved_to_trash {
    type: string
    sql: ${TABLE}.dashboard_moved_to_trash ;;
  }

  set: detail {
    fields: [
        history_completed_date,
	dashboard_id,
	dashboard_is_legacy,
	dashboard_link,
	dashboard_deleted_date,
	dashboard_moved_to_trash
    ]
  }
}
