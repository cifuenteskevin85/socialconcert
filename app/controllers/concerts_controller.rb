class ConcertsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_same_user, :only => [:update, :destroy, :edit]

  def authenticate_same_user
    @concert = Concert.find(params[:id])
      if current_user == @concert.user
        true
      else
        redirect_to concert_path(@concert), :alert => "You are not authorized to edit this post"
      end
  end
  
  def index

    @concerts = Concert.order("created_at DESC").page(params[:page]).per(6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @concerts }
    end
  end

  def indexforuser
    @concerts = Concert.where("user_id = #{params[:id]}").page(params[:page]).per(3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @concerts }
    end
  end

  def show
    @concert = Concert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @concert }
    end
  end 

  def new
    @concert = Concert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @concert }
    end
  end

  def create
    @concert = Concert.new(params[:concert])

    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: 'Post of Concert was successfully created.' }
        format.json { render json: @concert, concert: :created, location: @concert }
      else
        format.html { render action: "new" }
        format.json { render json: @concert.errors, concert: :unprocessable_entity }
      end
    end
  end

  def edit
    @concert = Concert.find(params[:id])
  end

  def update
    @concert = Concert.find(params[:id])

    respond_to do |format|
      if @concert.update_attributes(params[:concert])
        format.html { redirect_to @concert, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @concert.errors, concert: :unprocessable_entity }
      end
    end
  end

  def destroy
    @concert = Concert.find(params[:id])
    @concert.destroy

    respond_to do |format|
      format.html { redirect_to concerts_url }
      format.json { head :no_content }
    end
  end
end
