# 函数显式调用

所谓的函数显式调用，是指通过 `Function.prototype.call()` 或者 `Function.prototype.apply()` 方法来调用函数，并明确指定函数的上下文（即 `this` 的值）。

`call()` 与 `apply()` 这两个方法几乎一样，区别只是在传参有区别（`func.call(this, "eat", "bananas")` vs `func.apply(this, ["eat", "bananas"])`）

## 参考资料

- [MDN: Function.prototype.call()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
- [MDN: Function.prototype.apply()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
