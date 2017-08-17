require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable

  def where(params)
    where_line = params.map do |key,value|
      "#{key} = ?"
    end.join(" AND ")

    raw_data = DBConnection.execute(<<-SQL, *params.values)
    select
      *
    from
      #{self.table_name}
    where
      #{where_line}
    SQL
    parse_all(raw_data)
  end
end

class SQLObject
  extend Searchable



end
