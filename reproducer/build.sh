curl -L https://github.com/JuliaBinaryWrappers/CompilerSupportLibraries_jll.jl/releases/download/CompilerSupportLibraries-v0.5.4%2B0/CompilerSupportLibraries.v0.5.4.x86_64-apple-darwin-libgfortran5.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/armadillo_jll.jl/releases/download/armadillo-v9.850.1%2B3/armadillo.v9.850.1.x86_64-apple-darwin14.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/OpenBLAS_jll.jl/releases/download/OpenBLAS-v0.3.21%2B3/OpenBLAS.v0.3.21.x86_64-apple-darwin-libgfortran5.tar.gz | tar - -xz
clang test.c -o test -arch x86_64
./test