describe "users", type: :request do
    describe "#create" do
      before(:example) do
        post "/users", params: { user: { email: "admin@email.com", password: "123456" } }
      end
      it "should return 201" do
        expect(response.status).to eq(201)
      end
      it "user email should match post request" do
        data = JSON.parse(response.body)
        expect(data["user"]["email"]).to eq("admin@email.com")
      end
      it "should have an encrypted password" do
        data = JSON.parse(response.body)
        expect(data["user"]["password_digest"]).to be_a(String)
      end
    end
  
    describe "#login" do
      before(:example) do
        create_user
        post "/login", params: { email: "admin@email.com", password: "123456" }
      end
  
      it "should return 200" do
        expect(response.status).to eq(200)
      end
  
      it "should return a JWT" do
        data = JSON.parse(response.body)
        expect(data["token"]).to be_a(String)
      end
      it "should return valid user data" do
        data = JSON.parse(response.body)
        expect(data["user"]["id"]).to be_a(Integer)
        expect(data["user"]["email"]).to eq("admin@email.com")
      end
    end
  
    describe "#update" do
    before(:example) do
        create_user
        token = login_user
        patch "/users/#{User.find_by(email: "admin@email.com").id}", headers: { "Authorization" => "Bearer #{token}" }, params: { user: { password: "234567" } }
    end

      it "should update the user's password and prevent logging in with the old one" do
        login_user
        expect(response.status).to eq(401)
      end
      it "should allow the user to login with the new password" do
        post "/login", params: { email: "admin@email.com", password: "234567" }
        expect(response.status).to eq(200)
      end
    end
  end