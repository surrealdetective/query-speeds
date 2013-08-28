class SessionController < ApplicationController
  def new

  end

  def show
    @selected_queries = [ selected_qry(params["s1"]),
                          selected_qry(params["s2"]),
                          selected_qry(params["s3"]),
                          selected_qry(params["s4"])]
  end

  def create
    system "rake queries" # &" should spin a new rails env to run rake task, but & not yet working. Also see call_rake method. 
    flash[:notice] = "Thanks for waiting! Please note the new times!"
    redirect_to session_path
  end

  private

  def selected_qry(num)
    case num
    when "1"
      "Loops"
    when "2"
      "Joins"
    when "3"
      "Includes"
    end
  end

end



