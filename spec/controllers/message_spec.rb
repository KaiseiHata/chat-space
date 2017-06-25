require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { build(:message, user_id: user.id, group_id: group.id) }

    describe 'GET #index' do
      context "ログインしている場合" do
        before do
          login_user user
        end

        before :each do
          get :index, params: { group_id: group.id }
        end

        it "アクション内で定義している@messageがある" do
          message = Message.new
          expect(assigns(:message)).to be_a_new Message
        end

        it "アクション内で定義している@groupがある" do
          expect(assigns(:group)).to eq group
        end

        it "アクション内で定義している@messagesがある" do
          messages = group.messages
          expect(assigns(:messages)).to eq messages
        end

        it "アクション内で定義している@groupsがある" do
          groups = user.groups
          expect(assigns(:groups)).to eq groups
        end

        it "インデックス画面に遷移する" do
          expect(response).to render_template :index
        end
      end

      context 'ログインしていない場合' do
        it 'ログイン画面に遷移する' do
          get :index, params: { group_id: group.id }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    describe 'POST #create' do
      context 'ログインしている場合' do
        before :each do
          login_user user
        end

        context 'ログインしているかつ保存に成功した場合' do
          it "メッセージの保存ができる" do
            expect {
              post :create, params: { message: attributes_for(:message, {body: message.body }),group_id: group.id, user_id: user.id }}.to change(Message, :count).by(1)
          end

          it "インデックス画面に遷移する" do
            post :create, params: { message: attributes_for(:message, { body: message.body }), group_id: group.id, user_id: user.id }
            expect(response).to redirect_to group_messages_path(group.id)
          end
        end

        context 'ログインしているが、保存に失敗した場合' do
          it 'メッセージの保存は行われない' do
            expect {
              post :create, params: {
               message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id, user_id: user.id } }
               .not_to change(Message, :count)
          end

          it 'インデックス画面に遷移する' do
            post :create, params: { message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id, user_id: user.id }
            expect(response).to render_template :index
          end
        end
      end
      context 'ログインしていない場合' do
        it "ログイン画面に遷移する" do
          post :create, params: { group_id: group.id, user_id: user.id }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
end