class ContactController < ApplicationController
  def index
  end

  def message

    redirect_to root_path, notice: "Your message has been sent and we will get back with you soon!"
  end
end
