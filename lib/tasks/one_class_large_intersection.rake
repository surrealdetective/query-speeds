namespace :bm do
  desc "one class' attributes w large intersection, query benchmarking"
  task :one_class_large_intersection => :environment do
    require 'benchmark'
    include Benchmark

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
    Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
  end  
end