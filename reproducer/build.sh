curl -L https://github.com/JuliaBinaryWrappers/CompilerSupportLibraries_jll.jl/releases/download/CompilerSupportLibraries-v0.5.4%2B0/CompilerSupportLibraries.v0.5.4.x86_64-apple-darwin-libgfortran5.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/PCRE2_jll.jl/releases/download/PCRE2-v10.40.0%2B1/PCRE2.v10.40.0.x86_64-apple-darwin.tar.gz | tar - -xz
curl -L https://github.com/JuliaBinaryWrappers/libcleri_jll.jl/releases/download/libcleri-v0.12.1%2B2/libcleri.v0.12.1.x86_64-apple-darwin.tar.gz | tar - -xz
clang test.c -o test -arch x86_64
./test
