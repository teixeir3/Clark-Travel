class GermanCruisingForm
  include ActiveModel::Model

  # TODO Need to add attribute validations

  def send_email
    UserMailer.german_cruising_form_email(self).deliver
  end
end