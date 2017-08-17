function Clock () {
  this.currentDate = null;
}

Clock.INTERVAL = 2000;

Clock.prototype.run = function () {
  this.currentDate = new Date();
  this.currentDate.displayTime();
  var timer = setInterval(this.tick.bind(this),Clock.INTERVAL);
}

Clock.prototype.tick = function () {
  this.currentDate = new Date(this.currentDate.getTime() + Clock.INTERVAL)
  this.currentDate.displayTime();
}


Date.prototype.displayTime = function () {
  var hours = this.getHours();
  var minutes = this.getMinutes();
  var seconds = this.getSeconds();
  console.log(hours+":"+minutes+":"+seconds);
}

var c = new Clock();
// console.log(c.currentDate);
c.run();

// var i = 1;
// var output = function () {
//   console.log(i++);
// }
// var updater = setInterval(output, 2000);
