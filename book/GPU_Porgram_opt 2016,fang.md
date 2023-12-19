## GPU_Porgram_opt 2016,fang  
---
-2023年12月11日13:32:52  
### overview  
- MIC，many integrated core  
- bsp，bulk syn parallel  
- 高性能计算：向量机和阵列机  
- ATI，（AMD收购）  
- 北桥，pci-e接口连接  
- 
### 架构  
---
- CoWoS堆叠内存  
- SP，stream processor，core  
- DP，double float  
- SFU  
- SM，基本计算单元，由sp、dp、sfu等组成  
- TPC，thread processing cluster，sm+L1 catch  
- GPC  
- MMC，memory controller  
- POP，raster operation processor  
- LD/ST  
- ECC内存校验  
- GTX750Ti架构白皮书  
- NVLink  
- kernel、函数  
- GPU存储体系  
	- 层次式存储   
	- 原则：尽可能使用离核近、访存延迟小的存储单元，避免使用全局存储。
- 计算能力，支持的功能  
- 
### 软件体系  
---
- 编译器、编程模型、数学函数库、性能分析工具、程序调试工具、代码实例SDK、管理软件、应用软件、完整的文档  
- PTX，并行线程执行，编译后的中间形式-》再编译为微码-》cuda bin文件-》反汇编SASS  

### 数值计算  
---
- grid-block-thread三维模型  
- 向量加法、向量内积、矩阵乘法、矩阵转置  
- grid内线程循环  
- block内线程循环  
- 
### 高级数值计算  
---
- 卷积  
- mandelbrot  
- 计算通信重叠优化，多流并发  
- 前缀求和  
- thrust库，转置，归约，前缀和，排序，在排序  
- 
- 图形处理  
- 图形直方图统计  
- 中值滤波，9个格子，取中间  
- 均值滤波，取平均  
- 
### 核心  
---
- kernel函数如何在GPU中执行  
- 功能实现、性能提升  
- core、DP的算术运算能力、SFU、分支处理、线程切换开销、存储访问、occupancy  
- <<<blocks,threads>>>,block映射到SM，真正执行又以warp为单位解析指令并分发到core，SP，DP，SFU或访存LD/ST。  
- 分支处理  
- 同步，block中的wrap同步  
- wrap原语，投票和洗牌  
    - kernel函数内循环  
    - kernel函数执行线程调度开销  
    - kernel函数循环启动开销  

- 存储体系




































