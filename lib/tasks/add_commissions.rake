namespace :db do
  desc 'adds 5000 commissions to random artists'
  task :add_commissions => :environment do 
    require 'populator' 

    artists = Artist.all
    c_times = artists.count/10
    Commission.populate c_times do |com|
      com.description = Populator.sentences(2..5)
      com.price       = (25..10000)
      com.artist_id   = artists.sample.id
    end 
  end
end