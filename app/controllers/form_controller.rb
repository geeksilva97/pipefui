class FormController < ApplicationController
  def index
  end

  def new
    @fields = session[:fields] || []
  end

  def add_field
    session[:fields] = [] if session[:fields].nil?
    session[:fields] << {'id' => SecureRandom.uuid}.merge(params[:field].permit(:title, :type))

    redirect_to(action: 'new')
  end

  def show
    render(body: 'show form')
  end

  def create
    puts "received a request"

    session[:fields] = []

    redirect_to(action: 'show', id: 100)
  end
end
