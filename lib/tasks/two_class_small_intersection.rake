namespace :bm do  
  desc "two class' attributes w small intersection, query benchmarking"
  task :two_class_small_intersection => :environment do
    require 'benchmark'
    include Benchmark

    def artist_w_com(artist)
      artist.name
      artist.commissions.each_with_index do |com, i|
        "Commission #{i+1}: #{com.description}"
        "Price: #{com.price}"
      end
    end

    def loops
      Artist.all.each do |artist|
        if artist.commissions.present?
          artist_w_com(artist)
        end
      end
    end

    def joins
      Artist.joins(:commissions).each do |artist|
        artist_w_com(artist)
      end
    end

    def includes
      Artist.includes(:commissions).each do |artist|
        artist_w_com(artist)
      end
    end

    puts "ARTISTS WITH COMMISSIONS AND COMMISSION ATTRIBUTES"
    Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
  end  
end