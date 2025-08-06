FEATURE

2025年8月6日

---

1、std::declval 是模板函数，作用是将任意类型转换为右值引用（T&&），无需创建对象即可获取成员函数返回类型。

	- 通常用于模板编程避免临时对象创建。

  ```
  decltype(std::declval<T>())
  ```

  2、std::void_t是一个别名模板

```
template<tpename...Args> using void_t = void;
```

- 无论传入多少个类型，都会变成void，检测SFINAE时的非法类型，传入的必须是有效的类型
- 检测类型、成员、运算符

```
//检测类型
// 泛化版本（默认返回false）
template<typename T, typename = std::void_t<>>
struct has_type_member : std::false_type {};

// 特化版本（当T::type存在时匹配）
template<typename T>
struct has_type_member<T, std::void_t<typename T::type>> : std::true_type {};

```

```
//检测成员
template<typename T, typename = std::void_t<>>
struct has_hello_func : std::false_type {};

template<typename T>
struct has_hello_func<T, std::void_t<decltype(std::declval<T>().hello())>> 
    : std::true_type {};

```

3、SFINAE 重载的函数模板匹配，编译过程找最佳匹配。
