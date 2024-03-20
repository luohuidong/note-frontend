- 块级作用域
- 词法环境；块级作用域通过词法环境实现

[[从执行上下文的角度来看变量提升]]导致有很多 JavaScript 代码的执行结果与直觉不符，例如下面这个例子：

```js
var foo = 'foo1'
function bar() {
  console.log(foo)
  if (0) {
    var foo = 'foo2'
  }
  console.log(foo)
}
bar()
```

当执行上面的代码的时候，输出的结果都是 `undefined`
