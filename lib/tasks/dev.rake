namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(33),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      rand(20).times do
        user.tweets.create(
          description: FFaker::Lorem.paragraph
        )
      end
    end
    puts "create fake tweets"
  end
  
    task fake_reply: :environment do
    Reply.destroy_all
    100.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      Reply.create(
        user: user,
        tweet: tweet,
        comment: FFaker::Lorem.sentence
      )
    end
    puts "create fake replies"
  end

 task fake_likes: :environment do
    Like.destroy_all

    User.all.each do |user|
      20.times do 
        user.likes.create(tweet_id: Tweet.all.sample.id)
      end
    end
    puts "have created 400 fake follow"
    
end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      followings = User.all.sample(rand(2..22))
      if followings.include?(user)
        followings.delete(user)
      end
      for following in followings
        user.followships.create!(following: following)
      end
    end
    puts "create fake_follow"
end
  

end
