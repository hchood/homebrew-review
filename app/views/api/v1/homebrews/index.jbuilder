json.homebrews @homebrews do |homebrew|
  json.extract! homebrew, :id, :brewer_id, :date_brewed, :name, :description
  json.tag_ids homebrew.tag_ids
end
