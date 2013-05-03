class MessageQueuesController < ApplicationController
  # GET /message_queues
  # GET /message_queues.json
  def index
    @message_queues = MessageQueue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_queues }
    end
  end

  # GET /message_queues/1
  # GET /message_queues/1.json
  def show
    @message_queue = MessageQueue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_queue }
    end
  end

  # GET /message_queues/new
  # GET /message_queues/new.json
  def new
    @message_queue = MessageQueue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_queue }
    end
  end

  # GET /message_queues/1/edit
  def edit
    @message_queue = MessageQueue.find(params[:id])
  end

  # POST /message_queues
  # POST /message_queues.json
  def create
    @message_queue = MessageQueue.new(params[:message_queue])

    respond_to do |format|
      if @message_queue.save
        format.html { redirect_to @message_queue, notice: 'Message queue was successfully created.' }
        format.json { render json: @message_queue, status: :created, location: @message_queue }
      else
        format.html { render action: "new" }
        format.json { render json: @message_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_queues/1
  # PUT /message_queues/1.json
  def update
    @message_queue = MessageQueue.find(params[:id])

    respond_to do |format|
      if @message_queue.update_attributes(params[:message_queue])
        format.html { redirect_to @message_queue, notice: 'Message queue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_queues/1
  # DELETE /message_queues/1.json
  def destroy
    @message_queue = MessageQueue.find(params[:id])
    @message_queue.destroy

    respond_to do |format|
      format.html { redirect_to message_queues_url }
      format.json { head :no_content }
    end
  end
end
