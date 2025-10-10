class MyListingsController < ApplicationController
    before_action :authenticate_user!

    def show
        organization = current_user.organizations.first
        @pagy, @listings = pagy(organization.listings)
    end
end
