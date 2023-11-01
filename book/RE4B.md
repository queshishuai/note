### RE-Dennis Yurichev
-2023年11月1日17:12:13
---

定义：一种分析目标系统的过程，旨在识别系统的各组件以及组件间关系，以便能够通过其形式或在较高的抽象层次上，重系统的表征

- 函数、语句、结构体、数组
- 二进制分析能力  
- APT攻击，advanced Persistent Threat  
- 16个GPR，general  
- ISA  
- ARM/ARM64，4字节的机器码  
- Thumb，2字节  
- Thumb-2，部分2字节，封装不下的用4字节  
- 汇编语言语体：intel和AT&T  
- 程序访问的地址必须16字节对齐  
- 可执行文件，elf，
- import section，外部模块和加载的符号连接  
- thunk function，形实转换函数  



#### 函数序言  

---

- function prologue：函数在启动时候运行的一系列指令

```  
push ebp
mov epb,esp
sub esp,x  

mov esp,ebp
pop ebp 
ret 0
```
- 所有递归函数的性能都不理想  

#### 栈  
---
- 保存函数结束时的返回地址  
- bp base pointer 调用者保存  
- LR link register，arm的返回地址  

- 指针，最基本的概念
- lea load effective address
- EAX-EDX 数据寄存器
- 全局变量，
- /MD 命令，将编译的可执行文件将把标准函数链接到MSCVCR*。DLL
- 
