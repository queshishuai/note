# 2023年1月28日23:48:05
---  
### 语法  
- CMakeList.txt  
  - cmake_minimum_required(VERSION 3.10)  
  - project(pname)  
  - SET(CMAKE_C_COMPILER "C:\\MinGW\\bin\\gcc.exe")
  - SET(CMAKE_CXX_COMPILER "C:\\MinGW\\bin\\g++.exe")
  - add_executable(pname *.cpp)  
- cmake -G "MinGW Makefiles"  
- make  
- 
