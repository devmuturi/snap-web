class FeedController < ApplicationController
  def show
    @listings = Listing.feed.first(12)
  end
end
