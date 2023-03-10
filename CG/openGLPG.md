## OpenGL programming guide
06/03/2023
---
### Chapter 1
- opengl4.5  
- DSA，direct state access  
- 500个命令  
- 着色器，6种，定点着色，片元着色  
- 传递着色器 pass-through shader  
- `#version 450 core`  
- core profile  
- layout qualifier布局限定符  
- 着色管线装配  
```
glEnable();
glDisable();
gllsEnabled();
```
### Chapter 2  
--- 
- GLSL,main没有入参  
	- in  
	- out  
	- uniform从应用程序中接收数据，不随vertex变化  	- const
	- buffer
	- shared  
- 数据类型  
	- 透明类型，int..
	- 不透明类型，image..句柄
- 变量声明的同时初始化  
	- 浮点必须包含小数点，f\lF  
	- 
- 转换构造函数  
```
float f = 10.0;
int ten = int(f);
```
- 聚合类型  
	- mat4x3，列x行  
	- 先填充列，主对角线填充  
- 访问向量和矩阵中的元素  
	- 分量访问符 
	- 数组的长度`coeff.length()`，编译时常量  
	- 
2.3.3 语句 
	- 算术操作  
	- 流控制  
	- 函数， 
	- 函数参数限制符  in(default)、const in、out、inout
	- 
2.3.4 计算的不变性  
- 不同shader、硬件对同一个计算式不同
- invariant  
- precise  
- 调试`#pragma STDGL invariant(all)`  
- fma，fused multiply-and-add  
- 扩展功能`#extension all:<directive>`

2.4 数据块接口  
- uniform块  
```
uniform b{
	vec4 v1;
	bool v2;
}name;
```
- uniform buffer object  
- 访问`glMapBuffer`  
- 布局：`layout(packed,column_major) uniform`  
2.5 spir-V  
- 严格，语法表达规范  
- 调度和寄存器分配算法  

### Chapter 3 绘制  
---
- 图元：点、线、三角形  
- 点，四边形区域模拟`gl_PointSize`  
- 点精灵，渲染点,片元`gl_PointCoord`  
- line loop   
- line strip  
- diamond exit规则`glLineWidth()`  
- 多边形,正面，反面`glPolygonMode`   
3.2 缓存数据  
- 对象`glCreatBuffers()`  
- 分配内存`glNamedBufferStorage()`  
- 绑定`glBindBuffer()`  
- 免拷贝`glMapBuffer()\glUnmapNamedBuffer()`  
- `glMapNamedBufferRange`  
- 丢弃缓存数据`glInvalidateBufferData()`  
3.3 draw  
- 索引`glDrawElements()`  
- 非索引`glDrawArrays()`  

### Chapter 4 
---
