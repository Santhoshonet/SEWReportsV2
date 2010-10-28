class ProjDetailsController < ApplicationController
  # GET /proj_details
  # GET /proj_details.xml
  def index
    @proj_details = ProjDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proj_details }
    end
  end

  # GET /proj_details/1
  # GET /proj_details/1.xml
  def show
    @proj_detail = ProjDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proj_detail }
    end
  end

  # GET /proj_details/new
  # GET /proj_details/new.xml
  def new
    @proj_detail = ProjDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proj_detail }
    end
  end

  # GET /proj_details/1/edit
  def edit
    @proj_detail = ProjDetail.find(params[:id])
  end

  # POST /proj_details
  # POST /proj_details.xml
  def create
    @proj_detail = ProjDetail.new(params[:proj_detail])

    respond_to do |format|
      if @proj_detail.save
        format.html { redirect_to(@proj_detail, :notice => 'ProjDetail was successfully created.') }
        format.xml  { render :xml => @proj_detail, :status => :created, :location => @proj_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proj_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proj_details/1
  # PUT /proj_details/1.xml
  def update
    @proj_detail = ProjDetail.find(params[:id])

    respond_to do |format|
      if @proj_detail.update_attributes(params[:proj_detail])
        format.html { redirect_to(@proj_detail, :notice => 'ProjDetail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proj_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proj_details/1
  # DELETE /proj_details/1.xml
  def destroy
    @proj_detail = ProjDetail.find(params[:id])
    @proj_detail.destroy

    respond_to do |format|
      format.html { redirect_to(proj_details_url) }
      format.xml  { head :ok }
    end
  end
end
