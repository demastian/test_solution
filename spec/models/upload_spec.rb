require 'rails_helper'

describe Upload, type: :model do
  it 'has a valid factory' do
    expect(build(:upload)).to be_valid
  end
end
