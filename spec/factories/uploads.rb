FactoryGirl.define do
  factory :upload do
    file { File.open(File.join(Rails.root, 'spec', 'support', 'dummy_file.txt')) }
  end
end
