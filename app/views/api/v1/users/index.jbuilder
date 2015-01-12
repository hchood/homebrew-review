json.users @users do |user|
  json.extract! @user,
    :id,
    :created_at,
    :updated_at,
    :email,
    :first_name,
    :last_name
end
