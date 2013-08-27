desc "bm loops, joins, & includes to print attributes from 2 models"
task :benchmark => :environment do
  require 'benchmark'
  include Benchmark

  def loops
    Artifact.all.each do |artifact|
      "A work of art in #{artifact.media} by #{artifact.artist.name}"
      artifact.name.upcase
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
