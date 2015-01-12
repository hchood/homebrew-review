json.homebrews @homebrews do |homebrew|
  json.extract! homebrew, :id, :brewer_id, :name, :description
  json.date_brewed homebrew.date_brewed.to_datetime
  json.tag_ids homebrew.tag_ids
end
