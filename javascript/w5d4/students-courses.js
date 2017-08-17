var Student = function (fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

Student.prototype.name = function () {
  return this.fname + " " + this.lname;
}

Student.prototype.course_names = function() {
  this.courses.forEach(function(course) {
    console.log(course.name)
  })
}

Student.prototype.enroll = function (course) {
  if (this.courses.indexOf(course) >= 0 ) {
    throw "Student already enrolled";
    return;
  } else {
    this.courses.push(course);
    course.students.push(this);
  }
}

Student.prototype.course_load = function () {
  var hash = {}
  this.courses.forEach(function(course) {
    if (hash[course.department]) {
      hash[course.department] += course.credits
    } else {
      hash[course.department] = course.credits;
    }
  })
  return hash
}

function Course (name, department, credits) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.add_student = function (student) {
  student.enroll(this)
}

Course.prototype.student_names = function () {
  this.students.forEach(function(student) {
    console.log(student.name())
  })
}

var hans = new Student('Hans', 'Zimmer');
var ben = new Student('Ben', 'Wyatt');

var chem1 = new Course('Chemistry 1', 'Science', 4);
var bio1 = new Course('Biology 1', 'Science', 3);
var hist1 = new Course('History 1', 'Social Science', 5);

console.log(hans.name());

hans.enroll(chem1)
hans.course_names();
console.log(chem1.students)
// hans.enroll(chem1); // should throw error
hans.enroll(bio1);
hans.enroll(hist1);
console.log(hans.course_load());
ben.enroll(bio1);
bio1.student_names();
