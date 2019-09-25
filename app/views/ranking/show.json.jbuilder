json.array! @entries do |e|
    json.id e.id
    json.type e.type
    json.teamname e.teamname
    json.users e.users
    json.prodname e.prodname
    json.description e.description
    json.evaluation e.evaluation
end