# this

`this` 的指向比较灵活多变，在实际开发中经常会在 `this` 这个点上踩坑。以下是 `this` 的指向规则：

1. 在函数体中，非显式或隐式地简单调用函数时，在[[strict-mode]]下，函数内的 `this` 会被绑定到 `undefined`。在非严格模式下则会被绑定到全局对象 window/global 上。
2. 使用 `call`、`apply`、`bind` 方法调用函数时，函数内的 `this` 会被绑定到指定参数的对象上。
3. 使用 `new` 方法调用构造函数时，构造函数内的 `this` 会被绑定到新创建的对象上。
4. 通过上下文对象调用函数时，函数体内的 `this` 会被绑定到该对象上。
5. 在箭头函数中，`this` 的指向是由外层（函数或全局）作用域来决定的。

要理解好上面几点，需要对[[strict-mode]]、[[function-explicit-invocation]]、[[function-implicit-call]]有一定的了解。

## this 场景

为了更加充分理解 this 的指向规则，下面将会列举一些常见的 this 场景。

### 全局环境中的 this

例子 1：

```javascript
function f1() {
  console.log(this);
}

function f2() {
  "use strict";
  console.log(this);
}

f1(); // window
f2(); // undefined
```

这个例子涉及规则 1。在非严格模式下，函数内的 `this` 会被绑定到全局对象 window 上。而在严格模式下，函数内的 `this` 会被绑定到 `undefined`。

例子 2：

```javascript
const foo = {
  bar: 10,
  fn: function () {
    console.log(this);
    console.log(this.bar);
  },
};

const fn1 = foo.fn;
fn1(); // window, undefined
```

这个例子仍然涉及规则 1。虽然 `fn` 是在 `foo` 对象中定义的，但是在 `fn1` 中调用 `fn` 时，实际上是隐式调用 `fn`，因此 `fn` 中的 `this` 会指向全局对象 window。

### 上下文对象调用中的 this

例子 1：

```javascript
const student = {
  name: "Lucas",
  fn: function () {
    return this;
  },
};

console.log(student.fn() === student); // true
```

例子 2：

```javascript
const person = {
  name: "Lucas",
  brother: {
    name: "Mike",
    fn: function () {
      return this.name;
    },
  },
};

console.log(person.brother.fn()); // Mike
```

例子 2 虽然涉及了规则 4，虽然有嵌套对象，但是在 `fn` 是被 `brother` 这个上下文对象所调用的，因此 `fn` 中的 `this` 会被绑定到 `brother` 对象上。

例子 3：

```javascript
const o1 = {
  text: "o1",
  fn: function () {
    return this.text;
  },
};

const o2 = {
  text: "o2",
  fn: function () {
    return o1.fn();
  },
};

const o3 = {
  text: "o3",
  fn: function () {
    var fn = o1.fn;
    return fn();
  },
};

console.log(o1.fn()); // o1
console.log(o2.fn()); // o1
console.log(o3.fn()); // undefined
```

例子 3 涉及规则 1 和规则 4。第一个输出跟第二个输出比较容易，因为 `fn` 都是被 `o1` 调用，所以输出都是 `o1`。第三个输出，由于 `fn` 是隐式调用，因此 `this` 指向 `window`，`window` 对象没有 `text` 属性，因此输出是 `undefined`。

### 通过 call、apply、bind 改变 this 指向

`call`、`apply`、`bind` 方法可以改变函数内 `this` 的指向。区别在于 `call` 和 `apply` 是立即调用函数，而 `bind` 是返回一个新函数，这个新函数已经自动绑定了新的 `this` 指向。

下面三段代码是等价的：

```javascript
{
  const target = {};
  fn.call(target, "arg1", "arg2");
}

{
  const target = {};
  fn.apply(target, ["arg1", "arg2"]);
}

{
  const target = {};
  fn.bind(target, "arg1", "arg2")();
}
```

例子:

```javascript
const o1 = {
  text: "o1",
  fn: function () {
    return this.text;
  },
};

const o2 = {
  text: "o2",
};

console.log(o1.fn.call(o2)); // o2
console.log(o1.fn.apply(o2)); // o2
console.log(o1.fn.bind(o2)()); // o2
```

### 构造函数和 this

要了解构造函数和 `this` 的关系，需要先了解 `new` 操作符调用构造函数时发生了什么。过程如下：

1. 创建了一个新的对象。
2. 将新对象的原型指向构造函数的原型。
3. 执行构造函数，将 `this` 绑定到新对象上。
4. 如果构造函数 return 非原始类型的值，则返回这个值。否则返回新对象。

例子 1：

```javascript
function Foo() {
  this.user = "Lucas";
  const o = {};
  return o;
}

const instance = new Foo();
console.log(instance.user); // undefined
```

该例子由于构造函数返回了对象 `o`，因此 `new` 操作符返回的是对象 `o`，而不是构造函数中的 `this`。对象 `o` 是一个空对象，所以 `instance.user` 是 `undefined`。

例子 2：

```javascript
function Foo() {
  this.user = "Lucas";

  return 1;
}

const instance = new Foo();
console.log(instance.user); // Lucas
```

这个例子构造函数返回一个原始数值，`new` 操作符返回的是构造函数中的 `this`，所以 `instance.user` 是 `Lucas`。

### 箭头函数中的 this

箭头函数中的 `this` 是由外层（函数或全局）作用域来决定的。

例子 1：

```javascript
const foo = {
  fn: function () {
    setTimeout(function () {
      console.log(this);
    });
  },
};

foo.fn(); // this 指向 window
```

由于 `setTimeout` 的回调函数是在全局作用域中执行的，因此 `this` 指向全局对象 window。

例子 2：

将例子 1 中的 `setTimeout` 的回调函数改为箭头函数：

```javascript
const foo = {
  fn: function () {
    setTimeout(() => {
      console.log(this);
    });
  },
};

foo.fn(); // this 指向 foo
```

箭头函数中的 `this` 是由外层作用域决定的，因此 `this` 指向 `foo` 对象。

例子 3：

```javascript
function foo() {
  return () => {
    console.log(this.a);
  };
}

const obj1 = {
  a: 2,
};

const obj2 = {
  a: 3,
};

const bar = foo.call(obj1);
bar.call(obj2); // 2
```

箭头函数是由 `foo` 的作用域决定的，当 `foo.call(obj1)` 执行的时候，`foo` 中的 `this` 就被绑定为 `obj1`，这时候 `bar` 拿到的箭头函数即便再执行 `bar.call(obj2)`，`this` 也不会改变。

例子 4：

```javascript
var a = 123;
const foo = () => () => {
  console.log(this.a);
};

const obj1 = {
  a: 2,
};

const obj2 = {
  a: 3,
};

const bar = foo.call(obj1);
bar.call(obj2); /// 123
```

该例子将 `foo` 改为箭头函数，因此 this 指向全局对象 window，所以输出是 `123`。如果将 `var a = 123` 改为 `const a = 123` 那么得到的结果将是 `undefined`，因为 `const` 声明的变量不会挂在到全局对象上。

## this 优先级

1. new 操作符调用构造函数：使用 new 操作符创建对象实例时，构造函数内部的 this 会指向新创建的对象实例。
2. 显式调用函数的 call、apply 或 bind 方法：这些方法允许你显式地指定函数内部的 this 值。通过调用 call 或 apply 方法，可以在函数调用时将指定的对象作为 this 值传递进去。而 bind 方法则会创建一个新的函数，其中 this 值被绑定到指定的对象。
3. 上下文对象调用函数：当函数作为对象的方法被调用时，函数内部的 this 指向调用该方法的对象。例如：

   ```javascript
   const obj = {
     name: "Alice",
     greet: function () {
       console.log("Hello, " + this.name);
     },
   };

   obj.greet(); // 输出: Hello, Alice
   ```

   在上述代码中，greet 方法被对象 obj 调用，所以 this 指向 obj 对象。

4. 箭头函数：箭头函数不会绑定自己的 this 值，而是继承父级作用域的 this 值。箭头函数在定义时确定了 this 的值，无法通过 call、apply 或 bind 方法来改变。

优先级从高到低为：new 操作符 > 显式调用 > 上下文对象调用 > 箭头函数。

## 参考资料

- 《前段开发核心知识进阶》
- [MDN: call](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
- [MDN: apply](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
- [MDN: bind](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind)
- [MDN: new operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new)

[//begin]: # "Autogenerated link references for markdown compatibility"
[strict-mode]: strict-mode.md "严格模式"
[function-explicit-invocation]: function-explicit-invocation.md "函数显式调用"
[function-implicit-call]: function-implicit-call.md "函数隐式调用"
[//end]: # "Autogenerated link references"
[//begin]: # "Autogenerated link references for markdown compatibility"
[strict-mode]: strict-mode.md "严格模式"
[function-explicit-invocation]: function-explicit-invocation.md "函数显式调用"
[function-implicit-call]: function-implicit-call.md "函数隐式调用"
[//end]: # "Autogenerated link references"

```

```

[//begin]: # "Autogenerated link references for markdown compatibility"
[strict-mode]: strict-mode.md "严格模式"
[function-explicit-invocation]: function-explicit-invocation.md "函数显式调用"
[function-implicit-call]: function-implicit-call.md "函数隐式调用"
[//end]: # "Autogenerated link references"
