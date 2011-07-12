require 'digest'

class ContentsController < ApplicationController
  # GET /contents
  # GET /contents.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def search
    @content = Content.find_by_code(params[:code])
    if Time.now.to_i > @content.expiration.to_i
      @content = nil
    end unless @content.nil?

    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @content }
    end
  end
  
  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])
    if Time.now.to_i - @content.created_at.to_i < 20

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  else
    redirect_to '/'
  end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @content.code = Digest::SHA1.hexdigest(Time.now.to_s)[0..5]
    EmailMailer.send_email(params[:this][:user], @content.code)

    respond_to do |format|
      if @content.save
        format.html { redirect_to(@content, :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    @content = Content.find(params[:id])

    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to(@content, :notice => 'Content was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end
end
