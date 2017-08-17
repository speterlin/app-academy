require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    raw_data = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL

    raw_data[0].map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method column do
        attributes[column]
        # instance_variable_get("@#{attributes[column]}")
      end
      define_method column.to_s + "=" do |val|
        attributes[column] = val
        # instance_variable_set("@#{attributes[column]}",val)
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= name.tableize
  end

  def self.all
    raw_data = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    SQL
    self.parse_all(raw_data)

  end

  def self.parse_all(results)
    res = []
    results.each do |result|
      res << self.new(result)
    end

    res
  end

  def self.find(id)
    raw_data = DBConnection.execute(<<-SQL, id)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      id = ?
    SQL

    self.parse_all(raw_data)[0]
  end

  def initialize(params = {})
    params.each do |param,value|
      raise "unknown attribute '#{param.to_s}'" unless self.class.columns.include?(param.to_sym)
      send((param.to_s + "=").to_sym,value)
    end
  end

  def attributes
    @attributes ||= {}
    # @attributes ||= Hash.new("#{self.class.name.downcase}s")
  end

  def attribute_values
    self.class.columns.map do |column|
      self.send(column.to_sym)
    end
  end

  def insert
    col_names = self.class.columns.drop(1).join(",")
    question_marks = (["?"] * (self.class.columns.length - 1)).join(",")
    raw_data = DBConnection.execute(<<-SQL, *attribute_values.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id

  end

  def update
    # byebug
    set_columns = self.class.columns.drop(1).map do |attr_name|
      "#{attr_name} = ?"
    end.join(",")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1), self.id)
    UPDATE
      #{self.class.table_name}
    SET
      #{set_columns}
    WHERE
      id = ?
    SQL

  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  c = SQLObject
  c.name = "Nick Diaz"
  p c.name
end
