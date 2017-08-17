range = function(start, end) {
  if (end < start) {
    return []
  }
  var prev = range(start+1, end)
  prev.unshift(start)

  return prev
}
array = range(0,5)
// console.log(array)

arraySum = function(nums) {
  // console.log(nums == [])
  if (nums.length == 0) {
    return 0;
  }

  return (nums.pop() + arraySum(nums));
}
res = arraySum([1,2,3,4])
// console.log(res)


exp = function (b,n) {
  if (n == 0) {
    return 1;
  } else if (n == 1) {
    return b;
  }
  if (n % 2 == 0) {
    return Math.pow(exp(b, n / 2), 2)
  } else {
    return Math.pow(b * (exp(b, (n - 1) / 2)), 2)
  }
}

// console.log(exp(2,2))

fibonacci = function (n) {
  if (n == 1) {
    return [0];
  } else if (n == 2) {
    return [0,1];
  }
  var prev = fibonacci(n-1)
  var val = prev[prev.length-2] + prev[prev.length-1];
  return prev.concat([val]);
}

// console.log(fibonacci(10));

bsearch = function (array, target) {
  // console.log(array, array[0], array.length, target)
  if (array.length == 0) {
    return "nil";
  }
  // console.log(array[0], target)
  if (target == array[0]) {
    return 0;
  }
  var middle = array.length / 2;
  //split array
  var left = array.slice(0, middle);
  var right = array.slice(middle, array.length);
  // console.log(left, right)
  if (target < right[0]) {
    return bsearch(left, target);
  } else {
    return left.length + bsearch(right, target);
  }
}
// console.log(bsearch([1, 2, 3, 4, 5, 6], 0))
// console.log( bsearch([1, 2, 3, 4, 5, 6], 6))

// makeChange
function makeChange (target, coins) {
  if (target === 0) {
    return [];
  }

  var bestChange = null;

  function reverseSorter (a, b) {
    if (a < b) {
      return 1;
    } else if (a > b) {
      return -1;
    } else {
      return 0;
    }
  }

  coins.sort(reverseSorter).forEach(function(coin, index) {
    if (coin > target) {
      return;
    }

    var remainder = target - coin;
    // remember the optimization where we don't try to use high coins
    // if we're already using a low one?
    var restChange = makeChange(remainder, coins.slice(index));

    var change = [coin].concat(restChange);
    if (!bestChange || (change.length < bestChange.length)) {
      bestChange = change;
    }
  });

  return bestChange;
}

console.log(makeChange(14,[10,7,2]))


// merge, mergeSort
function merge (left, right) {
  var merged = [];

  while (left.length > 0 && right.length > 0) {
    var nextItem = (left[0] < right[0]) ? left.shift() : right.shift();
    merged.push(nextItem);
  }

  return merged.concat(left, right);
}

function mergeSort (array) {
  if (array.length < 2) {
    return array;
  } else {
    var middle = Math.floor(array.length / 2);

    var left = mergeSort(array.slice(0, middle));
    var right = mergeSort(array.slice(middle));

    return merge(left, right);
  }
}

console.log("mergeSort([4, 5, 2, 3, 1]) = " + mergeSort([4, 5, 2, 3, 1]));

// subsets
function subsets (array) {
  if (array.length === 0) {
    return [[]];
  }
  var firstElement = array[0];
  var subSubsets = subsets(array.slice(1));

  var newSubsets = subSubsets.map(function(subSubset) {
    return [firstElement].concat(subSubset);
  });

  return subSubsets.concat(newSubsets);
}

console.log(subsets([1,2]))
