# user = User.new(
#   email: 'admin@email.com',
#   password: '123456',
#   password_confirmation: '123456'
# )
# user.skip_confirmation!
# user.save!

PublicActivity.enabled = false
30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    user_id: User.last.id,
    # short_description: Faker::Quote.famous_last_words,
    short_description: Faker::Quote.most_interesting_man_in_the_world,
    language: 'English',
    level: 'Beginner',
    price: Faker::Number.between(from: 1000, to: 20000)
  }])
end
PublicActivity.enabled = true