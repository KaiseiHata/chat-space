require 'rails_helper'

describe Message do
  describe '#create' do
    context 'can save' do
      it "is valid with a body" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end



      it "is valid with a image" do
        expect(build(:message, body: nil)).to be_valid
      end

      it "is valid with a body, image" do
        message = build(:message)
        expect(message).to be_valid
      end
    end
    context 'can not save' do
      it "is invalid without a message and a image" do
        message = build(:message, body: nil, image: nil)
        message.valid?
        expect(message.errors[:body][0]).to include("を入力してください")
      end

      it "is invalid without a group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group_id][0]).to include("を入力してください")
      end

      it "is invalid without a user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user_id][0]).to include("を入力してください")
      end
    end
  end
end