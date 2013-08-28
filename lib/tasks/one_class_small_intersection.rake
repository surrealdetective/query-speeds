namespace :bm do  
  desc "one class' attributes and small intersection, query benchmarking"
  task :one_class_small_intersection => :environment do
    require 'benchmark'
    include Benchmark
    include RakeHelper

    def loops
      Artist.all.each do |artist|
        if artist.commissions.present?
          artist.name
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
    bm_test = Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
  
    bm_hash = parse_times(bm_test).sort_by{ |k,v| v }
    write_partial('_scenario_three.html.erb', bm_hash)
  end  
end