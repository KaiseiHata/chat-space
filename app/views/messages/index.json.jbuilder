json.array! @update_message.each do |message|
  json.user_name message.user.name
  json.date time(message)
  json.body message.body
  json.image message.image
  json.id message.id
end
