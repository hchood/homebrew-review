class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :homebrew

  validates :tag,
    presence: true,
    uniqueness: { scope: :homebrew_id }
  validates :homebrew, presence: true
end
