class Student
  attr_accessor :courses

  def initialize(first_name,last_name)
    @first_name, @last_name = first_name, last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def enroll(course)
    if @courses.include?(course)
      #do nothing
      puts "Student already enrolled"
    else
      @courses << course
      course.students = self
    end
  end

  def course_load
    hash = {}
    @courses.each do |course|
      hash[course.department] += course.credits
    end

  end

end

class Course

  attr_accessor :students, :name, :department, :credits

  def initialize(name,department,credits)
    @name,@deparment,@credits = name, department,credits
    @students = []
  end

  def add_student(student)
    if @students.include?(student)
      #do nothing
    else
      student.enroll(self)
      # @students << student
      # student.courses << self
    end
  end


end


bob = Student.new("Bob","Smith")
alex = Student.new("Alex","Smith")
bio = Course.new("Biology","Science",4)
chem = Course.new("Chemistry","Science",3)
bob.enroll(bio)
bob.enroll(bio)
bob.enroll(chem)
# chem.add_student(bob)
# chem.add_student(alex)
p bob.name
p bob.course_load
p alex.course_load
