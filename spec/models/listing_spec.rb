require 'rails_helper'

describe Listing do
  it { should have_many :reviews}
  it { should have_many :fans}
end
