class SearchController < ApplicationController
  def index
    @search = Search.new
  end

  def search
    @username = params[:search][:username]
    @github_url = "https://github.com/"+@username

    begin
      get_github_response = RestClient.get @github_url
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
    test = Search.find_by_username(@username)
    if test 
      test.count +=1
      test.save
    else
      yeni = Search.new
      yeni.username = @username
      yeni.count = 1
      yeni.save
    end

    redirect_to @github_url unless e

  end

  def list
    @all_list = Search.all.order('count DESC')
  end
end
