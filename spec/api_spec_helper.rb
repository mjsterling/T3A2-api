def create_user
    user = User.create(email: "admin@email.com", password: "123456")
    user.id
  end
  
  def login_user
    post "/login", params: { email: "admin@email.com", password: "123456" }
    data = JSON.parse(response.body)
    data['token']
  end

  def create_room(token, room_number = 1)
    post "/rooms", params: { room: { number: room_number, capacity: 2, peak_rate: 100, offpeak_rate: 90 } }, headers: { Authorization: "Bearer #{token}" }
end
