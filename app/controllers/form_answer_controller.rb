class FormAnswerController < ApplicationController
  def show
    @form = Form.eager_load(:fields).find(params[:id])
  end

  def answer
    render(body: 'registrando sua resposta')
  end
end
