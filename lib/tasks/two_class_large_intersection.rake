namespace :bm do
  desc "two class' attributes w large intersection, query benchmarking"
  task :two_class_large_intersection => :environment do
    require 'benchmark'
    include Benchmark

    def art_w_artist(artifact)
      "A work of art in #{artifact.media} by #{artifact.artist.name}"
      artifact.name.upcase
    end

    def loops
      Artifact.all.each do |artifact|
        art_w_artist(artifact)
      end
    end

    def joins
      Artifact.joins(:artist).each do |artifact|
        art_w_artist(artifact)
      end
    end

    def includes
      Artifact.includes(:artist).each do |artifact|
        art_w_artist(artifact)
      end
    end

    puts "ARTIFACTS AND ARTIST NAME"
    Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      tl = x.report("loops:")    { loops }
      tj = x.report("joins:")    { joins }
      ti = x.report("includes:") { includes }
    end
  end  
end