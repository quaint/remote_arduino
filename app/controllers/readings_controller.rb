class ReadingsController < ApplicationController
  
  skip_before_filter :authorize, :only => :upload
  
  # GET /readings
  # GET /readings.xml
  def index
    @readings = Reading.page(params[:page]).order('created_at desc').per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @readings }
    end
  end

  # GET /readings/filter/serial/12345
  # GET /readings/filter/serial/12345.xml
  def filter_by_serial
  	sensor = Sensor.where(["serial = ?", params[:serial]]).first
    @readings = Reading.where(:sensor_id => sensor.id).paginate(:page => params[:page]).order('created_at desc').per_page(10)
	  render "index"
  end

  # GET /readings/filter/from/01-01-2012/to/02-01-2012
  # GET /readings/filter/from/01-01-2012/to/02-01-2012.xml
  def filter_by_date
    @from_date = Date.strptime(params[:startdate],"%d-%m-%Y")
    @to_date = Date.strptime(params[:enddate],"%d-%m-%Y")
    @readings = Reading.where(["created_at > ? and created_at < ?", @from_date, @to_date]).paginate(:page => params[:page]).order('created_at desc').per_page(10)
	  render "index"
  end

  # GET /readings/1
  # GET /readings/1.xml
  def show
    @reading = Reading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reading }
    end
  end

  # GET /readings/new
  # GET /readings/new.xml
  def new
    @reading = Reading.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reading }
    end
  end

  # GET /readings/1/edit
  def edit
    @reading = Reading.find(params[:id])
  end

  # POST /readings
  # POST /readings.xml
  def create
    @reading = Reading.new(params[:reading])

    respond_to do |format|
      if @reading.save
        format.html { redirect_to(@reading, :notice => 'Reading was successfully created.') }
        format.xml  { render :xml => @reading, :status => :created, :location => @reading }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /readings/upload
  def upload
    @sensor = Sensor.where("serial = ?", params[:serial]).first
    if(@sensor)
      @reading = Reading.new;
      @reading.value = params[:value]
      @reading.sensor = @sensor
      @reading.save
    end
  end

  # PUT /readings/1
  # PUT /readings/1.xml
  def update
    @reading = Reading.find(params[:id])

    respond_to do |format|
      if @reading.update_attributes(params[:reading])
        format.html { redirect_to(@reading, :notice => 'Reading was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.xml
  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to(readings_url) }
      format.xml  { head :ok }
    end
  end
end
