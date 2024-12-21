Gird 是二维布局系统，提供了很多功能来简化复杂布局的创建。一个 grid 通常包含 column、row 以及 gutters。

通过给容器声明 `display: grid` 来定义 grid，所有容器的 direct children 会转变成 grid items。但仅声明 `display: grid` 时元素的布局并不会改变，需添加列的属性：

```css
.container {
	display: grid;
	grid-template-columns: 200px 200px 200px;
}
```

如果想要弹性 grids 可以使用 `fr` 单位，`fr` 单位按比例分配可用空间：

```css
.container {
	display: grid;
	grid-template-columns: 2fr 1fr 1fr;
}
```

`2fr` 分配的空间是 `1fr` 的两倍。