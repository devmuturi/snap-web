class Users::RegistrationsController < Devise::RegistrationsController
    def create
        super do |user|
            if user.persisted?
                # Create organization after successfully saves
                Organization.create(members: [user])
            end
        end
    end
end
