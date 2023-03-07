class UsersController < ApplicationController

  def index
   @users=User.all
  end

  def show
   @user=User.find(params[:id])
   @books=@user.books
  end

  def edit
   user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
   @user=User.find(params[:id])
  end


  def update
   user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
   @user=User.find(params[:id])
    if@user.update(user_params)
     redirect_to user_path(@user.id)
     flash[:notice] = "You have updated user successfully."
    else
     render :edit
    end

  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end


end
