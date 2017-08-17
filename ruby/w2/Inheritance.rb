class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, salary, title, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    # if boss
    #   boss.employees << self
    # end
    if boss
      boss.new_subordinate(self)
    end
  end


  def bonus(multiplier)
    @salary * multiplier
  end

  def inspect
    {:name => @name}.inspect
  end

end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, salary, title, boss)
    super(name, salary, title, boss)
    @employees = []
  end

  def new_subordinate(employee)
    if employee.boss == self
      @employees << employee
    end
  end

  def bonus(multiplier)
    sum = 0
    @employees.each do |employee|
      sum += employee.salary
      if employee.is_a?(Manager)
        employee.employees.each do |sub_employee|
          sum += sub_employee.salary
        end
      end
    end
    sum * multiplier
  end

end

if __FILE__ != $PROGRAM_NAME
  # p "Hello"
  ned = Manager.new('Ned', 1_000_000, 'Founder', nil)
  darren = Manager.new('Darren', 78_000, 'TA Manager', ned)
  david = Employee.new('David', 10_000, 'TA', darren)
  shawna = Employee.new('Shawna', 12_000, 'TA', darren)
end
