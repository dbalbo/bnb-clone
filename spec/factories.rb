Factorygirl.define do
  factory(:listing) do
    name('air conditioning')
    location ('portland')
  end


  factory(:user) do
    email 'text@example.com'
    password 12345678
  end

  factory(:another_user, class: User) do
    email 'text@gmail.com'
    password 22345678
  end

  factory(:admin, class: User) do
    email 'admin@example.com'
    password "password"
    admin true
  end

  factory(:review) do
    text 'Its great'
    rating '5'
  end
end
