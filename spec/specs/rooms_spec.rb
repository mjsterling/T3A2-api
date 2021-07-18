describe "rooms", type: :request do
    describe "rooms#index" do
      before(:example) do
        create_user
        login_user
      end

      it "should return an array of rooms" do
        post "rooms", 
      end
    end
end