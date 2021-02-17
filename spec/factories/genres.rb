FactoryBot.define do
  factory :genre do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/no_image.jpg'), 'image/jpg') }
    name { Faker::Name.name }
  end
end