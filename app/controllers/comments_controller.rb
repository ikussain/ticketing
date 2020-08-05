class CommentsController < ApplicationController
  before_action :authenticate
  
  def create
    @comment = Comment.new(comment_body)
    @comment.creator = current_user
    @ticket = Ticket.find(params[:ticket_id])
    @comment.ticket = @ticket

    unless @comment.save
      render :edit and return
    end

    if params[:comment][:ticket_status].present?
      @ticket = Ticket.find(params[:ticket_id])
      @ticket.status = params[:comment][:ticket_status]
      @ticket.save
    end

    flash[:success] = "Comment created."
    redirect_to ticket_path(params[:ticket_id])
  end

  def edit
    @comment = Comment.find(params[:id])
    validate_user
    @ticket = Ticket.find(params[:ticket_id])
  end

  def update
    @comment = Comment.find(params[:id])
    validate_user
    @comment.body = params[:comment][:body]
    unless @comment.save
      render :edit
    end

    if params[:comment][:ticket_status].present?
      @ticket = Ticket.find(params[:ticket_id])
      @ticket.status = params[:comment][:ticket_status]
      @ticket.save
    end

    flash[:success] = "Comment updated."
    redirect_to ticket_path(params[:ticket_id])
  end

  private

  def authenticate
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to ticket_path(params[:ticket_id])
    end
  end

  def validate_user
    if current_user.id != @comment.creator.id
      flash[:error] = "You can only edit your own comments."
      redirect_to ticket_path(params[:ticket_id])
    end
  end

  def comment_body
    params.require(:comment).permit(:body)
  end
end