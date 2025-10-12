class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_listing, except: %i[new create]

  drop_breadcrumb -> { @listing&.title },
                  -> { listing_path(@listing) },
                  except: [:new, :create]

  def show
  end

  def new
    @listing = Listing.new
    @listing.build_address
    
    drop_breadcrumb t("listings.breadcrumbs.new")
  end

  def create
    drop_breadcrumb t("listings.breadcrumbs.new")

    @listing = Listing.new(
      listing_params.with_defaults(
        creator: current_user,
        organization: current_user.organizations.first,
        status: :published
      )
    )

    if @listing.save
      redirect_to listing_path(@listing), flash: { success: t(".success") }, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    drop_breadcrumb t("listings.breadcrumbs.edit")
  end

  def update
    drop_breadcrumb t("listings.breadcrumbs.edit")

    @listing.assign_attributes(
      listing_params.with_defaults(
        status: :published
      )
    )

    if @listing.save
      flash[:success] = t(".success")
      recede_or_redirect_to listing_path(@listing),
        status: :see_other
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
    params.fetch(:listing, {}).permit(
      Listing.permitted_attributes
    )
  end

  def load_listing
    @listing = Listing.find(params[:id])
  end
end
