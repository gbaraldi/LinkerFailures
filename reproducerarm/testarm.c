#include <stdio.h>
#include <dlfcn.h>
int main()
{
    dlopen("@executable_path/lib/libopenblas64_.0.3.21.dylib",  0x0001);
    printf("%s\n", dlerror());
    dlopen("@executable_path/lib/libarmadillo.11.2.1.dylib",0x0001);
    printf("%s\n", dlerror());
}