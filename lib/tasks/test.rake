desc "tests the writing of files location as a partial"
task :test_partial => :environment do
  require 'benchmark'
  include Benchmark
  include RakeHelper

  def art(artifact)
    "A work of art in #{artifact.media}"
    artifact.name.upcase
  end

  def loops
    puts 'hi'
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
  bm_test = Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
    tl = x.report("loops:")    { loops }
    tj = x.report("joins:")    { joins }
    ti = x.report("includes:") { includes }
  end

  bm_hash = parse_times(bm_test).sort_by{ |k,v| v }
  write_partial('_scenario_name.html.erb', bm_hash)

end 