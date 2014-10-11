class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
	
  respond_to do |format|
      format.html
      format.pdf do
	pdf=Prawn::Document.new
	pdf.text "NAME:                              #{@customer.name}"
	pdf.text "MOBILE:                           #{@customer.mobile}"
	pdf.text "ADDRESS:                       #{@customer.address}"
	pdf.text "CHECK IN DATE:             #{@customer.check_in_date}"
	pdf.text "ROOM TYPE:                   #{@customer.room_type}"
        pdf.text "TAX:                         #{@tax}"
        pdf.text "TOTAL                       #{@total}"
	send_data pdf.render,filename: "#{@customer.name}_receipt.pdf",type: "application/pdf",disposition: "inline"
	end
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @days     = params[:no_of_days].to_i
    @room     = params[:room_type]
    if @room="AC" then
       @price=750.0
    
     else
       @price=600.0
     end
   @tax=@price * 0.14
   @total=@tax + @price
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :mobile, :address, :check_in_date, :no_of_days, :room_type)
    end
end
