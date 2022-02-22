namespace :custom_task do
  desc "Execute this sample task from Github actions, which creates few records in articles table"
  task create_sample_articles: :environment do
    puts "----> Started... sample task"

    10.times do |i|
      article = Article.create(title: Faker::Book.title, author: Faker::Book.author)
      puts "-Created new article: #{article.title}"
    end

    puts "----> Finished... sample task"
  end
end
