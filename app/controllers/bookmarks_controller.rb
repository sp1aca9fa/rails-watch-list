class BookmarksController < ApplicationController
  before_action :set_list, only: [ :new, :create ]
  before_action :set_bookmark, only: [ :edit, :update, :destroy ]
  before_action :authorize_bookmark!, only: [ :edit, :update, :destroy ]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to list_path(@bookmark.list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def authorize_bookmark!
    redirect_to lists_path, status: :see_other unless @bookmark.list.user == current_user
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :rating, :movie_id, :list_id)
  end
end
