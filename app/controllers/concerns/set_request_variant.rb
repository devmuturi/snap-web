module SetRequestVariant
  extend ActiveSupport::Concern

  included do
    before_action :set_request_variant
  end

  private

  def set_request_variant
    browser = Browser.new(request.user_agent)
    if browser.device.mobile?
      request.variant = :mobile
    elsif browser.device.tablet?
      request.variant = :tablet
    else
      request.variant = :desktop
    end
  end
end
