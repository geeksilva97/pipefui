class FormAnswerController < ApplicationController
  def show
    @form_data = Form.eager_load(:fields).find(params[:id])
  end

  def answer
    first_field = answer_params[0]
    form_id = params[:id]
    form = Form.find(form_id)

    ActiveRecord::Base.transaction do
      answer = Answer.create!(form: form, preview: "#{first_field['name']}: #{first_field['value']}")
      AnswerValue.insert_all!(answer_params.map do |answer_data|
        {
          field_id: answer_data['id'],
          form_id: form_id,
          answer_id: answer.id,
          field_name: answer_data['name'],
          field_value: answer_data['value'],
        }
      end)

    end


    render(body: 'registrando sua resposta')
  end

  private

  def answer_params
    params.require(:answer).permit(
      params[:answer].keys.map do |key|
        { key => [:value, :name, :id] }
      end
    ).values
  end

end
