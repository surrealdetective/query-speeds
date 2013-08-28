namespace :bm do
  desc "one class' attributes w large intersection, query benchmarking"
  task :queries => :environment do
    require 'benchmark'
    include Benchmark
    include RakeHelper

    %x(rake bm:one_class_large_intersection)
    %x(rake bm:two_class_large_intersection)
    %x(rake bm:one_class_small_intersection)
    %x(rake bm:two_class_small_intersection)
  end
end