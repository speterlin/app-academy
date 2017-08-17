function curriedSum (numArgs) {
  var numbers = [];

  function _curriedSum (number) {
    // console.log(numbers, number, numArgs);
    numbers.push(number);
    if (numbers.length == numArgs) {
      // console.log(numbers);
      var sum = 0;
      numbers.forEach(function (num) { sum += num });
      return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}


var sum = curriedSum(4);
console.log(sum(5)(30)(20)(1)); // => 56

Function.prototype.curry = function(numArgs) {
  var numbers = [];
  var fn = this;
  function _curry (number) {
    numbers.push(number)
    if (numbers.length == numArgs) {
      return fn.apply(fn,numbers);
    } else {
      return _curry;
    }
  }

  return _curry;
}

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

// console.log(sumThree([1,2,3].join(",")))

console.log(sumThree.curry(3)(4)(20)(6)); // == 30
