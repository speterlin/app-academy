class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method name do
        instance_variable_get("@#{name}")
      end
      define_method "#{name}=" do |val|
        instance_variable_set("@#{name}",val)
      end
      # instance_variable_get("@#{name}")
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  AttrAccessorObject.my_attr_accessor("hello")
  u = AttrAccessorObject.new

  p u.methods
  # p AttrAccessorObject.instance_methods
end
