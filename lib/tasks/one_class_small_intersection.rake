namespace :bm do  
  desc "one class' attributes and small intersection, query benchmarking"
  task :one_class_small_intersection => :environment do
    require 'benchmark'
    include Benchmark

    def loops
      Artist.all.each do |artist|
        if artist.commissions.present?
          puts artist.name
        end
      end
    end

    def joins
      Artist.joins(:commissions).each do |artist|
        artist.name
      end
    end

    def includes
      Artist.includes(:commissions).each do |artist|
        artist.name
      end
    end

    puts "ARTISTS WITH COMMISSIONS"
    Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
  end  
end