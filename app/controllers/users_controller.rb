class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
  
  def my_friends
    @friends = current_user.friends
  end

  def search
    
    if  params[:search_string].present?
      @search_results = User.search(params[:search_string])
      @search_results = current_user.except_current_user(@search_results)
      if @search_results
        respond_to do |format|
          format.js { render partial: 'friends/result'}
        end
      else
        flash[:alert] = "Friend not found" 
        redirect_to my_friends_path
      end
    else
      flash[:alert] = "Please enter an email" 
      redirect_to my_friends_path
    end  
    
  end

end
