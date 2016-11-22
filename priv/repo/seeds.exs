alias Rumbl.Repo
alias Rumbl.Category
alias Rumbl.User

for category <- ~w(Action Drama Romance Comedy Sci-fi) do
  Repo.get_by(Category, name: category) || Repo.insert!(%Category{name: category})
end

for user_params <- [%{name: "Serge Karpiesz", username: "skarpiesz", password: "123123123"}] do
  Repo.get_by(User, username: "skarpiesz") || Repo.insert!(User.registration_changeset(%User{}, user_params))
end
