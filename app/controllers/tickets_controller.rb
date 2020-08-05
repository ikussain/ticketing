class TicketsController < ApplicationController
  before_action :find_ticket, only: [:show, :update, :edit, :destroy]
  before_action :authenticate, except: [:index, :show]

  def index
    @tickets = Ticket.all

    if params[:tag_id].present?
      @tickets = Tag.find(params[:tag_id]).tickets
      @tag = params[:tag_id]
    end

    if params[:ticket]
      @tickets = @tickets.where(filter_params.reject { |k,v| v.blank? })
      @project_id = filter_params[:project_id]
      @status = filter_params[:status]
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.creator = @current_user
    
    if @ticket.save
      flash[:success] = "Ticket created successfully."
      redirect_to tickets_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new 
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket updated successfully."
      redirect_to tickets_path
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private

  def filter_params
    params.require(:ticket).permit(:project_id, :status)
  end

  def ticket_params
    params.require(:ticket).permit(:project_id, :status, :name, :body, :assignee_id, :tag_ids => [])
  end
  
  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def authenticate
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to tickets_path
    end
  end
end