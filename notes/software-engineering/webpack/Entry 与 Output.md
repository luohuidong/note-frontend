## Entry

entry point 表示 webpack 应该从哪个模块开始构建内部依赖图。webpack 能找出哪些模块和库是 entry point 依赖的。

entry 的定义一般使用对象语法，因为这种方式具有很好的扩展性：

```javascript
module.exports = {
  entry: {
    app: './src/app.js',
    adminApp: './src/adminApp.js',
  },
};
```

## Output

output 属性告诉 webpack 将生成的 bundles 放在哪里以及如何命名 bundles 文件。当有多个 entry 的时候，可以通过 substitutions 来确保每个文件都有独一无二的名字。
