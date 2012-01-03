class BoardsController < ApplicationController
  skip_before_filter :authorize, :only => :sync
  
  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    @board = Board.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end
  
  # GET /boards/1/assign
  def assign
    @board = Board.find(params[:id])
  end
  
  # POST /boards/1/assign
  def port
    @board = Board.find(params[:id])
    if @device_old = @board.devices.find_by_port( params[:port][:port] ) 
      @device_old.board = nil
      @device_old.port = nil
      @device_old.save
    end
    if params[:port][:device_id].present?
      @device_new = Device.find(params[:port][:device_id])
      @device_new.board = @board
      @device_new.port = params[:port][:port]
      unless @device_new.save
        redirect_to(assign_board_path(@board), :notice => 'Something went wrong.')
        return
      end
    end
    redirect_to(assign_board_path(@board), :notice => 'Board was successfully updated.')
  end

  # POST /boards
  # POST /boards.xml
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        format.html { redirect_to(@board, :notice => 'Board was successfully created.') }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to(@board, :notice => 'Board was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.xml
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to(boards_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /boards/sync/12345
  def sync
    @board = Board.where("serial = ?", params[:serial]).first
    
    respond_to do |format|
      format.xml { render :xml => @board, :include => [ :devices ], :only => [ :serial, :port, :state ], :skip_types => true }
    end
  end
  
end
