describe "bookings", type: :request do
  describe "#create" do
    before :example do
      create_user
      token = login_user
      create_room token
      create_booking token
    end
    it "should create a new booking" do
      data = JSON.parse response.body
    end
  end
  describe "#index" do
    before :example do
      create_user
      token = login_user
      create_room token
      create_booking token
      get "/bookings", headers: { Authorization: "Bearer #{token}" }
    end

    it "should show all bookings" do
      data = JSON.parse response.body
      pp data
      expect(data[0]["first_name"]).to eq("John")
    end
  end
end
