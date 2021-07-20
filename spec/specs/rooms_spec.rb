
describe "rooms", type: :request do
    describe "#create" do
      it "should create and return a new room" do
        create_user
        token = login_user
        create_room token
        data = JSON.parse(response.body)
        expect(data['number']).to eq(1)
        expect(data['capacity']).to eq(2)
        expect(data['peak_rate']).to eq(100)
        expect(data['offpeak_rate']).to eq(90)
      end
    end

    describe "#index" do
      it "should return an array of all rooms" do
        create_user
        token = login_user
        [1, 2, 3].each {|n| create_room(token, n)}
        get "/rooms", headers: { Authorization: "Bearer #{token}" }
        data = JSON.parse(response.body)

        expect(data.length).to eq(3)
        expect(data[0]['number']).to eq(1)
        expect(data[2]['peak_rate']).to eq(100)
      end

      # it "should return the room's bookings" do
      #   token = login_user
      #   [1, 2, 3].each {|n| create_room(n, token)}
      #   get "/rooms", headers: { Authorization: "Bearer #{token}" }
      #   data = JSON.parse(response.body)
      #   pp data
      # end
    end
end