### Cherno YouTube  
2022年12月20日17:55:25
---
- C++中文件没有任何意义  
- 编译，翻译单元  
- 链接：找到符号和函数在哪，然后链接在一起  
- Ctrl + F7 单独编译  
- 错误C1231、LNK1561  
- bool，1个字节，0是false；非0是true  
- 常数折叠，编译阶段？  
- vs file filter  
- static外部和内部  
- V表，包含基类所有虚函数的映射    
- 继承  
- 虚函数：动态联编Dynamic Dispatch  
- 额外的性能损失：1、有一个指针指向V表，2、遍历V表决定使用哪个重载版本    
- 纯虚函数：基类中定义一个没有实现的函数，强制子类去实现，不能被实例化。  
- 接口，用一个独立的基类归类  
- 可见性  
- 数组  
- 字符串，末尾有\0  
- baseString类，String  
  - 字符串字面值
  - 附加字面值的2中方法  
  - std::u32string name = U"ch"s + "xn";宽字节，s表示  
  - const char* examp = R"()";  
  - 只读  
  - 
- const 
  - 类中方法：void get()const{},表示不能修改实际的类成员，const对象才能使用const函数   
- mutable，可以临时让常变量被改变  
  - 与const配合用  
  - lamba？？？//TODO  
- 构造函数成员初始化列表A():m_name("123"),m_score(0){}  
  -  顺序不能乱，会有依赖问题  
  -  风格问题，把初始化成员放在列表里，其他逻辑写在函数体中  
  -  防止创建2个对象，去覆盖  
- ternary 三元运算符  
- 创建并初始化类  
- {}也是一个栈  
- new  
  - 内存空闲列表  
  - 申请内存+调用构造函数
  - 记得delete  
  - placement new： A* a = new(b) A();没有实际分配内存
- 隐式转换和explict  
  - 只允许一次隐式转换  
  - explict显式的，放在构造函数前，不允许隐式类型转换，用于数学库，  
- 运算符及其重载  
- this指针  
- 智能指针  
  - unique_ptr:作用域指针<memory>   
  - shared_ptr： std::unique_ptr<A> a = std::make_unique<A>();  
  - weak_ptr  
- 拷贝构造函数。  
- vector
  - 迭代器  
  - push_back  
  - clear  
  - earse  
  - reserve(3)
  - emplace_back()只传递参数列表
- 库  
  - 包管理  
  - 静态链接  
- 多返回值，
  - tuple：多个变量，不关心类型，<functional>,make_pair();不用传递类型get<0>()  
  - pair,A.first;A.second;
  - tie
  - 结构体  
  - 结构化绑定auto[name,age] = A(); std=c++17
- 模板  
  - typename，or class
  - 调用时才被创建  
  - 模板参数可以指定类型，也可以指定变量大小  
  - meta programing  
- stack和heap  
  - stack：2M，分配内存快，移动栈帧，catch line  
  - heap：空闲list  
- 宏  
  - 必须是同一行，在每一行尾巴用\  
- auto：迭代器用  
- 静态数组std::array,size是一个模板参数    
- 函数指针  
- lambda,匿名函数  
  - [= & a](int value){TODO}  
  - std::function  
  - std::find_if()  
- thread  
- chrono计时器  
  auto start = std::chrono::time_point_cast<std::chrono::microseconds>(m_startTimePoint).time_since_epoch().count();
- sort用lamdba  
- 类型双关  
- 虚析构函数：意义是先调用子类析构，再调用基类虚构  
    - 你希望有人继承你的基类，必须显示指定虚析构函数，安全扩展类  
- 类型转换：static_cast、reinterpret_cast（重新解释内存）\const_cast（移除const）\dynamic_cast(运行时检查)  
  - dynamic_cast用来验证，RTTI，type info多态类型
- 条件与操作action断点  
- 安全性，严肃项目使用智能指针  
- 预编译头文件  
  - g++ -std=c++11 pch.h  
- std::optional 
  
---
### 多线程  
- std::asnyc
- 数据流化
- std::async(std::launch::async,func);  
  
- string_view 
- chrome://tracing  
- 单例，singleton  
- sso优化  
- 内存tracing，重写new和delete    
- Lvalue，located value  
  - 常量引用(右值引用)：void func([const] std::string&& str),检测常量，优化，不用考虑拷贝之类
- Rvalue  
  - 临时值
- move  
  - A(string&& name)：m_name((string&&)name){}
  - A(string&& name)：m_name(std::move(name)){}
  - 拷贝构造的临时变量也会析构  
- RVO  
- C++三法则：  
- C++五法则：
---
- electron  
-imGUI  
  - 即时ui  
  - 保留ui
  
  
---
  - new和delete  
    1 调用operator new的标准库函数，实际上是malloc，分配内存  
    2 编译器运行响应的构造函数，构造对象，并传入初始值  
    3 返回改对象的指针。对象已经被分配了空间并构造完成。
  - 限制只能建立在堆上：在栈上分配内存，编译器分配空间，调用构造函数来构造栈对象。会先检查所有非静态函数的访问性。私有的不会分配。  
  - 限制建立在栈上，限制new的调用，把operator new重载为私有。  
--- 
  -可变参数 
```  
  template<typename T,typename... Types>
  void func(T n,Types... args)
  {
  va_list ap;
  va_start(ap,n);
  va_arg(ap,int);
  va_end(ap);
  }
```
  -可变参数模板
 ```
template <typename T,class... Args>
int print(T t,Args... args)
{
    printf(args...);
}
```
--- 
  -move  
  -forward,perfect forwarding,完美转发  
    - 不管是T&&、左值引用、右值引用，std::forward都会按照原来的类型完美转发。
    - forward主要解决引用函数参数为右值时，传进来之后有了变量名就变成了左值。
```
template <typename T>
void func_f(T& t)
{

    std::cout << "Lvalue" << t << std::endl;
}
template <typename T>
void func_f(T&& t)
{
    
    std::cout << "Rvalue" << t << std::endl;
}
template <typename T>
void test_f(T&& nValue)
{
    func_f(nValue);
    func_f(std::forward<T>(nValue));
    func_f(std::move(nValue));
}
func_f(forward<int>(nValue));//Rvalue
```

---
- 函数对象  
  - 重载函数调用操作符的类，行为类似函数的对象，叫仿函数。  
  - 其实就是重载了(),使得类可以像函数一样调用。  
  `std::hash<float>{}(5.0)`
- end
