require 'rails_helper'

describe Listing do
  it { should have_many :reviews}
  it { should validate_presence_of :name}
  it { should validate_presence_of :location}
end
