/*
另一种比较受欢迎的方法是一些诸如jQuery的库使用的全局引入。和我们刚才举例的匿名闭包函数很相似，只是传入全局变量的方法不同：
*/
var globalVariable = Object();
(function (globalVariable) {

  // 在函数的作用域中下面的变量是私有的
  var privateFunction = function() {
    console.log('Shhhh, this is private!');
  }

  // 通过全局变量设置下列方法的外部访问接口
  // 与此同时这些方法又都在函数内部

  globalVariable.each = function(collection, iterator) {
    if (Array.isArray(collection)) {
      for (var i = 0; i < collection.length; i++) {
        iterator(collection[i], i, collection);
      }
    } else {
      for (var key in collection) {
        iterator(collection[key], key, collection);
      }
    }
  };

  globalVariable.filter = function(collection, test) {
    var filtered = [];
    globalVariable.each(collection, function(item) {
      if (test(item)) {
        filtered.push(item);
      }
    });
    return filtered;
  };

  globalVariable.map = function(collection, iterator) {
    var mapped = [];
    globalUtils.each(collection, function(value, key, collection) {
      mapped.push(iterator(value));
    });
    return mapped;
  };

  globalVariable.reduce = function(collection, iterator, accumulator) {
    var startingValueMissing = accumulator === undefined;

    globalVariable.each(collection, function(item) {
      if(startingValueMissing) {
        accumulator = item;
        startingValueMissing = false;
      } else {
        accumulator = iterator(accumulator, item);
      }
    });

    return accumulator;

  };

 }(globalVariable));

 var myGrades = [93, 95, 88, 0, 55, 91];
 var failing = function(){
   var failingGrades = globalVariable.filter(myGrades,function(item) {
     return item < 70;});

   return 'You failed ' + failingGrades.length + ' times.';
 }
 console.log(failing());
