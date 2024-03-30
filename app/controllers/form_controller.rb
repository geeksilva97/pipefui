class FormController < ApplicationController
  def index
  end

  def new
  end

  def show
    render(body: 'show form')
  end

  def create
    puts "received a request"

    redirect_to(action: 'show', id: 100)
  end
end
