module Breadcrumbs
    extend ActiveSupport::Concern

    included do
        helper_method :breadcrumbs
    end

    class_methods do
        def drop_breadcrumb(*args, **options)
            label, path = args

            before_action(options) do |controller|
                controller.drop_breadcrumb(label, path)
            end
        end
    end

    protected

    def drop_breadcrumb(label, path = nil)
    end

    private

    def breadcrumbs
        @breadcrumbs ||= Trail.new
    end
end