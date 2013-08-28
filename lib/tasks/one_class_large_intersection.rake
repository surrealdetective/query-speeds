namespace :bm do
  desc "one class' attributes w large intersection, query benchmarking"
  task :one_class_large_intersection => :environment do
    require 'benchmark'
    include Benchmark
    include RakeHelper

    def art(artifact)
      "A work of art in #{artifact.media}"
      artifact.name.upcase
    end

    def loops
      Artifact.all.each do |artifact|
        art(artifact)
      end
    end

    def joins
      Artifact.joins(:artist).each do |artifact|
        art(artifact)
      end
    end

    def includes
      Artifact.includes(:artist).each do |artifact|
        art(artifact)
      end
    end

    puts "ARTIFACTS"
    bm_t = Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
    
    bm_hash = parse_times(bm_t).sort_by{ |k,v| v }
    write_partial('_scenario_one.html.erb', bm_hash)
  end  
end