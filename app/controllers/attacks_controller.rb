class AttacksController < ApplicationController
  # GET /attacks
  # GET /attacks.xml
  def index
    @attacks = Attack.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attacks }
    end
  end

  # GET /attacks/1
  # GET /attacks/1.xml
  def show
    @attack = Attack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attack }
    end
  end

  # GET /attacks/new
  # GET /attacks/new.xml
  def new
    @attack = Attack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attack }
    end
  end

  # GET /attacks/1/edit
  def edit
    @attack = Attack.find(params[:id])
  end

  # POST /attacks
  # POST /attacks.xml
  def create
    @attack = Attack.new(params[:attack])

    respond_to do |format|
      if @attack.save
        format.html { redirect_to(@attack, :notice => 'Attack was successfully created.') }
        format.xml  { render :xml => @attack, :status => :created, :location => @attack }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attacks/1
  # PUT /attacks/1.xml
  def update
    @attack = Attack.find(params[:id])

    respond_to do |format|
      if @attack.update_attributes(params[:attack])
        format.html { redirect_to(@attack, :notice => 'Attack was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attacks/1
  # DELETE /attacks/1.xml
  def destroy
    @attack = Attack.find(params[:id])
    @attack.destroy

    respond_to do |format|
      format.html { redirect_to(attacks_url) }
      format.xml  { head :ok }
    end
  end
end
