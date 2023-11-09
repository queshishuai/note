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
- MSVC未开启优化，传参被压到栈里，而不是寄存器中  
- 阴影空间  
- GCC，只有寄存器不够用时  

#### 条件运算符  
---
- 三目表达式
- CMOVcc
- arm64，CSEL，conditional SELect
- 优化，尽可能避免条件转移指令
- 无分支指令的编译方法
  - ARM，MOVcc
  - ARM64,CSEL
  - X86,CMOVcc

#### switch/case  
---  
- case少
- case多
- 符号标签，symbol label
- 转移表，jumptable，branchtable
- 类似指针数组
- 多对一，索引表
- fall-through，没有条件转移就行了
- 
#### 参数获取  
---
#### 返回值  
---  
- x86，EAX返回运算结果，
	- char，返回低8位，AL  
	- float，FPU的ST(0)
- arm R0  
- 返回结构体，caller创建数据结构，分配数据空间，把指针作为第一个参数传给callee  

#### 指针  
---
#### GOTO  
---
```
	goto exit;
...
exit:
...
```  
- jmp指令  
- dead code  

#### 条件转移指令  
---
- signed，检查借位/进位标志CF和零标志位ZF  
    - JLE jump if less or Equal  
    - JGE jump if Greater or Equal  
- unsigned，检查SF XOR OF和ZF  
    - JBE jump if below or equal
    - JAE jump if abobe or equal  
- ADD，addal，always  
- 条件字段，al，忽略condition field  
- ADR，寻址，ADRGT  
- B指令，BLE，BNE，BGE，BLS，BCS
- BL指令，  
- LDMFD load multiple full descending  
- -HI unsigned higher  
- -CS carry set  
- ***ARM模式的程序可以完全不依赖条件转移指令，pipeline技术，处理器跳转指令的性能不优越，性能决定于分支预测器branch predictor unites***  
- RS reverse subtract

#### 循环  
---
- 初始态、循环条件、循环控制、循环体  
- 优化，循环变量直接变成寄存器  
- 迭代次数较少，或者展开  
- EBX  
- ESI  
-  利用数据栈保存/恢复专用寄存器值，函数序言和尾部声明部分  
- SIMD，矢量化技术
- 
