def create_user
    user = User.create(email: "admin@email.com", password: "123456")
    user.id
  end
  
  def login_user
    post "/login", params: { email: "admin@email.com", password: "123456" }
    data = JSON.parse(response.body)
    data["token"]
  end