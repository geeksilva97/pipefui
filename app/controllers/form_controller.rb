class FormController < ApplicationController
  def index
    @form_list = Form.all
  end

  def new
    @fields = session[:fields] || []
  end

  def answer
    @answers = Answer.where(form_id: params[:form_id])
  end

  def full_answer
    @answer_values = AnswerValue.where(answer_id: params[:id])
  end

  def update
    if form_submit_params[:remove_field].nil?
      update_form(params[:id])
    else
      field_id = form_submit_params[:remove_field]
      remove_field(field_id)

      Field.delete(field_id)

      redirect_to(action: 'edit')
    end
  end

  def add_field
    session[:fields] = [] if session[:fields].nil?
    session[:fields] << {'id' => SecureRandom.uuid}.merge(add_field_params)

    redirect_back(fallback_location:"/")
  end

  def remove_field(field_id)
    # TODO: turn fields in session into a hashmap, much better for this kind of manipulation
    session[:fields].delete_if do |field|
      field['id'] == field_id
    end
  end

  def edit
    @form = Form.eager_load(:fields).find(params[:id])
    @fields = @form.fields + session[:fields]
  end

  def create
    if form_submit_params[:remove_field].nil?
      save_form
    else
      remove_field(form_submit_params[:remove_field])

      redirect_to(action: 'new')
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

  def update_form(form_id)
    Form.update(form_id, title: form_submit_params['title'])

    fields = form_submit_params['fields'].map {|field| {id: field['id'], name: field['name'], field_type: field['field_type'], form_id: form_id}}

    Field.upsert_all(fields)

    session[:fields] = []

    redirect_to edit_form_path(form_id)
  end

  def add_field_params
    params[:field].permit(:name, :field_type)
  end

  def form_submit_params
    params[:form].permit(:title, :remove_field, fields: [:id, :name, :field_type])
  end
end
