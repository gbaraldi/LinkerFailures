## Dynamic linking breaking change in Macos Ventura

Macos Ventura introduced a change of behaviour when loading shared libraries via `dlopen`. The specific difference relates to how fallback libraries are looked up. 

As an example, on reproducerarm, `libarmadillo` declares a dependency on `libc++`, and sets its path as `@rpath/libc++.1.dylib`. There is no `libc++` there, so it's not found while doing the direct lookup. The difference is here, where in Monterey the library is found in  `DYLD_FRAMEWORK/LIBRARY_FALLBACK_PATH`, in Ventura it does not check the fallback location, throwing the following error during execution:
```
(null)
dlopen(@executable_path/lib/libarmadillo.11.2.1.dylib, 0x0001): Library not loaded: @rpath/libc++.1.dylib
  Referenced from: <0FE97CBA-010A-3306-A741-9053A6B6181B> /Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib
  Reason: tried: '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib' (no such file),
  '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib' (no such file),
  '/System/Volumes/Preboot/Cryptexes/OS@rpath/libc++.1.dylib' (no such file), 
  '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib' (no such file),
  '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib' (no such file)
```
The output when running in Macos 12 has no errors as expected
```
(null)
(null)
```

Using `DYLD_PRINT_SEARCHING=1 DYLD_PRINT_TO_FILE=dyld.log` it's possible to visualize where the difference is.

Macos 12.4

```
...
dyld[10018]: find path "@rpath/libc++.1.dylib"
dyld[10018]:   LC_RPATH '@loader_path/.' from '/Users/julia/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[10018]:   possible path(@path expansion): "/Users/julia/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[10018]:   LC_RPATH '@loader_path/.' from '/Users/julia/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[10018]:   possible path(@path expansion): "/Users/julia/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[10018]:   possible path(DYLD_FRAMEWORK/LIBRARY_FALLBACK_PATH): "/Users/julia/lib/libc++.1.dylib"
dyld[10018]:   possible path(DYLD_FRAMEWORK/LIBRARY_FALLBACK_PATH): "/usr/local/lib/libc++.1.dylib"
dyld[10018]:   possible path(DYLD_FRAMEWORK/LIBRARY_FALLBACK_PATH): "/lib/libc++.1.dylib"
dyld[10018]:   possible path(DYLD_FRAMEWORK/LIBRARY_FALLBACK_PATH): "/usr/lib/libc++.1.dylib"
dyld[10018]:   found: already-loaded-by-path: "/usr/lib/libc++.1.dylib"
```

Macos 13.0

```
...
dyld[52173]: find path "@rpath/libc++.1.dylib"
dyld[52173]:   LC_RPATH '@loader_path/.' from '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[52173]:   possible path(@path expansion): "/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[52173]:   LC_RPATH '@loader_path/.' from '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[52173]:   possible path(@path expansion): "/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[52173]:   possible path(cryptex prefix): "/System/Volumes/Preboot/Cryptexes/OS@rpath/libc++.1.dylib"
dyld[52173]:   LC_RPATH '@loader_path/.' from '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[52173]:   possible path(@path expansion): "/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[52173]:   LC_RPATH '@loader_path/.' from '/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/libarmadillo.11.2.1.dylib'
dyld[52173]:   possible path(@path expansion): "/Users/gabrielbaraldi/Documents/LinkerFailures/reproducerarm/lib/./libc++.1.dylib"
dyld[52173]:   not found: "@rpath/libc++.1.dylib"
```

The source code for the new version of dyld hasn't been released, so inspecting it directly is not currently possible,

Reproducers 1,2,3 use intel binaries but also fail under rosetta, while reproducerarm will only run on an M series equipped machine.


This downloads binaries from https://github.com/JuliaPackaging/Yggdrasil , which holds the binary dependencies of the julia programming
language.
