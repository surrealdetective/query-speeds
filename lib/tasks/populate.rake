namespace :db do
  desc "fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Artist, Artifact, Category].each(&:delete_all)

    Category.populate 1000 do |category|
      category.name = Populator.words(1..2).titleize
      Artifact.populate 10..100 do |artifact|
        artifact.category_id = category.id
        artifact.name        = Populator.words(1..5).titleize
        artifact.media       = ['Sculpture', 'Painting', 'Work on Paper', 'Photography', 'Performance', 'Film/Video', 'Installation', 'Drawing', 'Design']
        artifact.created_at  = 2.years.ago..Time.now
        Artist.populate 1 do |artist|
          artifact.artist_id = artist.id
          artist.name        = Faker::Name.name
        end
      end
    end
  end  
end