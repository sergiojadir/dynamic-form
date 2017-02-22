class DateField < FormField
	def add_validation_erros(form_value)
		return if form_value.blank?

		unless valid_date?(value)
			form_value.errors.add :value, 'must be a valid date'
			return
		end

		date = Date.parse(value)

		if min.present?
			min_date = Date.parse(min)
			form_value.errors.add :value, "can't be before #{min}" if date < min_date
		end

		if max.present?
			max_date = Date.parse(max)
			form_value.errors.add :value, "can't be after #{max_date}" if date > max_date
		end
	end

	private

	def valid_date?(date_string)
		date_components = date_string.split('-').first(3).map(&:to_i)
		return false unless date_components.size == 3 && date_components.all?

		Date.valid_date?(*date_components)
	end
end