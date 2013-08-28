desc "tests the writing of files location as a partial"
task :test_partial => :environment do
  require 'benchmark'
  include Benchmark

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

  bm_string = bm_test.to_s
  bm_hash = {}
  ['loops', 'joins', 'includes'].each do |qry| 
    start = bm_string.index('(') + 1
    en    = bm_string.index(')') - 1
    bm_hash[qry] = bm_string[start..en].to_f
    bm_string = bm_string[(en+2)..-1] #start again from ,
  end

  f = File.new './app/views/session/_bm_test.html.erb', 'w'
  f << "<% @bm_test = #{bm_hash} %>
        <ul>
          <% @bm_test.sort_by{ |k,v| v }.each do |qry| %>
            <li><%= qry.first.titleize %>: <%= number_to_human(qry.last) %> seconds</li>
          <% end %>
        </ul>"
  f.close
end 