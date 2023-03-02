# Real-Time Rendering 4th  
2023/02/28  
---

### 3. 图形渲染管线  
- 包含：应用阶段、几何处理、栅格、像素处理  
- 
1. 定点着色 
	a.计算顶点坐标、法线坐标，颜色，一套坐标系，相机空间,窗口坐标 ，屏幕坐标2d 
    b.外观建模，材料，光源照射物体上的反射（阴影），  
    c.投影：正投，透视  
    d.镶嵌、几何图形着色器（例子生成），流输出  	e.剪切Clipping  
    f.屏幕映射 Screen Mapping   
2. 栅格化  
	- 三角形设置  
	- 三角形遍历  
	- 
3. xx  
-end

---

GPU 渲染管线和硬件架构浅谈  
- 所谓渲染管线，就是 CPU 传送给 GPU 一堆数据（顶点、纹理等），经过一系列处理，最后渲染得出来一副二维图像。有以下几个阶段。  
	- IMR  
	- TBR  
	  - 屏幕分成一个一个Tile（32x32），GPU只绘制一个，然后写到FrameBuffer。  
	  1. 处理所有顶点，生成一个tile list的中间数据，保存每个图元属于哪个tile  
	  2. 针对每个tile，执行像素处理。
	- TBDR  
- 内存
	- SRAM，速度快，片内存储L1，L2 catch，4M,12M，26-37M
	> L1/L2 缓存是片上缓存，速度很快，但是通常比较小。比如 L1 cache 通常在 32KB~256KB 这个级别。而 L3 cache 可以达到 8MB\~32MB 这个级别。像苹果的 M1 芯片（CPU 和 GPU 等单元在一个硬件上，SoC），L3 缓存是给所有硬件单元使用的，所以也被称为 System Level Cache。
	> L1 缓存分为指令缓存（I-Cache）和数据缓存（D-Cache），CPU 针对指令和数据有不同的缓存策略。
	> L1 缓存不可能设计的很大。因为增大 L1 缓存虽然会减少 L1 cache missing，但是会增加访问的时钟周期，也就是说降低了 L1 cache 的性能。
	> CPU 的 L1/L2 缓存需要处理缓存一致性问题。即不同核心之间的 L1 缓存之间的数据应该是一致的。当一个核心的 L1 中的数据发生变化，其他核心的 L1 中的相应数据需要标记无效。而 GPU 的缓存不需要处理这个问题。
	> CPU 查找数据的时候按照 L1-->L2-->L3-->DRAM 的顺序进行。当数据不在缓存中时，需要从主存中加载，就会有很大的延迟。
	> CPU 是通过大容量高速缓存，**分支预测**，乱序执行（Out-of-Order）等手段来遮掩延迟  
	> GPU靠warp
	- DRAM，DDR  
	- GDDR，显存ddr    
	- LPDDR  
	- UFS  
- 超标量设计，super scalar  
- 乱序执行 
- 超线程  
	> Intel CPU 也有使用 GPU 的思路，准备两套寄存器，CPU 核心在两个线程之间切换的成本就非常低。这样一个核心就可以当做两个核心来使用。这就是超线程技术。不过 CPU 毕竟不像 GPU 有大量寄存器，核心在两个线程之间切换，并不一定能够保证降低延迟，同时不能准确控制每个线程的执行时间。所以很多游戏以及高性能计算程序都是关闭超线程的。
- 2.3 GPU渲染过程  
- warp，线约束，32个线程，GPU计算核心最小的工作单元。SIMD/SIMT    
- SM，streaming Multiprocessor 负责处理顶点着色器  
- 光栅化引擎 SOP   
- 片元，生成像素线程。  
- Catch line  GPU和缓存之间交换数据
- > Cache line 不仅仅是为了字节对齐128字节。也有现实意义。想要知道是否缓存命中，是否写入主存，肯定要有标记位。所以一个 Cache line 就是标记位+地址偏移+实际数据。
- DLP，data level parallelism  
- TLP  
- ILP  
- Latency hiding  
- warp Divergence 条件分钟，两个都走一遍，mask掉不要的。  
- pixel quad 2x2像素  
- depth test stencil test ROP  
- EarlyZS  
- FIFO 保序  
- >mesa（开源的 opengl 实现。包含 freedreno，一个开源的 adreno 驱动。如果对驱动实现细节感兴趣，比如 early-z、lrz 的实现原理，强烈推荐阅读，这个是网上少有的代码级别的资料）
- 
---
- shader model
- 定点着色器：模型空间->齐次裁剪空间  
- geometry shader：输出点、折线、三角形  
- stream output  
- pixel shader：处理场景光照和与之相关的效果，凹凸纹理映射和调色。  
- z-buffer  
- gamma correction：对光线或三色值进行非线性运算。利用人眼对光线或黑白的感知。  
- 

------

### texturing  

- 使用图像、函数改变物体表面外观的计数  
- 纹理压缩，DXTC  
- 

------

### Deferred Shading  

- co-issue，把不同长度的指令拼接，填充，发挥SIMD又是

- Unified Shader Arch：VS和PS任务不均衡  
- MMIO，memory mapped io  
- 双缓冲，画面撕裂，V-sync  
- LOD  
ext  
