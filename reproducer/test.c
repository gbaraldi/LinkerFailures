#include <dlfcn.h>
#include <stdio.h>

int main() {
  dlopen("@executable_path/lib/libgcc_s.1.dylib",
         0x0001);
  printf("%s\n", dlerror());
  dlopen("@executable_path/lib/libpcre2-8.0.dylib",
         0x0001);
  printf("%s\n", dlerror());
  dlopen("@executable_path/lib/libcleri.dylib.0.12.1",
         0x0001);
  printf("%s\n", dlerror());
}
