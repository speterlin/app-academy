Array.prototype.myEach = function (func) {
  for (var i=0;i<this.length;i++) {
    func(this[i]);
  }

  return this;
}

console.log([1,2,3].myEach (function(num) {
  console.log(num *2)
}))


Array.prototype.myMap = function (func) {
  var array = [];
  function addVal (val) {
    value = func(val)
    array.push(value);
  }

 // run the addval function for each num
 this.myEach(addVal);

  return array
}

addTwo = function(num) {
  return num + 2
}

console.log([1,2,3].myMap(addTwo))

Array.prototype.myInject = function (func) {
  // var sum = 0
  var sum = this[0]
  function sumInject(num) {
    sum = func(sum,num)
  }

  this.slice(1,this.length).myEach(sumInject)

  return sum
}

addSum = function (sum, num) {
  return sum + num
}

console.log([1,2,4].myInject(addSum))
