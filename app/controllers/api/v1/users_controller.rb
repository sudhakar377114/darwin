class Api::V1::UsersController < ApplicationController

  def show
    @user = User.where(id: params[:id]).first
  end

end