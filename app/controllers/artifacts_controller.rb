class ArtifactsController < ApplicationController
  include ArtifactsHelper

  def one_model
    @benchmark = Benchmark.bmbm do |x|
      x.report("loop")      { Artifact.all                    }
      x.report("joins")     { Artifact.joins(:artist).all     } 
      x.report("includes")  { Artifact.includes(:artist).all  }
    end
  end

  def two_model
    @benchmark = Benchmark.bmbm do |x|
      x.report("joins")     { Artifact.joins(:artist).all     } 
      x.report("includes")  { Artifact.includes(:artist).all  }
    end
  end

  def three_model
    @benchmark = Benchmark.bmbm do |x|
      x.report("joins")    { Artifact.joins(:artist).joins(:category).all       } 
      x.report("includes") { Artifact.includes(:artist).includes(:category).all }
    end
  end

end
