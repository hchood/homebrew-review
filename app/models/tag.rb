class Tag < ActiveRecord::Base
  TAG_NAMES = [
    "red ale",
    "pale ale",
    "lager",
    "IPA",
    "porter",
    "stout",
    "hoppy",
    "mellow",
    "nitro",
    "rye",
    "barley wine"
  ]

  validates :name,
    presence: true,
    uniqueness: true
end
