class SessionsController < ApplicationController

skip_before_action :authenticate_user, only: :create

def create
  resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = '1MKH1CZGFIN2JGROMEGYEGU1NYTZWDB2XX5EY21GY1E0V3GH'
    req.params['client_secret'] = 'NIMIJOMIQSEAMABLGGMLHL35I2N2ILFVLUF1U5CIK0EGGZLG'
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end
 
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end

end
