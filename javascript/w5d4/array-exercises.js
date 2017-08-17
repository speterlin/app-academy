// function Array {
//   this.my_uniq = function () {
//     this.
//   }
// }

Array.prototype.my_uniq = function() {
  var array = []
  for (i=0;i<this.length;i++) {
    if (array.indexOf(this[i]) < 0) {
      array.push(this[i])
    }
  }
  return array
}

console.log([1,2,2,3,3,4].my_uniq())


Array.prototype.twoSum = function() {
  var array = []
  for (i=0;i<this.length-1;i++) {
    for (j=i+1;j<this.length;j++) {
      if (this[i] + this[j] == 0) {
        array.push([i,j])
      }
    }
  }
  return array
}
console.log([1,-1,2,0,-2].twoSum())

Array.prototype.my_transpose = function() {
  array = []
  for (i=0;i<this.length;i++) {
    array.push([])
  }
  for (i=0;i<this.length;i++) { //row
    for (j=0;j<this[i].length;j++) { //column
      array[j][i] = this[i][j]
    }
  }
  return array
}

console.log([[0, 1, 2],[3, 4, 5],[6, 7, 8]].my_transpose())
