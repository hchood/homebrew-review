require 'rails_helper'

RSpec.describe Tag, :type => :model do
  let!(:tag) { FactoryGirl.create(:tag) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
