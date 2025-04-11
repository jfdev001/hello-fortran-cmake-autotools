# hello-fortran-cmake-autotools

It is not uncommon to encounter codebases that are built with GNU autotools.
You might want to use such codebases as a dependency in your Fortran project that
you build with CMake. This repository demonstrates how one can integrate 
[rte-rrtmgp](https://github.com/earth-system-radiation/rte-rrtmgp/tree/autoconf),
which is built with autotools, into a minimal CMake project. 

Call the below to configure, build, and test the project.

```shell
./config_build_test
```

Tested only on Ubuntu 24.04.2 LTS.
