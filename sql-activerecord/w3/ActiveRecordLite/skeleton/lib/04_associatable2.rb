require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method name do
      # byebug
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      owner_id_value = send(through_options.foreign_key) #owner_id
      human_match = through_options.model_class.where(through_options.primary_key => owner_id_value)
      human_match = human_match.first

      house_id_value = human_match.send(source_options.foreign_key) #house_id for matched human
      house_match = source_options.model_class.where(source_options.primary_key => house_id_value)

      house_match.first
    end
  end
end
