module Conversation::AccessPolicy
  def show?(_user = nil)
    Current.organization == seller || Current.organization == buyer
  end

  def can_message?(_user = nil)
    show?
  end
end
