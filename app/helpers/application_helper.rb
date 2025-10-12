module ApplicationHelper
    include Pagy::Frontend

  def show_paginator?(pagy)
    pagy.present? && pagy.pages > 1
  end
end
