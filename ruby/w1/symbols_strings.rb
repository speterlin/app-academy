require 'byebug'
def super_print(string,options = {})
  # debugger
  defaults = {:times => 3, :upcase =>false, :reverse => false}
  final = defaults.merge(options)
  #options.merge(defaults) #options ={},
  string *= final[:times]
  string = string.upcase if final[:upcase]
  string = string.reverse if final[:reverse]
  string
end
