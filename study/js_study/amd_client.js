define(['./amd_lib', './amd_lib2'], function(myModule, myOtherModule) {
   console.log(myModule.hello());
 });
/*
amd_lib', './amd_lib2 在浏览器端会被同时加载，甚至有工具会把node端同步加载的语法转换为对浏览器友好的异步加载

As you can see, there are significant differences between the browser module systems (AMD) and the Node.js module
system (CommonJS). However, the good news is that the Node.js community has developed a number of tools to take
your CommonJS / Node.js code and transform it to be AMD / RequireJS compatible. The most commonly used one
(and the one on which other tools rely) is Browserify (http://browserify.org/).

除了异步加载以外，AMD的另一个优点是你可以在模块里使用对象、函数、构造函数、字符串、JSON或者别的数据类型，而CommonJS只支持对象。

再补充一点，AMD不支持Node里的一些诸如 IO,文件系统等其他服务器端的功能。另外语法上写起来也比CommonJS麻烦一些。
*/
