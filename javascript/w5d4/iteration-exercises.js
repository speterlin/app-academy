Array.prototype.bubbleSort = function() {
  for (var i=0;i<this.length-1;i++) {
    if (this[i+1] < this[i]) {
      val = this[i]
      this[i] = this[i+1]
      this[i+1] = val
      i=0
    }
  }
  return this
}

String.prototype.substrings = function() {
  array = []
  for (var i=0;i<this.length;i++) {
    var j=i+1;
    for (j;j<=this.length;j++) {
      array.push(this.slice(i,j))
    }
  }
  return array
}

console.log([1,4,2,5,3].bubbleSort())

console.log("cat".substrings())
