/*
避免全局命名空间污染
明确代码之间的依赖关系
并且这种书写方式也非常舒服友好，我自己很喜欢。

需要注意的一点是，CommonJS以服务器优先的方式来同步载入模块，假使我们引入三个模块的话，他们会一个个地被载入。

它在服务器端用起来很爽，可是在浏览器里就不会那么高效了。毕竟读取网络的文件要比本地耗费更多时间。只要它还在读取模块，浏览器载入的页面就会一直卡着不动。

*/
var myModule = require('./commonjs_lib');

var myModuleInstance = new myModule();
console.log (myModuleInstance.hello()); // 'hello!'
console.log(myModuleInstance.goodbye()); // 'goodbye!'