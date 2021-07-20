def create_user
  user = User.create(email: "admin@email.com", password: "123456")
  user.id
end

def login_user
  post "/login", params: { email: "admin@email.com", password: "123456" }
  data = JSON.parse(response.body)
  data["token"]
end

def create_room(token, room_number = 1)
  post "/rooms", params: { room: { number: room_number, capacity: 2, peak_rate: 100, offpeak_rate: 90 } }, headers: { Authorization: "Bearer #{token}" }
end

def create_booking(token, room_number = 1)
  post "/bookings", params: {
                      booking: {
                        :room_number => 1, :first_name => "John", :last_name => "Doe", :email_address => "john.doe@email.com",
                        :phone_number => "+61421864667", :num_adults => "1", :num_children => "2", :num_dogs => "1",
                        :dates => [Date.new(2021, 7, 15), Date.new(2021, 7, 16), Date.new(2021, 7, 17)],
                      },
                    }, headers: { Authorization: "Bearer #{token}" }
end
