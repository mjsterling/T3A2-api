class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    payload[:exp] = 7.days.from_now.to_i
    JWT.encode(payload, Figaro.env.jwt_key)
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, Figaro.env.jwt_key, true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find(user_id)
    else
      puts "Authentication failed"
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end

  def parse_dates(dates)
    dates.map { |date| Date.parse(date) }.uniq
  end
end
