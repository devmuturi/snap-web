class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_listing, except: %i[new create]

  def show
  end

  def new
    @listing = Listing.new
    @listing.build_address
  end

  def create
    @listing = Listing.new(
      listing_params.with_defaults(
        creator: current_user,
        organization: current_user.organizations.first
      )
    )

    if @listing.save
      redirect_to listing_path(@listing), flash: { success: t(".success") }, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@listing), flash: { success: t(".success") }, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    flash[:success] = t(".success")
    redirect_to my_listings_path, status: :see_other
  end

  private

  def listing_params
    params.require(:listing).permit(
      Listing.permitted_attributes
    )
  end

  def load_listing
    @listing = Listing.find(params[:id])
  end
end
