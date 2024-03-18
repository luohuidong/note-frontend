webpack 默认只能处理 JavaScript 和 JSON 文件的，而 loader 则可以让 webpack 处理其他类型的文件。loader 将其他类型的文件转换为可以被应用使用并且能够添加到 dependency graph 的合法的模块。

loader 的声明可以是链式的，第一个执行的 loader 会将它的处理结果传递给下一个 loader 进行处理。webpack 期望最后一个 loader 返回的结果是 JavaScript 代码。

loader 执行的顺序与声明的顺序是相反的。如下面的例子，会先执行 `saas-loader`，然后执行 `css-loader`，最后执行 `style-loader`。

```js
module.exports = {
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          { loader: 'style-loader' },
          {
            loader: 'css-loader',
            options: {
              modules: true,
            },
          },
          { loader: 'sass-loader' },
        ],
      },
    ],
  },
};
```