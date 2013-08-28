class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  #call_rake improves the "system rake task &" pattern currently used
  #However, & isn't working and reluctant to try this before that works.  
  
  # def call_rake(task, options = {})
  #   options[:rails_env] ||= Rails.env
  #   args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
  #   system "/usr/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  # end
end
