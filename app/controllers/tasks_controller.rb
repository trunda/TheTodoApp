class TasksController < ApplicationController
  respond_to :json

  def index
    respond_with(@tasks = Task.order("position"))
  end

 def show
    respond_with Task.find(params[:id])
  end

  def create
    respond_with Task.create(params[:task])
  end

  def update
    respond_with Task.update(params[:id], params[:task])
  end

  def destroy
    respond_with Task.destroy(params[:id])
  end

  def sort
    params[:tasks].each do |key, item|
      Task.update(item[:id], {:position => item[:position]})
    end
    render nothing: true
  end

  def hp
    respond_to do |f|
      f.html
    end
  end
end
