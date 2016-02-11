require 'rails_helper'

# This spec is for validate using a different modules
# and including them it into the main one point.
describe Uploadable do
  before :all do
    Temping.create :uploadable_model do
      include Uploadable
      validates :name, presence: true

      has_file :avatar

      with_columns do |table|
        table.string :name
      end
    end
  end

  let(:uploadable_model) { UploadableModel.new(name: 'test name') }
  let(:file) { File.open(File.join(Rails.root, 'spec', 'support', 'dummy_file.txt')) }
  let(:second_file) { File.open(File.join(Rails.root, 'spec', 'support', 'dummy_file_2.txt')) }

  describe 'class methods' do
    it 'responds to has_file' do
      expect(UploadableModel).to respond_to(:has_file).with(1).argument
    end
  end

  describe 'avatar instance method' do
    it 'responds to it' do
      expect(uploadable_model).to respond_to(:avatar).with(0).argument
    end

    it 'responds to its setter' do
      expect(uploadable_model).to respond_to(:avatar=).with(1).argument
    end

    describe 'when setting a new avatar' do
      it 'should create an Upload instance model' do
        # This test is for Register the result in a Upload scaffolded resource point
        uploadable_model.avatar = file
        expect{ uploadable_model.save }.to change{ Upload.count }.by 1
      end

      it "shouldn't create an Upload instance model if the uploadable_model is invalid" do
        # This test is for use active record transactions to ensure
        # the actions don’t succeed unless the file upload succeeds and is displayable point
        uploadable_model.name = nil
        uploadable_model.avatar = file
        expect{ uploadable_model.save }.to change{ Upload.count }.by 0
      end

      it 'the Upload instance model file attribute should be the avatar' do
        uploadable_model.avatar = file
        uploadable_model.save
        uploaded_file = Upload.last.file
        expect(uploadable_model.avatar.read).to eq uploaded_file.read
      end

      it 'should update the upload instance when the avatar is updated' do
        uploadable_model.avatar = file
        uploadable_model.save
        upload_instance = Upload.last
        uploadable_model.avatar = second_file
        uploadable_model.save
        upload_instance.reload
        expect(upload_instance.file.read).to eq second_file.read
      end
    end
  end
end
