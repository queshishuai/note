openGL
2023.03.02
---

- vertex buffer  
- shader:运行在GPU上的程序  
- draw call  
- legancy 
```
glBegin(GL_TRIANGLES);
__TODO__
glEnd();
```  
- morden  
```
GLuint buffer;
glGenBuffers(1,&buffer);
glBindBuffer(GL_ARRAY_BUFFER,buffer);
glBufferData(GL_ARRAY_BUFFER,6*sizeof(float), position,GL_STATIC_DRAW);
glDrawArrays(GL_TRIANGLES,0,3);
```
- 
