[[从执行上下文的角度来看变量提升]]导致有很多 JavaScript 代码的执行结果与直觉不符，例如下面这个例子：

```js
function bar() {
  var foo = 'foo1'
  if (1) {
    var foo = 'foo2'
    console.log(foo)
  }
  console.log(foo)
}
bar()
```

当执行上面的代码的时候，输出的结果都是 `foo2`。为什么第二个输出也是`foo2`而不是 `foo1`？主要原因是在 ECMAScript 6 之前，并没有块级作用域的概念，只有全局作用域和函数作用域。这就导致了在 `if` 语句中声明的 `foo` 变量实际上会作用于整个 `bar` 函数的函数作用域，因此两个 `console.log` 输出的都是 `foo2`。

而由于通过 `var` 声明的变量有如此怪异，因此在 ECMAScript 6 中通过引入块级作用域并配合 `let`、`const` 关键字来避开了这种设计缺陷。

将前面的例子通过 `let` 进行改造，得到的结果就非常符合我们的编程习惯，块级作用域内声明的变量不影响块外面的变量。

```js
function bar() {
  let foo = 'foo1'
  if (1) {
    let foo = 'foo2'
    console.log(foo)
  }
  console.log(foo)
}
bar()
```

## JavaScript 如何支持块级作用域？

我们通过下面的例子来了解 JavaScript 是如何在支持变量提升的同时也支持块级作用域：

```js
function foo(){
    var a = 1
    let b = 2
    {
      let b = 3
      var c = 4
      let d = 5
      console.log(a)
      console.log(b)
    }
    console.log(b) 
    console.log(c)
    console.log(d)
}   
foo()
```

上面的代码执行流程首先是编译并创建执行上下文，上下文如下图所示：

![Pasted image 20240320225920](https://cdn.luohuidong.cn/Pasted%20image%2020240320225920.png)
1. 代码中通过 `var` 声明的变量在编译阶段全部放到变量环境里。
2. 通过 let 声明的变量，在编译阶段被放到词法环境中，这个词法环境是一个栈。
3. 在函数的作用域块内部，通过 `let` 声明的变量并没有放到词法环境中。

当执行编译完毕之后会继续执行代码，当执行到代码块里面时，变量环境中 a 的值已经被设置成了 1，词法环境中 b 的值已经被设置成了 2，此时的执行上下文如下：

![Pasted image 20240320230608](https://cdn.luohuidong.cn/Pasted%20image%2020240320230608.png)

进入到作用域块时，作用域块中通过 `let` 或者 `const` 声明的变量会被压到词法环境的栈中。

当执行到作用域块中 `console.log(a)` 的时候，就需要在词法环境和变量环境中查找变量 `a` 的值，查找过程如下：

![Pasted image 20240320231457](https://cdn.luohuidong.cn/Pasted%20image%2020240320231457.png)

上图可以看出变量查找流程，不过要完整理解查找变量或者查找函数的流程，就涉及到[[作用域与作用域链|作用域链]]。这里简单的说就是每个执行上下文中的变量环境都有一个外部引用（outer）指向外部的执行上下文，当在当前执行上下文中找不到对应的变量则会继续在外部的执行上下文中继续查找这个变量。

当作用域块执行完毕之后，作用域块的信息就会从词法环境的栈顶弹出。通过上面的分析就知道 JavaScript 引擎是如何同时支持变量提升和块级作用域了。

##  参考资料

- [浏览器工作原理与实践：09 | 块级作用域：var缺陷以及为什么要引入let和const？](https://time.geekbang.org/column/article/126339)
