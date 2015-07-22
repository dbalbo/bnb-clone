require 'rails_helper'

describe Listing do
  it { should validate_presence_of :name}
end
