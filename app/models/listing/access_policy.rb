module Listing::AccessPolicy
    def show?(user)
        true
    end

    def edit?(user)
        return false unless user.present?
        user.organizations.exists?(organization.id)
    end

    def update?(user)
        return false unless user.present?

        user.organizations.exists?(organization.id)
    end

    def destroy?(user)
        return false unless user.present?

        user.organizations.exists?(organization.id)
    end

    def can_save?(user)
        return false unless user.present?
        !user.organizations.exists?(organization.id)
    end
end