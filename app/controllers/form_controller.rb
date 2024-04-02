class FormController < ApplicationController
  def index
  end

  def new
    @fields = session[:fields] || []
  end

  def add_field
    session[:fields] = [] if session[:fields].nil?
    session[:fields] << {'id' => SecureRandom.uuid}.merge(add_field_params)

    redirect_to(action: 'new')
  end

  def remove_field(field_id)
    # TODO: turn fields in session into a hashmap, much better for this kind of manipulation
    session[:fields].delete_if do |field|
      field['id'] == field_id
    end

    redirect_to(action: 'new')
  end

  def show
    render(body: 'show form')
  end

  def create
    if form_submit_params[:remove_field].nil?
      render(body: 'saving form')
    else
      remove_field(form_submit_params[:remove_field])
    end
  end

  private

  def add_field_params
    params[:field].permit(:title, :type)
  end

  def form_submit_params
    params[:form].permit(:title, :remove_field, fields: [:id, :name, :type])
  end
end
