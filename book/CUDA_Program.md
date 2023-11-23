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











