FactoryGirl.define do
  factory :tweet do
    text "hello!"
    image "hoge.png"
    user_id 1
    # tweetリソースを作成する時created_atをランダムに設定する
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end
