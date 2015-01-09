Tag::TAG_NAMES.each do |name|
  tag = Tag.find_by(name: name)

  if !tag.nil?
    puts "#{name} already created."
  else
    Tag.create(name: name)
    puts "Added #{name} tag."
  end
end
