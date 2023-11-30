## CUDA，Jack Dongarra，2011  

---

- 2023年11月23日16:07:45  
###  overview  
- OpenCL,异构计算的行业标准  
- parallel computing  
- Silicon Graphics，OpenGL，1992  
- GeForce 3,2001，DX8  
- GeForce8800GTX，2006，cuda  
- 
### cuda c
---
- 主机、设备  
- Kernel核函数，在GPU设备上执行的函数  
- `__global__`修饰设备函数  
- 
	- 可以将cudaMalloc()分配的指针传给设备执行函数  
	- 可以设备代码使用cudaMalloc()分配的指针读写内存  
	- 可以在主机上传递分配的指针，不能读写内存  
	- 
- cudaMemcpy(,cudaMemcpyDeviceToHost)  
- 查询设备`cudaGetDeviceCount(&count)`  
- `cudaDeviceProp`  
- `cudaGetDeviceProperties`  
- SLI,Scalable link interface  
- 
### cuda并行 
---
- 尖括号
	- 第一个，设备在执行核函数时使用的并行线程块的数量  
    - 第二个，每个线程块启动几个线程
- 内置变量`blockIdx`
```
add<<<N,1>>>(dev_c,dev_a,dev_b);
__global__ void add(int *a,int *b,int *c)
{
	int tid = blockIdx.x;//计算位于这个索引处的数据
	if(tid < N)
		c[tid] = a[tid] + b[tid];
}
```
- 线程块block  
- 线程格Grid，并行线程块的集合  
- GPU有完善的内存管理机制，  
- N<=65535,硬件限制  
- Julia集  
- `__device__`,在gpu执行，只能从其他device或global调用  
- `gridDim`,`blockIdx`  
- 
### 线程协作  
---
- `threadIdx.x`  
- thread,最大512个  
- `int tid = threadIdx.x + blockIdx. * blockDim.x`  
- `tid += blockDim.x * gridim.x`  
- 喜欢粘贴代码  
- 炫耀  
- 
- 共享内存和同步  
- `__share__`  
- 普通内存，线程块创建变量的副本，每个线程共享，其他线程块不可见，驻留在物理GPU上  

- race condition  
- `__syncthreads();`线程同步函数，除非每个线程块都执行了`__sync`  
- reduction，规约  
- thread divergence 线程发散  
- 
### 常量内存  
---
- Constant Memory  
- 全局内存、共享内存、常量内存  
- `__constant__`  
- `cudaMemcpyToSymbol();`复制到常量内存  
- `cudaMemcpy();`复制到全局内存  
- 64KB  
- Ray tracing，从摄像头投射光照到物体模型上，二次射线、三次射线  
- Warp线程束，32个线程的集合  
- LockStep  
- 半线程束广播  
- 

- cuda事件API  
- GPU时间戳  
```
cudaEvent_t start;
cudaEventCreate(&start);
cudaEventRecord(start,0);

cudaEventCreate(&stop);
cudaEventRecord(start,0);
/*do sth*/
cudaEventRecord(stop,0);
cudaEventSynchronize(stop);

cudaEventElapsedTime();
cudaEventDestroy();
```
- 
### 纹理内存  
---
- 内存访问的空间局部性  
- `texture<float，2> texConstSrc`  
- `cudaBindTexture()`  
- 编译器内置函数，intrinsic  
- 芯片上的缓存  
- 
- 图形互操作性  
- 原子性  
- 计算直方图  
- `atomicAdd(addr,y);`  
- 共享原子操作和全局原子性  
- 2阶的算法  
- 流  
- 页锁定（page-locked）类型的主机内存，固定内存pinned memory，不可分页内存  
- 主机内存`dudaHostAlloc()`  
- 不会分页，不会交换到磁盘，始终驻留在物理内存。  
- cuda流，GPU操作队列，有序的操作队列  
- device overlap  
- `cudaMemcpyAsnc()`  
- 第一次放入流中的复制操作将在第二次赋值操作之前执行  
- GPU的工作调度机制  
- 内存复制和核函数执行采用不同的引擎  
- 宽度优先而不是深度优先  
- 









