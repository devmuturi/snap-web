class FeedController < ApplicationController
  def show
    @search = Listings::Search.new
    @pagy, @listings = pagy(Listing.feed)
  end
end
