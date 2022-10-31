curl -L https://github.com/JuliaBinaryWrappers/CompilerSupportLibraries_jll.jl/releases/download/CompilerSupportLibraries-v0.5.4%2B0/CompilerSupportLibraries.v0.5.4.x86_64-apple-darwin-libgfortran5.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/armadillo_jll.jl/releases/download/armadillo-v11.2.1%2B0/armadillo.v11.2.1.x86_64-apple-darwin.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/OpenBLAS_jll.jl/releases/download/OpenBLAS-v0.3.21%2B3/OpenBLAS.v0.3.21.x86_64-apple-darwin-libgfortran5.tar.gz | tar - -xz
install_name_tool -change /usr/lib/libc++.1.dylib @rpath/libc++.1.dylib lib/libarmadillo.11.2.1.dylib

clang test3.c -o test3 -arch x86_64
./test3
