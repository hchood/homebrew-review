json.homebrews @homebrews do |homebrew|
  json.extract! homebrew, :id, :brewer_id, :date_brewed, :name, :description
end
