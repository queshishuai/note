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
- vertex is more than a position  
- layout  
```
glEnableVertexAttribArray(0);
glVertexAttribPointer(0,2, GL_FLOAT,false,2*sizeof(float),(const void*)0);
```
- default shader,depends on GPU driver

```
//编译
GLuint id = glCreateShader(type);
glShaderSource(id,1,&src,NULL);
glCompileShader(id);
//连接    
GLuint vs = CompilerShader(GL_VERTEX_SHADER,vertexShader);
GLuint fs = CompilerShader(GL_FRAGMENT_SHADER,fragmentShader);
GLuint program = glCreateProgram();
glAttachShader(program,vs);
glAttachShader(program, fs);
glLinkProgram(program);
//glValidateProgram(program);  

//install
GLint shader = CreatShader(vs,fs);
glUseProgram(shader);
```

```
enum ShaderType
{
    invalid = -1,
    vertex,
    fragment
};
struct ShaderSource
{
    std::string vertexSource;
    std::string fragmentSource;
};
ShaderSource ParseShader(const std::string& filePath)
{
    std::fstream stream(filePath);
    std::string line;
    int type = ShaderType::invalid;
    std::stringstream ss[2];
    while (getline(stream,line))
    {
        if (line.find("#shader") != std::string::npos)
        {
            if (line.find("vertex") != std::string::npos)
                type = ShaderType::vertex;
            else if (line.find("#shader") != std::string::npos)
                type = ShaderType::fragment;
        }
        else
        {
            ss[(int)type] << line << "\n";
        }
    }
    return { ss[0].str(),ss[1].str() };
}
```
   
- index buffer  
- glGetErr()  
```
#define ASSERT(x) if(!x) __debugbreak()
#define GLCall(x) GLClearError();\
    x;\
    ASSERT(GLLogErr(#x,__LINE__,__FILE__))

static void GLClearError()
{
    while (GL_NO_ERROR != glGetError());
}
static GLboolean GLLogErr()
{
    while (GLenum err = glGetError())
    {
        std::cout << "err code" << err << std::endl;
        return false;
    }
    return true;
}
```  
- uniform  
```
   GLCall(GLuint location = glGetUniformLocation(shader, "u_Color"));
    ASSERT(location == -1);
    GLCall(glUniform4f(location,1.0f,0.5f,0.5f,0.3f));
 ```
 - vertex array  
 - 
