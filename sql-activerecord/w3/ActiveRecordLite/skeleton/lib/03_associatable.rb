require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {:foreign_key => ("#{name}_id").downcase.to_sym,
      :class_name => "#{name}".singularize.capitalize, :primary_key => :id}
    attributes = defaults.merge(options)
    @foreign_key = attributes[:foreign_key]
    @class_name = attributes[:class_name]
    @primary_key = attributes[:primary_key]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})

    defaults = { :foreign_key => ("#{self_class_name}".singularize.downcase + "_id").to_sym,
      :class_name => "#{name}".singularize.camelcase,
      :primary_key => :id}
      attributes = defaults.merge(options)
      @foreign_key = attributes[:foreign_key]
      @class_name = attributes[:class_name]
      @primary_key = attributes[:primary_key]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # byebug
    assoc_options[name] = BelongsToOptions.new(name, options)
    define_method name do
      # byebug
      options =  self.class.assoc_options[name]
      foreign_key_value = send(options.foreign_key)
      options_class =  options.model_class
      matches = options_class.where(options.primary_key => foreign_key_value)
      matches.first
    end
  end

  def has_many(name, options = {})

    options = HasManyOptions.new(name, self, options)
    define_method name do
      primary_key_value = send(options.primary_key)
      options_class = options.model_class
      matches = options_class.where(options.foreign_key => primary_key_value)
      matches
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
    # instance_variable_set("@#{self.class}".singularize.downcase,{})
  end
end

class SQLObject
  extend Associatable
end
