module ArtifactsHelper
  require "benchmark"
  # include Benchmark

  # def timer(method)
  #   start = Time.now.subsec
  #   method
  #   diff = (Time.now.subsec - start).to_f
  # end

  def timer(method)
    Benchmark.bm do |x|
      x.report { method }
    end
  end
end
