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

  def edit
    @form = Form.eager_load(:fields).find(params[:id])
  end

  def create
    if form_submit_params[:remove_field].nil?
      save_form
    else
      remove_field(form_submit_params[:remove_field])
    end
  end

  private

  def save_form
    f = Form.new(form_submit_params.except(:fields))
    f.fields = form_submit_params['fields'].map {|field| Field.new(id: field['id'], name: field['name'], field_type: field['field_type'].to_sym)}

    f.save!

    session[:fields] = []

    redirect_to edit_form_path(f)
  end

  def add_field_params
    params[:field].permit(:name, :field_type)
  end

  def form_submit_params
    params[:form].permit(:title, :remove_field, fields: [:id, :name, :field_type])
  end
end
