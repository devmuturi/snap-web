class FeedController < ApplicationController
  def show
    @pagy, @listings = pagy(Listing.feed)
  end
end
