class ListsController < ApplicationController
  before_action :set_list, only: [ :show, :destroy ]
  before_action :authorize_list!, only: [ :destroy ]

  def index
    @lists = current_user.lists
  end

  def show
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def authorize_list!
    redirect_to lists_path, status: :see_other unless @list.user == current_user
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
