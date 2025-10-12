class MyListingsController < ApplicationController
    before_action :authenticate_user!

    drop_breadcrumb I18n.t("my_listings.show.title")

    def show
        organization = current_user.organizations.first
        @pagy, @listings = pagy(organization.listings)
    end
end
