class SavedListingsController < ApplicationController
    before_action :load_listing, except: :show

    def show
        drop_breadcrumb t(".title")

        @pagy, @listings = pagy(current_user.saved_listings)

        render :show
    end

    def create
        authorize! @listing.can_save?(current_user)

        current_user.saved_listings << @listing
    end

    def destroy
        authorize! @listing.can_save?(current_user)
        
        current_user.saved_listings.destroy(@listing)
    end

    private

    def default_render
        render turbo_stream: turbo_stream.update(
            "save_button",
            partial: "listings/save_button",
            locals: {
                listing: @listing
            }
        )
    end

    def load_listing
        @listing = Listing.find(params[:listing_id])
    end
end
