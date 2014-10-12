require 'rails_helper'

# TODO: 何のためにあるかよくわからない
# RSpec.describe 'API auth' do
#   include JsonApiHelpers

#   before do
#     @user = create(:user)
#   end

#   describe "POST /api/session" do
#     it "should return auth_token for valid HTTP Basic credentials" do
#       authenticate_successfully
#       expect(response.status).to eq 200
#       expect(json_response['auth_token']).not_to be_blank
#     end

#     it "should return error json when HTTP Basic credentials are invalid" do
#       post '/api/session', {}, http_basic(@user.email, "badpassword")

#       expect(response.status).to        eq 401
#       expect(json_response["error"]).to eq "Invalid email or password."
#     end

#     it "should return error json when HTTP Basic credentials are missing" do
#       post '/api/session'

#       expect(response.status).to eq 401
#       expect(json_response["error"]).to eq "You need to sign in or sign up before continuing."
#     end
#   end

#   describe "DELETE /api/session" do
#     it "should return HTTP 200 OK when session exists" do
#       authenticate_successfully
#       auth_token = json_response['auth_token']
#       delete '/api/session', auth_token: auth_token

#       expect(response).to      be_ok
#       expect(response.body).to be_blank
#     end

#     it "should return HTTP 401 Unauthorized when session didn't exist" do
#       delete '/api/session'

#       expect(response.status).to        eq 401
#       expect(json_response['error']).to eq 'You need to sign in or sign up before continuing.'
#     end

#     it "should not allow to use the same token after it has been cleared" do
#       authenticate_successfully
#       auth_token = json_response['auth_token']
#       delete '/api/session', auth_token: auth_token

#       expect(response).to be_ok
#       expect(response.status).to eq 401
#     end
#   end

#   private

#   def authenticate_successfully
#     post '/api/session', {}, http_basic(@user.email, "password")
#   end

#   def http_basic(user, password)
#     credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
#     {'HTTP_AUTHORIZATION' => credentials}
#   end
# end
