project_name: "gowri_1"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
#constant: summary_aggregated_formatting {
#  value: "Summary YTD Totals"
  #export: none
#}
constant: summary_aggregated_formatting {
  value:
  " {% if delta > 0 %}
  {% assign gbv_indicator = 'green,▲' | split: ','%}
  {% elsif delta < 0 %}
  {% assign gbv_indicator = 'red,▼' | split: ',' %}
  {% else %}
  {% assign gbv_indicator = 'lightgrey,▬' | split: ',' %}
  {% endif %}

  <p style='text-align: center; font-size: 14px; margin-bottom: 8px;'>
  <font color='black'>
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
  $-{{metric | divided_by: -1000.00 | round:1 }}K
  {% elsif metric > -1000000000 and metric <= -1000000 %}
  $-{{metric | divided_by: -1000000.00 | round:1 }}M
  {% elsif metric <= -1000000000 %}
  $-{{metric | divided_by: -1000000000.00 | round:1 }}B
  {% else %}
  ${{metric | round:1}}
  {% endif %}</font><br>
  </p>

  <p style='text-align: center; font-size: 14px; margin-bottom: 0px;'>
  <font color='black'>
  {% if 2019_metric > 1000000000 %}
  ${{2019_metric | divided_by: 1000000000 | round:1 }}B
  {% elsif 2019_metric >= 1000000 and 2019_metric < 1000000000 %}
  ${{2019_metric | divided_by: 1000000 | round:1 }}M
  {% elsif 2019_metric >= 1000 and 2019_metric < 1000000 %}
  ${{2019_metric | divided_by: 1000 | round:1 }}K
  {% elsif 2019_metric >= 0 and 2019_metric < 1000 %}
  ${{2019_metric | round:1 }}
  {% elsif 2019_metric > -1000 and 2019_metric < 0 %}
  ${{2019_metric | round:1 }}
  {% elsif 2019_metric > -1000000 and 2019_metric <= -1000 %}
  $-{{2019_metric | divided_by: -1000.00 | round:1 }}K
  {% elsif 2019_metric > -1000000000 and 2019_metric <= -1000000 %}
  $-{{2019_metric | divided_by: -1000000.00 | round:1 }}M
  {% elsif 2019_metric <= -1000000000 %}
  $-{{2019_metric | divided_by: -1000000000.00 | round:1 }}B
  {% else %}
  ${{2019_metric}}
  {% endif %}</font><br>
  </p>

  <p style='text-align: center; font-size: 12px; margin-bottom: 8px;'>
  <font color='{{gbv_indicator[0]}}'>{{delta}}%{{gbv_indicator[1]}}</font><br>
  </p>"
}
