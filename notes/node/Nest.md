## Nest 核心概念

### Controllers

作用是接收来自客户端的请求并对请求做出响应。一个 controller 一般对应多个路由。

### Providers

- Provider 是 Nest 中非常基础的概念，许多 Nest 的类都可作为 provider，如  services、repositories、factories、helpers等等。
- 它的主要作用是作为依赖注入。
- controller 用于处理 HTTP 请求，但是更复杂的逻辑应该让 providers 去做。
- Provider 是一个 class，并且声明在 module 中的 `providers` 属性中。

### Modules

- Module 是一个使用 `@Module` 装饰器装饰的类。
- `@Module()` 提供了组织整个 Nest 应用结构的元数据。