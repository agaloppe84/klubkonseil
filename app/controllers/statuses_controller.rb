class StatusesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :create, :new]
  before_action :set_user


  def show
    @status = Status.find(params[:id])
  end

  def index
  end

  def new
    @user = current_user
    @status = @user.statuses.new
  end

  def create
    @user = current_user
    @status = @user.statuses.new(status_params)
    @status.proposition = @status.which_status
    if @status.save
      redirect_to status_path(@status)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = current_user
  end

  def status_params
    params.require(:status).permit(:q1, :q2, :q3, :q4, :q5, :q6, :q7, :user_id)
  end

end
