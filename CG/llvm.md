
2023年6月26日
---

- 编译步骤：
> clang -ccc-print-phases a.c
```
[root@apach project1]# clang -ccc-print-phases a.c
            +- 0: input, "a.c", c
         +- 1: preprocessor, {0}, cpp-output
      +- 2: compiler, {1}, ir
   +- 3: backend, {2}, assembler
+- 4: assembler, {3}, object
5: linker, {4}, image
```
### 预处理  
预处理的任务：

- 将输入文件读到内存，并断行；
- 替换注释为单个空格；
- Tokenization将输入转换为一系列预处理Tokens；
- 处理#import、#include将所引的库，以递归的方式，插入到#import或#include所在的位置；
- 替换宏定义；
- 条件编译，根据条件包括或排除程序代码的某些部分；
- 插入行标记；
  - 在预处理的输出中，源文件名和行号信息会以# linenum filename flags形式传递，这被称为行标记，代表着接下来的内容开始于源文件filename的第linenum行，而flags则会有0或者多个，有1、2、3、4；如果有多个flags时，彼此使用分号隔开。详见此处。
  - 每个标识的表示内容如下：
```
    1表示一个新文件的开始
    2表示返回文件（包含另一个文件后）
    3表示以下文本来自系统头文件，因此应禁止某些警告
    4表示应将以下文本视为包装在隐式extern "C" 块中。
    比如# 10 "main.m" 2，表示导入Person.h文件后回到main.m文件的第10行。
```
### 词法分析  
- 生成token
```
# -fmodules: Enable the 'modules' language feature
# -fsyntax-only, Run the preprocessor, parser and type checking stages
#-Xclang <arg>: Pass <arg> to the clang compiler
# -dump-tokens: Run preprocessor, dump internal rep of tokens

clang -fmodules -fsyntax-only -Xclang -dump-tokens main.m
```
### 语法分析parsing与语义分析  
- token转为语法分析树，最终输出AST  
- 进行语义分析，执行类型检查和格式检查
- parsing，文本转成数据结构
```
# -fmodules: Enable the 'modules' language feature
# -fsyntax-only, Run the preprocessor, parser and type checking stages
#-Xclang <arg>: Pass <arg> to the clang compiler
# -ast-dump: Build ASTs and then debug dump them

clang -fmodules -fsyntax-only -Xclang -ast-dump main.m
```
- Clang的AST是从TranslationUnitDecl节点开始进行递归遍历的；AST中许多重要的Node，继承自Type、Decl、DeclContext、Stmt。  Type ：表示类型，比如BuiltinType
```
  Decl ：表示一个声明declaration或者一个定义definition，比如：变量，函数，结构体，typedef；
  DeclContext ：用来声明表示上下文的特定decl类型的基类；
  Stmt ：表示一条陈述statement;
  Expr：在Clang的语法树中也表示一条陈述statements;
```
### IR  
- 将AST转成IR
- 格式
  - .ll文本
  - .bc 二进制
>llvm-as:.ll>.bc
>llvm-dis:.bc>.ll
```
# -S : Run LLVM generation and optimization stages and target-specific code generation,producing an assembly file
# -fobjc-arc : Synthesize retain and release calls for Objective-C pointers
# -emit-llvm : Use the LLVM representation for assembler and object files
# -o <file> : Write output to <file>

# 汇编表示成.ll文件 -fobjc-arc 可忽略，不作代码优化
clang -S -fobjc-arc -emit-llvm main.m -o main.ll 

# 目标文件表示成 .bc 文件
#  -c : Only run preprocess, compile, and assemble steps
clang -emit-llvm -c main.m -o main.bc
#.ll与.bc的相互转换
llvm-as main.ll -o main.bc
llvm-dis main.bc -o main.ll
```

### LLVM IR  
- Module，functions、global variables、symbol table entries
- Target DataLayout:
- 元数据
- 命名元数据
- linkage Type
- 属性组
- 函数属性
- 参数属性
- 标识符
- 结构体的定义
- 数组的定义
- 全局变量的定义
- Runtime Preemption Specifiers
- call
- ret
- bitcast...to
- 
- 
