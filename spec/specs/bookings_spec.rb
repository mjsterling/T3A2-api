describe "bookings", type: :request do
  describe "#create" do
    it "should create a new booking" do
      create_user
      token = login_user
      create_room token
      create_booking token
      data = JSON.parse response.body
      expect(data["id"]).to be_a(Integer)
      expect(data["room_id"]).to be_a(Integer)
      expect(Date.parse(data["dates"][0])).to eq(Date.new(2021, 7, 15))
    end
  end

  describe "#index" do
    it "should show all bookings" do
      create_user
      token = login_user
      create_room token
      create_booking token
      get "/bookings", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      expect(data[0]["first_name"]).to eq("John")
    end
  end

  describe "#show" do
    it "should return a specific booking" do
      create_user
      token = login_user
      create_room token
      create_booking token
      get "/bookings", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      get "/bookings/#{data[0]["id"]}", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      expect(data["first_name"]).to eq("John")
    end
  end

  describe "#update" do
    it "should update a booking and return a 204" do
      create_user
      token = login_user
      create_room token
      create_booking token
      get "/bookings", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      new_date = Date.new(2021, 7, 18)
      patch "/bookings/#{data[0]["id"]}", params: {
                                            booking: { **data[0], dates: [*data[0]["dates"], new_date] },
                                          },
                                          headers: { Authorization: "Bearer #{token}" }
      expect(response.status).to eq(204)
      get "/bookings/#{data[0]["id"]}", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      expect(Date.parse(data["dates"][3])).to eq(new_date)
    end
  end
end
