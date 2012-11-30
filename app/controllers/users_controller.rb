class UsersController < ApplicationController
  def follow
    @user = User.find(params[:id])
    if current_user
      if current_user == @user
        flash[:error] = "You cannot follow yourself."
        respond_to do |format|
          format.html{redirect_to concerts_path ,error: "You cannot follow yourself."}
        end
      else
        if current_user.follow(@user)
          #RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
          #UserMailer.confirm_follow(@user.email).deliver 
          respond_to do |format|
            flash[:error] = "You are now following #{@user.full_name}." 
            format.html{redirect_to concerts_path ,notice: "You are now following #{@user.full_name}."}
            format.js
          end
        else
          respond_to do |format|
            format.html{redirect_to concerts_path ,error: "afafafafafa"}
          end
        end
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
      respond_to do |format|
        format.html{redirect_to concerts_path ,error: "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}."}
      end
    end
  end

  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      respond_to do |format|
        flash[:notice] = "You are no longer following #{@user.full_name}."
        format.js
      end
    else
      respond_to do |format|
        flash[:error] = "You must login to unfollow #{@user.full_name}.".html_safe
        format.js
      end
    end
  end

  def showfollows
    @follows = current_user.all_following

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @follows }
    end
  end
end
