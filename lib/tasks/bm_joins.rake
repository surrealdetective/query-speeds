desc "bm loops, joins, & includes for 2 models that don't consistently intersect"
task :bm_joins => :environment do
  require 'benchmark'
  include Benchmark

  def loops
    puts "ARTISTS WITH COMMISSIONS"
    Artists.all.each do |artist|
      if artist.commissions.present?
        artist.commissions.each_with_index do |com, i|
          puts artist.name
          puts "Commission #{i}: #{com.description}"
          puts "Price: #{com.price}"
        end
      end
    end
  end

  def joins
    Artifact.joins(:artist).each do |artifact|
      "A work of art in #{artifact.media} by #{artifact.artist.name}"
      artifact.name.upcase
    end
  end

  def includes
    Artifact.includes(:artist).each do |artifact|
      "A work of art in #{artifact.media} by #{artifact.artist.name}"
      artifact.name.upcase 
    end
  end

  Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
    tl = x.report("loops:")    { loops }
    tj = x.report("joins:")    { joins }
    ti = x.report("includes:") { includes }
  end
end  
