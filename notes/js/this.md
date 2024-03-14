# this

`this` 的指向比较灵活多变，以下是 `this` 的指向规则：

1. 在函数体中，非显式或隐式地简单调用函数时，在[[strict-mode]]下，函数内的 `this` 会被绑定到 `undefined`。在非严格模式下则会被绑定到全局对象 window/global 上。
2. 使用 `call`、`apply`、`bind` 方法调用函数时，函数内的 `this` 会被绑定到指定参数的对象上。
3. 使用 `new` 方法调用构造函数时，构造函数内的 `this` 会被绑定到新创建的对象上。
4. 通过上下文对象调用函数时，函数体内的 `this` 会被绑定到该对象上。
5. 在箭头函数中，`this` 的指向是由外层（函数或全局）作用域来决定的。

要理解好上面几点，需要对[[strict-mode]]、[[function-explicit-invocation]]、[[function-implicit-call]]有一定的了解。

问题：

1. this
1. 什么是显式调用函数？什么是隐式调用函数？
1. globalThis

[//begin]: # "Autogenerated link references for markdown compatibility"
[strict-mode]: strict-mode.md "严格模式"
[function-explicit-invocation]: function-explicit-invocation.md "函数显式调用"
[function-implicit-call]: function-implicit-call.md "函数隐式调用"
[//end]: # "Autogenerated link references"