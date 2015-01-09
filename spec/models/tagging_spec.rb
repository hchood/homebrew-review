require 'rails_helper'

RSpec.describe Tagging, :type => :model do
  let!(:tagging) { FactoryGirl.create(:tagging) }

  it { should belong_to :tag }
  it { should belong_to :homebrew }

  it { should validate_presence_of :tag }
  it { should validate_presence_of :homebrew }

  it { should validate_uniqueness_of(:tag).scoped_to(:homebrew_id) }
end
