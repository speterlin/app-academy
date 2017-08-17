function sum () {
  var args = Array.prototype.slice.call(arguments);
  var sum = 0;
  args.forEach(function(num) {
    sum += num;
  })
  return sum;
}

console.log(sum(1,2,3,4))
