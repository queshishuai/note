## RE-Dennis Yurichev，2017
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



### 函数序言  

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

### 栈  
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

### 条件运算符  
---
- 三目表达式
- CMOVcc
- arm64，CSEL，conditional SELect
- 优化，尽可能避免条件转移指令
- 无分支指令的编译方法
  - ARM，MOVcc
  - ARM64,CSEL
  - X86,CMOVcc

### switch/case  
---  
- case少
- case多
- 符号标签，symbol label
- 转移表，jumptable，branchtable
- 类似指针数组
- 多对一，索引表
- fall-through，没有条件转移就行了
- 
### 参数获取  
---
### 返回值  
---  
- x86，EAX返回运算结果，
	- char，返回低8位，AL  
	- float，FPU的ST(0)
- arm R0  
- 返回结构体，caller创建数据结构，分配数据空间，把指针作为第一个参数传给callee  

### 指针  
---
### GOTO  
---
```
	goto exit;
...
exit:
...
```  
- jmp指令  
- dead code  

### 条件转移指令  
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
- RS reverse subtract，逆向减法  

### 循环  
---
- 初始态、循环条件、循环控制、循环体  
- 优化，循环变量直接变成寄存器  
- 迭代次数较少，或者展开  
- EBX  
- ESI  
-  利用数据栈保存/恢复专用寄存器值，函数序言和尾部声明部分  
- SIMD，矢量化技术
- 
- MOVSX，mov signed externd  
- ARM最初32RISC  
- 延迟索引寻址，Post-index address  
- SLL，shift left logical  
- SHR，shift right
- 
### FPU  
---
- IEEE 754  
- 8个***80***位寄存器构成的循环栈  
- ST（0）-ST（7）  
- Stack Top  
- ARM，x86的SIMD，是一组寄存器组  
- ST(0)保存浮点计数结果  
- 立即数，64位IEEE754  
- 行业标准VFP，vector Floating Point  
- ARM有32个64位D子头的寄存器，double float  
- ARM有32个32位S子头的寄存器，single float  
- `VMOV D17,R0,R1`2个32位组成64
- 
- FLD和FSTP  
- PF,parity flag  
- AX ,AH，FPU的状态寄存器，C0-C3  
- 栈、计算器及逆波兰表示法  
- 
### 数组  
---
- 循环优化，将补偿用寄存器表示，避免乘法
- 缓冲区溢出
- canary百灵鸟，函数启动时构造一些本地变量，在里面写入随机数，函数结束检查这些值是否变化
- __stack_chk_fail  
- gs寄存器
- 数组一处保护，asssertions
- 行优先，c/c++,python
- 列优先，Fortran，Matlab，R  .
- 数组访问就是计算地址

### 位操作  
---
- 数据处理指令  
- x86,SHR/SHL，SAR/SHL  
- arm,LSR/LSL,ASL/LSL  
- TEST，只置标志位，不改变结果

- AND，结果保存到目标操作数中  

- regparm=3，设置传参的寄存器数量  

- BIC，反码逻辑与  

- ORR，逻辑或  

- 位移<< >>  
- FPU的IEEE754格式，S-sign
  | S       | exponent | mantissa or fraction |
  | ------- | -------- | -------------------- |
  | 31,1    | 30:23,8  | 22:0,23              |
  | 符号     | 指数     | 小数                  |

- XMM0寄存器  
- BTR重置，BTS置位，BTC翻转  
- FMRS用于在GPR和FPU交换数据  
- population count/点数函数  
- 

### 线性同余法与伪随机函数  
---
- 线性同余法
```
static rand = init;
rand *= 1664525  
rand += 1013904223
rand = rand &0x7ffff  
```
- 梅森旋转法，Mersenne twister  
- 重定向，编译->linker  

### 结构体  
---
- 异构容器  
-** 不启动优化，编译器一般以结构体声明变量的次序，在栈内分配空间**  
- 指定结构体对齐标准/Zp,#pragma pack  
- 位域  
- [esi + 4]  
- 结构体构建浮点数  
- union，构建浮点伪随机数  
- 快速平方根计算  

- 32为系统用EDX：EAX来回传64位值  

### SIMD  
---
- 专用模块实现，
- simd，8个64为寄存器MM0-MM7  
- sse，128位  
- avx，256  
- DES，data encryption standard  
- 矢量化  

### 64位平台  
---
- R开头  
- 多8个GPR， 
- RAX、RBX、RCX、RDX、
- RBP、RSP、
- RSI、RDI、
- R8-R15   
- x86有16个simd，xmm0-15，x64有32个  
- fastcall规范传参,RCX,RDX,R8,R9传前4个参数，其他栈  
- x64在外部RAM的寻址能力是48位  
- 函数间传递浮点参数xmm0-xmm3  
- -SS，Scalar Single标量，表明寄存器里只有一个值，单精度  
- packed  
- sse用的64位浮点，fpu用的80位  

### ARM指令详解  
---
- 立即数（常量），#开头  
- 变址寻址，`ldr x0,[x29,24]`地址+24  
    - 后变址寻址，  
    - 前变址寻址,带！`[sp,#-16]!`  
- 常量赋值  
	- movk，move keep  
- 重定位  
	- adrp和add传递64位指针地址  


## 硬件  
---
### 内存布局
---
- 全局内存空间  
- 栈空间  
- 堆空间  

### CPU  
---
- 分支预测，主流编译器不分配条件转移。COMOVcc  
- OOE/乱序执行指令  
- LEA，不影响标志位，多使用  
- 数据相关性  
- hash函数，生成checksum，  
- 单向，不可逆  
- 
- ARM不支持硬件除法指令

### 反汇编代码  
---
- 反汇编出来很像随机数指令序列  
- 混淆技术  
- 字符串变换  
	- 字符串起到**路标**作用  
- 名称改编，name mangling  
- stdcall：应当由**被调用方**恢复参数栈的初始状态  
- thiscall  
- 

- 封装：把既定的数据和方法限定为类的私有信息，其他调用方只能用类定义的公共接口访问，不能直接访问被封装起来的私有对象。  
- 封装只能在编译阶段保护类的私有对象。  
- 多重继承，内存中就是一种联合体的数据结构，传递该方法原有基类相对地址相应的this指针。  
- 虚函数表和RTTI，runtime type information  
- **引用不能改变指向，调用是安全的**  
- std::string  
	- 缓冲区指针  
	- 字符串缓冲区  
	- 当前字符串的长度  
	- 当前缓冲区容量  
- 16字符长度  

## part5  
---
- **快速发现他要找的代码**  
- 找到用了什么库  

### 编译器产生的文件特征  
--- 
- 命名规则。GCC，`_Z`开头  
- 输入、输出确定函数功能  
- 文件，注册表；Sysinternals和Process Monitor  
- 网络通信，wireshark  
- 操作系统API和标准库  
- MessageBox()  
- rand()  
- ASCIIZ字符串  
- 编码UTF-8  
- BOM，byte order mark，字节顺序标记，声明了字符串的编码系统  
- Base64，1到2个==结尾，不可能在中间  
- Unicode  
- assert()  
- MZ魔数，文件头文件表示文件格式  
- 检索关键指令，浮点  
- xor异或指令  
- 
- 目标：**理解程序处理数据的具体方法**  
- 构造魔数调试程序  
- 内存快照  
- windows注册表，注册软件，对比注册表  

### 参数传递、调用规范  
--- 
- cdel，调用方**逆序**向被调函数传参  
- stdcall，执行完调用`RET x`还原参数栈  
- fastcall，优先寄存器，但没有统一的技术规范  
- watcom，寄存器调用规范，eax,edx,ebx,ecx，头4个寄存器  
- thiscall  
- 
### 线程本地存储TLS  
---
- errno  
- 限定符thread_local  
- `__DeclSpec(thread)`  
- `_TLS SEEGMENT`  
- TIB,thread info block  
- FS 段  
- TLS回调  

### 系统调用  
--- 
- linux通过80int调用syscall，eax指定被调用的函数编号  
- 位置无关代码，PIC  
- GOT，global offset table  
- PLT，procedure linkage table  
- LD_PRELOAD，劫持syscall  
- OEP，original entry point  
- CRT，C runTime，启动代码  
- 
