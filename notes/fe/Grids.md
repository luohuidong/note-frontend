Gird 是二维布局系统，提供了很多功能来简化复杂布局的创建。一个 grid 通常包含 column、row 以及 gutters。

通过给容器声明 `display: grid` 来定义 grid，所有容器的 direct children 会转变成 grid items。但仅声明 `display: grid` 时元素的布局并不会改变，需添加列的属性：

```css
.container {
	display: grid;
	grid-template-columns: 200px 200px 200px;
}
```

如果想要弹性 grids 可以使用 `fr` 单位。`fr` 单位按比例分配可用空间，例如 `2fr` 分配的空间是 `1fr` 的两倍：

```css
.container {
	display: grid;
	grid-template-columns: 2fr 1fr 1fr;
}
```

将 column 和 row 理解为 track，可以在 track 之间添加 gap：

```css
.container {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: 20px;
}
```

另外我们还可以使用 `column-gap` 和 `row-gap` 来分别设置 column 与行之间的间距，`gap` 则是这两者的缩写。

如果存在多个 column 都是相同宽度的情况，可以使用 `repeat()` 方法来简化定义：

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
```

## 显示 grid 与隐式 grid

使用e

