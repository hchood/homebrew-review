require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }

  it { should have_many(:homebrews).dependent(:destroy) }
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:inverse_friendships).dependent(:destroy) }
  it { should have_many(:friends).through(:friendships) }
  it { should have_many(:inverse_friends).through(:inverse_friendships) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should validate_uniqueness_of :email}
end
