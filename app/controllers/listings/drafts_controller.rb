class Listings::DraftsController < ApplicationController
    skip_authorization only: :create

    def create
        @listing = Listing.new(
            listing_params.with_defaults(
                creator: current_user,
                organization: current_user.organizations.first,
                status: :draft
            )
        )

        if @listing.save
            redirect_to listing_path(@listing), flash: { success: t(".success") }, status: :see_other
        else
            render "listings/new", status: :unprocessable_entity
        end
    end

    def update
        @listing.assign_attributes(
            listing_params.with_defaults(
                status: :draft
            )
        )

        if @listing.save
            redirect_to listing_path(@listing), status: :see_other, flash: { success: t(".success") }
        else
            render "listings/edit", status: :unprocessable_entity
        end
    end
    
        
        private

        def listing_params
            params.require(:listing).permit(
                Listing.permitted_attributes
            )
        end

        def authorizable_resource
            @listing = Listing.find(params[:listing_id])
        end
end
