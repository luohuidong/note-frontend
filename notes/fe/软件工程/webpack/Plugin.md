Webpack 自身是构建在插件系统之上，这个插件系统与我们在 webpack 配置中使用的插件系统是相同的。

plugin 旨在完成所有 loader 不能做的事情。例如打包优化、资源管理和环境变量注入。

## Plugin 剖析

plugin 是一个带有 `apply` 方法的 JavaScript 对象。`apply` 方法会被 webpack compiler 调用，并且 `apply` 方法可以访问整个编译的生命周期。

```javascript
const pluginName = 'ConsoleLogOnBuildWebpackPlugin';

class ConsoleLogOnBuildWebpackPlugin {
  apply(compiler) {
    compiler.hooks.run.tap(pluginName, (compilation) => {
      console.log('The webpack build process is starting!');
    });
  }
}

module.exports = ConsoleLogOnBuildWebpackPlugin;
```

## plugin 使用

有两种方式可以使用 plugin，一种是在配置文件中使用，另外一种是通过 Node API 调用。

通过配置文件的方式：

```javascript
const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require('webpack'); //to access built-in plugins
const path = require('path');

module.exports = {
  entry: './path/to/my/entry/file.js',
  output: {
    filename: 'my-first-webpack.bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        use: 'babel-loader',
      },
    ],
  },
  plugins: [
    new webpack.ProgressPlugin(),
    new HtmlWebpackPlugin({ template: './src/index.html' }),
  ],
};
```

通过 Node API 的方式：

```javascript
const webpack = require('webpack'); //to access webpack runtime
const configuration = require('./webpack.config.js');

let compiler = webpack(configuration);

new webpack.ProgressPlugin().apply(compiler);

compiler.run(function (err, stats) {
  // ...
});
```
