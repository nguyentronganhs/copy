class Feature

	def self.enabled name
		Setting.plugin_redhopper.present? &&
		Setting.plugin_redhopper["features"].present? &&
		Setting.plugin_redhopper["features"][name]
	end

end
