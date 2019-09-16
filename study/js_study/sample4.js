//像下面这样，还有一种创建模块的方法是使用独立的对象接口：

var myGradesCalculate = (function () {

  // 在函数的作用域中下面的变量是私有的
  var myGrades = [93, 95, 88, 0, 55, 91];

  // 通过接口在外部访问下列方法
  // 与此同时这些方法又都在函数内部

  return {
    average: function() {
      var total = myGrades.reduce(function(accumulator, item) {
        return accumulator + item;
        }, 0);

      console.log( 'Your average grade is ' + total / myGrades.length + '.');
    },

    failing: function() {
      var failingGrades = myGrades.filter(function(item) {
          return item < 70;
        });

      console.log( 'You failed ' + failingGrades.length + ' times.');
    }
  }
})();

myGradesCalculate.failing(); // 'You failed 2 times.'
myGradesCalculate.average(); // 'Your average grade is 70.33333333333333.'