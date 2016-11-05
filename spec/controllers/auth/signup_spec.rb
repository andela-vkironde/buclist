require "rails_helper"

RSpec.describe "User requstration", type: :request do
  let(:params) { attributes_for(:user) }
  let(:headers) { headers }
  let!(:existing_user) { create(:user) }

  describe "POST /signup" do
    let!(:req) { post "/signup", params, headers }

    context "when a new user signs up" do
      it_behaves_like "a http response", 201, /Account created successfully/
    end

    context "when and existing user signs up" do
      let(:params) do
        {
          email: existing_user.email,
          password: existing_user.password
        }
      end

      it_behaves_like "a http response", 422, /User already exists/
    end

    context "when a new user signs up with the invalid parameters" do
      let(:params) do
        {
          email: Faker::Lorem.word,
          password: nil
        }
      end

      it_behaves_like "a http response", 422, /Account could not be created/
    end
  end
end