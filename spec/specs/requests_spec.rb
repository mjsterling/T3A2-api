describe "requests", type: :request do
  describe "#create" do
    before :example do
      create_request
    end
    it "should return a 201 and not require a JWT" do
      expect(response.status).to eq(201)
    end
    it "should return a reference number" do
      data = JSON.parse(response.body)
      expect(data["reference_number"]).to be_a(String)
      expect(data["reference_number"].length).to eq(10)
    end
    it "should return correct data" do
      data = JSON.parse(response.body)
      expect(data["first_name"]).to eq "John"
      expect(Date.parse(data["dates"][0])).to eq(Date.new(2021, 7, 15))
    end
  end

  describe "#index" do
    before :example do
      create_user
      create_request
    end
    it "should require a JWT" do
      get "/requests"
      expect(response.status).to eq 401
    end
    it "should return all requests" do
      token = login_user
      get "/requests", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body
      expect(data.length).to be > 0
      expect(data[0]["first_name"]).to eq "John"
    end
  end

  describe "#update" do
    before :example do
      create_request
    end
    it "should allow the customer to update their bookings using a ref token" do
      data = JSON.parse response.body
      ref_number = data["reference_number"]
      patch "/requests/#{ref_number}", params: { request: { **data, first_name: "Jane" } }
      expect(response.status).to eq 204
    end
    it "should allow admins to update a booking using the id and a JWT" do
      data = JSON.parse response.body
      id = data["id"]
      create_user
      token = login_user
      patch "/requests/#{id}", params: { request: { **data, first_name: "Jane" } }, headers: { Authorization: "Bearer #{token}" }
      expect(response.status).to eq 204
    end
  end

  describe "#show" do
    before :example do
      create_request
    end
    it "should fetch using ref number" do
      data = JSON.parse response.body
      get "/requests/#{data["reference_number"]}"
      data = JSON.parse response.body

      expect(response.status).to eq 200
      expect(data["first_name"]).to eq "John"
    end
    it "should fetch using id and JWT" do
      data = JSON.parse response.body
      id = data["id"]
      create_user
      token = login_user
      get "/requests/#{id}", headers: { Authorization: "Bearer #{token}" }
      data = JSON.parse response.body

      expect(response.status).to eq 200
      expect(data["first_name"]).to eq "John"
    end
  end

  describe "#delete" do
    before :example do
      create_request
    end
    it "should delete using ref number" do
      data = JSON.parse response.body
      delete "/requests/#{data["reference_number"]}"
      expect(response.status).to eq 204
    end
    it "should delete using ID and JWT" do
      data = JSON.parse response.body
      create_user
      token = login_user
      delete "/requests/#{data["id"]}", headers: { Authorization: "Bearer #{token}" }
      expect(response.status).to eq 204
    end
  end
end
