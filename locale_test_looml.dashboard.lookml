---
- dashboard: locale_testing_copy
  title: locale_testing (copy)
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: g4d1EbdVtoMnxHtXn4Bny4
  elements:
  - title: locale_testing
    name: locale_testing
    model: gowri_1
    explore: order_items
    type: looker_grid
    fields: [order_items.sale_price, order_items.count, inventory_items.cost, inventory_items.id,
      inventory_items.created_date, users.country, users.email]
    filters: {}
    sorts: [order_items.count desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "-${order_items.sale_price}"
      label: testing
      value_format:
      value_format_name: percent_2
      _kind_hint: dimension
      table_calculation: testing
      _type_hint: number
      is_disabled: true
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    custom_color: "#E52592"
    value_format: ''
    comparison_label: test
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: equal to, value: 3990, background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    hidden_fields: [order_items.count, order_items.sale_price]
    y_axes: []
    hidden_pivots: {}
    listen:
      Gender: users.gender
      Created Date: inventory_items.created_date
      Country: users.country
      Email: users.email
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Gender
    title: Gender
    type: field_filter
    default_value: f
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gowri_1
    explore: order_items
    listens_to_filters: []
    field: users.gender
  - name: Country
    title: Country
    type: field_filter
    default_value: USA
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gowri_1
    explore: order_items
    listens_to_filters: []
    field: users.country
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 7 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: gowri_1
    explore: order_items
    listens_to_filters: []
    field: inventory_items.created_date
  - name: Email
    title: Email
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gowri_1
    explore: order_items
    listens_to_filters: []
    field: users.email
