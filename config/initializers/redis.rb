#$redis = Redis.new(:host => 'localhost', :port => 6379)
#
#free_plan = {
#    'matches' => 5,
#    'organizations' => 5,
#    'users_per_organization' => 5
#}
#
#basic_plan = {
#    'matches' => 10,
#    'organizations' => 10,
#    'users_per_organization' => 30
#}
#
#pro_plan = {
#    'matches' => 'unlimited',
#    'organizations' => 'unlimited',
#    'users_per_organization' => 'unlimited'
#}
#
#$redis.set('free_plan', free_plan.to_json)
#$redis.set('basic_plan', basic_plan.to_json)
#$redis.set('pro_plan', pro_plan.to_json)
#
##<%= JSON.parse($redis.get("free_plan"))['matches'] %>
