class FormField < ApplicationRecord
	belongs_to :formable, polymorphic: true

	validates :type, presence: true

	def validate_value(form_value)
		form_value.errors.add :value, "cant't be blank" if required? && form_value.value.blank?

		add_validation_errors(form_value)
		form_value
	end

	def add_validation_errors(form_value)
		fail NotImplementedError
	end
end