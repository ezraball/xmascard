class CardsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :update, :create]
  
  
  # GET /cards
  # GET /cards.json
  def index
    @style ||= 'thumb'
    setup_index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end
  
  def list
    @style = 'list'
    setup_index
    render action: :index
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])
    @main_image_method = 'frontimg'
    @tiny_image_method = 'backimg'
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  def back
    @card = Card.find(params[:id])
    @main_image_method = 'backimg'
    @tiny_image_method = 'frontimg'

    respond_to do |format|
      format.html {
        render template: 'cards/show'
      }# show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end
  
  protected
  def setup_index
    if params[:fingerprint]
      @card = Card.where(:fingerprint => params[:fingerprint])
    elsif params[:tag]
      @cards = Card.tagged_with(params[:tag])
    else
      @cards = Card.where(" 1 = 1 ")
    end
    @cards = @cards.paginate(:page => params[:page], :per_page => 20)    
  end
end
