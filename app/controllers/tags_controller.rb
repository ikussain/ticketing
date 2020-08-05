class TagsController < ApplicationController
  before_action :find_tag, only: [:edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]

  def index
    tags_in_order_with_count
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tag successfully created."
      redirect_to tags_path
    else 
      render :new
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      flash[:success] = "Tag successfully updated."
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end

  private

  def tags_in_order_with_count
    @tags = Tag.left_outer_joins(:ticket_tags).select("tags.*, COUNT(ticket_tags.id)").group("tags.id").order("LOWER(tags.name) ASC")
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def authenticate
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to tags_path
    end
  end
end