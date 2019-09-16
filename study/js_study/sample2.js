var global = 'Hello, I am a global variable :)';

(function () {
  // 在函数的作用域中下面的变量是私有的

  var myGrades = [93, 95, 88, 0, 55, 91];

  var average = function() {
    var total = myGrades.reduce(function(accumulator, item) {
      return accumulator + item}, 0);

    return 'Your average grade is ' + total / myGrades.length + '.';
  }

  var failing = function(){
    var failingGrades = myGrades.filter(function(item) {
      return item < 70;});

    return 'You failed ' + failingGrades.length + ' times.';
  }

  console.log(failing());
  console.log(global);
}());
/*
要注意的是，一定要用括号把匿名函数包起来，以关键词function开头的语句总是会被解释成函数声明（JS中不允许没有命名的函数声明），而加上括号后，内部的代码就会被识别为函数表达式。其实这个也叫作立即执行函数（IIFE）感兴趣的同学可以在这里了解更多
*/
