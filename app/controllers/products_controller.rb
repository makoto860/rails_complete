class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.image.attached?
      @product.image.attach(params[:product][:image])
    else
      @product.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'no_image.png')), 
                        filename: 'no_image.png', 
                        content_type: 'image/png')
    end

    if @product.save
      flash[:success] = "productを登録しました"
      redirect_to :products, id: @product.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    @reservations = @product.reservations
    @reservation = @reservations.new
  end

  def index
    @products = Product.where('address LIKE(?)',"%#{params[:address]}%")
   if params[:keyword].present?
     @products = Product.where([ 'content LIKE ? OR name LIKE ? ',"%#{params[:keyword]}%","%#{params[:keyword]}%" ])
   end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.user_id = current_user.id

    if @product.update(product_params)
      flash[:success] = "productを更新しました。"
      redirect_to :products, id: @product.id
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.reservations.destroy_all
    @product.destroy
    flash[:success] = "productを削除しました"
    redirect_to :products
  end

  private
    def product_params
      params.require(:product).permit(:name, :content, :amount, :address, :image, :user_id)
    end
end
