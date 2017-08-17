var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps == true) {
      innerBubbleSortLoop(arr,0,false,outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
}

function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is "+el1+" greater than "+el2+"?: ", function(inputString) {
    if (inputString == "yes") {
      callback(true);
    } else {
      callback(false);
    }
  })
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i == (arr.length-1)) {
    outerBubbleSortLoop(madeAnySwaps)
  } else {
    askIfGreaterThan(arr[i], arr[i+1], function(isGreaterThan) {
      if (isGreaterThan == true) {
        var val = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = val;
        madeAnySwaps = true;
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop)
      } else {
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop)
      }
    })
  }
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
