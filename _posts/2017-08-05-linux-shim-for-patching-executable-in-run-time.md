---
id: 37
title: Linux shim for Patching executable in run-time
date: 2017-08-05T12:00:00-03:00
author: Lucas Teske
layout: post
guid: https://medium.com/@lucasteske/linux-shim-for-patching-executable-in-run-time-9cdcd773ed98
permalink: /2017/08/linux-shim-for-patching-executable-in-run-time/
categories:
  - English
  - Reverse Engineering
  - Hacking
tags:
  - Hacking
  - Linux
  - C
  - Programming
  - Shim
---

# Linux shim for Patching executable in run-time

That's something I already did a long time and few people know. It's not something hard or complex to do, but few people know how easy is to make a Library Shim.

### First, what's a shim?

A shim is a small library that can intercept API calls transparently for a specific program / library. Basically its a proxy library that can transparently intercept some API calls to either change the content, monitor the data or just making a API translation. That has its variants over all Operating Systems (Linux, Mac OSX, Windows) but I will talk mainly about Linux here (which is the OS I use).

### Creating our executable

What's our target? We will create an example executable that print some info in the screen an opens a file to write some content. Then we will make a shim to monitor (like a debugger) those calls. In the second part we will do some run-time executable patching.

### Our first example executable

Let's do some C Code and make an executable that prints some stuff, opens a file, write stuff and closes it. We can do something like this:

```c
#include <stdio.h>
#include <string.h>

char myData[100] = "That's my super important data!\n";

int main(void) {
  printf("That's my amazing program!\n");
  FILE *f = fopen("myotherfile.txt", "w");
  fwrite(myData, strlen(myData), 1, f);
  fclose(f);
  return 0;
}
```

What this program does is to print a **That's my amazing program!** in the output and write the contents of the variable **myData** (null terminated) inside a file named **myotherfile.txt**. Ok so let's run and see if everything went alright:

```
┌─[lucas@nblucas] — [/media/ELTN/Hacks/shim] — [Sat Aug 05, 20:19]
└─[$] <> gcc ouramazingprogram.c -o amazingprogram
┌─[lucas@nblucas] — [/media/ELTN/Hacks/shim] — [Sat Aug 05, 20:19]
└─[$] <> ./amazingprogram
That’s my amazing program!
┌─[lucas@nblucas] — [/media/ELTN/Hacks/shim] — [Sat Aug 05, 20:19]
└─[$] <> cat myotherfile.txt
That’s my super important data!
```

Ok, so far so good! Now let's shim it!

### **Shimming our executable**

The process of shimming is pretty simple at first. We just need to create a library that contains a function that has **exactly** the name and parameters of the function we're trying to call. We will also need to load the original function somewhere, but first let's try to replace the entire call starting with **fopen**.

Its really important that the call is exactly the same. Since *fopen* is a *libc* call, let's take a look somewhere for how the function is declared. I *usually* check at [http://www.cplusplus.com](http://www.cplusplus.com) or (google). The *fopen* call is here: [http://www.cplusplus.com/reference/cstdio/fopen/](http://www.cplusplus.com/reference/cstdio/printf/)

Let's do something … hmmm … interesting. Let's print a message in *fopen* and return *stdout* as a file descriptor. That way it will write the output to the console. So that's how we will write our library:

```c
#include <stdio.h>

FILE * fopen ( const char * filename, const char * mode ) {
  printf("HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE\n");
  return stdout;
}
```

That's pretty simple huh? Just create an exact copy of *fopen*. How we compile / run it? For compiling just compile as a shared library:

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:33]
└─[$] <> gcc -Wall -O2 -fpic -shared -ldl shim.c -o shim.so
```

And for running with our executable we will use a Library Loader trick with **LD_PRELOAD** environment variable specifying a library to preload.

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:33]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
```

This will tell the library loader to first try to load the **shim.so** library and them load other libraries. The way the Library Loader works is that it searches for all calls that are external from your application (from other libraries) and try to resolves them using the system libraries, but since we're telling it to load first our shim library, it will fill the gap where the fopen is wanted with our fopen call. Let's run to see what happens:

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:40]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
That's my amazing program!
HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE
That's my super important data!
```
Hey hey, watch-out! We just leaked what we wrote in the file to the console! But what if we wanted to write to another file and not to stdout? How we would call the *real* fopen? I mean, we could use the open syscall right?

Yes we could, but let's use the original fopen, since in most ways you would want to proxy the original call.

### Using the library loader to load the fopen call

Ok, that's a bit more trickier than shimming, but still not too hard. Remember that I just said that the Library Loader loads the methods from the system libraries? It does that **by name**. It's not very hard to find it since we know its called **fopen**. For that we can use the **dlsym** call that loads a file by name. You can see the details here [https://linux.die.net/man/3/dlsym](https://linux.die.net/man/3/dlsym)

The **dlsym** call will return a pointer to the function (if it finds) or null if doesn't. Still we need to store it somewhere so we can call it. That's the part not many programmers know about it (C/C++ probably should know that) is that you can store pointers to functions and just call them normally. For that we will create a pointer to function for fopen:

```c
static FILE *(*real_fopen)(const char *, const char *) = NULL;
```

We will call it **real_fopen** to not conflict with our current fopen. We will also need to load it somewhere. We can use another trick thing that is the library constructor attribute:

```c
__attribute__((constructor))
```
When a function is marked with that attribute, that piece of code will execute as soon everything is loaded into memory, before calling the main function. We can use it to initialize our *real* calls.

```c
void __attribute__((constructor)) initialize(void) {
  real_fopen = dlsym(RTLD_NEXT, "fopen");

  if (real_fopen == NULL) {
    printf("What? We couldn't find our fopen!!!!\n");
    exit(255); // This will crash the program since
               // it isn't expecting to exit in the constructor
  }
}
```

That way, we will have *real_fopen* loaded (if nothing bad occurs) at anytime our program calls *fopen*. Let's redirect our call to another file:

```c
// For RTLD_NEXT
#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>


static FILE *(*real_fopen)(const char *, const char *) = NULL;

FILE * fopen ( const char * filename, const char * mode ) {
  printf("HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE\n");
  printf("MI NO LIK U FIL, MI UPEN HUE.TXT\n");

  return real_fopen("hue.txt", "w");
}

void __attribute__((constructor)) initialize(void) {
  real_fopen = dlsym(RTLD_NEXT, "fopen");

  if (real_fopen == NULL) {
    printf("What? We couldn't find our fopen!!!!\n");
    exit(255); // This will crash the program since it isn't expecting to exit in the constructor
  }
}
```

Let's run it!

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:58]
└─[$] <> gcc -Wall -O2 -fpic -shared shim.c -ldl -o shim.so
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:58]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
That's my amazing program!
HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE
MI NO LIK U FIL, MI UPEN HUE.TXT
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 20:58]
└─[$] <> cat hue.txt
That's my super important data!
```

Bingo! We successfully loaded the original fopen and loaded another file.

### Runtime Binary Patching

Now let's go to patching. Suppose we want to change the content that is being wrote to the file. We could just hook the *fwrite* call but that would lead to all write calls being changed or at least *proxied*. If we know that variable is in memory (like our super important data is) we could just change it right?

Not directly. Luckily (or sadly) we can call **mprotect** to change the read/write flags from a specific memory section (you can see here [http://man7.org/linux/man-pages/man2/mprotect.2.html](http://man7.org/linux/man-pages/man2/mprotect.2.html) ). With that we can say that we want to write it to some specific memory address that was intended to be read only and change the content. But we don't exactly know where it is, so we will probably need to search it. Let's implement a search function, that won't need the *mprotect* call so far.

### **Searching for some content in memory**

First we need to know where to search it. With *objdump* we can check where the sections get stored in memory. That might change from compiler (read linker) to compiler, but for *gcc *I found that it has a pretty standard starting point for each section. So let's check for or *amazingapp* (I compiled in 64 bit machine).

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 22:24]
└─[$] <> objdump -x -j .text amazingprogram

amazingprogram: formato do arquivo elf64-x86-64
amazingprogram
arquitetura: i386:x86-64, sinalizações 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
começar o endereço 0x0000000000400550

Cabeçalho do Programa:
    PHDR off    0x0000000000000040 vaddr 0x0000000000400040 paddr 0x0000000000400040 align 2**3
         filesz 0x00000000000001f8 memsz 0x00000000000001f8 flags r-x
  INTERP off    0x0000000000000238 vaddr 0x0000000000400238 paddr 0x0000000000400238 align 2**0
         filesz 0x000000000000001c memsz 0x000000000000001c flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000400000 align 2**21
         filesz 0x000000000000088c memsz 0x000000000000088c flags r-x
    LOAD off    0x0000000000000e10 vaddr 0x0000000000600e10 paddr 0x0000000000600e10 align 2**21
         filesz 0x00000000000002d4 memsz 0x00000000000002d8 flags rw-
 DYNAMIC off    0x0000000000000e28 vaddr 0x0000000000600e28 paddr 0x0000000000600e28 align 2**3
         filesz 0x00000000000001d0 memsz 0x00000000000001d0 flags rw-
    NOTE off    0x0000000000000254 vaddr 0x0000000000400254 paddr 0x0000000000400254 align 2**2
         filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
EH_FRAME off    0x0000000000000764 vaddr 0x0000000000400764 paddr 0x0000000000400764 align 2**2
         filesz 0x0000000000000034 memsz 0x0000000000000034 flags r--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
   RELRO off    0x0000000000000e10 vaddr 0x0000000000600e10 paddr 0x0000000000600e10 align 2**0
         filesz 0x00000000000001f0 memsz 0x00000000000001f0 flags r--

Seção Dinâmica:
  NEEDED               libc.so.6
  INIT                 0x00000000004004a8
  FINI                 0x0000000000400724
  INIT_ARRAY           0x0000000000600e10
  INIT_ARRAYSZ         0x0000000000000008
  FINI_ARRAY           0x0000000000600e18
  FINI_ARRAYSZ         0x0000000000000008
  GNU_HASH             0x0000000000400298
  STRTAB               0x0000000000400378
  SYMTAB               0x00000000004002b8
  STRSZ                0x0000000000000058
  SYMENT               0x0000000000000018
  DEBUG                0x0000000000000000
  PLTGOT               0x0000000000601000
  PLTRELSZ             0x0000000000000090
  PLTREL               0x0000000000000007
  JMPREL               0x0000000000400418
  RELA                 0x0000000000400400
  RELASZ               0x0000000000000018
  RELAENT              0x0000000000000018
  VERNEED              0x00000000004003e0
  VERNEEDNUM           0x0000000000000001
  VERSYM               0x00000000004003d0

Referências da Versão:
  requerido a partir de libc.so.6:
    0x09691a75 0x00 02 GLIBC_2.2.5

Seções:
Idx Tamanho do Nome do Arquivo VMA LMA sem Algn
 13 .text         000001d2  0000000000400550  0000000000400550  00000550  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
SYMBOL TABLE:
0000000000400550 l    d  .text 0000000000000000              .text
0000000000400580 l     F .text 0000000000000000              deregister_tm_clones
00000000004005c0 l     F .text 0000000000000000              register_tm_clones
0000000000400600 l     F .text 0000000000000000              __do_global_dtors_aux
0000000000400620 l     F .text 0000000000000000              frame_dummy
0000000000400720 g     F .text 0000000000000002              __libc_csu_fini
00000000004006b0 g     F .text 0000000000000065              __libc_csu_init
0000000000400550 g     F .text 000000000000002a              _start
0000000000400646 g     F .text 000000000000005b              main
```

We know that it probably is inside the .text section (where the code is) but let's implement a search function that will search for **That’s**.

```c
void *searchData(char *data, int len, void *start, void *end) {
  void *i;

  for(i = start; i < end; i += 1) {
    if (memcmp(i, data, len) == 0 && i != (void *)data) {
      return i;
    }
  }

  return NULL;
}
```

What that function will do is iterate over each position in a range that we specify and use *memcmp* (see [http://www.cplusplus.com/reference/cstring/memcmp/?kw=memcmp ) ](http://www.cplusplus.com/reference/cstring/memcmp/?kw=memcmp)to check if the memory at the pointer and the array are equal. It returns the position if it finds, or null if doesn't. It will also make sure that we don't find the "signature" that we're using to search as well.

Then let's try on our constructor function to see if we can find it.

```c
// For RTLD_NEXT
#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>
#include <string.h>

static FILE *(*real_fopen)(const char *, const char *) = NULL;

#define SEARCH_TOKEN_SIZE 6
char mySearchToken[SEARCH_TOKEN_SIZE] = "That's";

void *searchData(char *data, int len, void *start, void *end) {
  void *i;

  for(i = start; i < end; i += 1) {
    if (memcmp(i, data, len) == 0 && i != (void *)data) {
      return i;
    }
  }

  return NULL;
}


FILE * fopen ( const char * filename, const char * mode ) {
  printf("HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE\n");
  printf("MI NO LIK U FIL, MI UPEN HUE.TXT\n");

  return real_fopen("hue.txt", "w");
}

void __attribute__((constructor)) initialize(void) {
  real_fopen = dlsym(RTLD_NEXT, "fopen");

  if (real_fopen == NULL) {
    printf("What? We couldn't find our fopen!!!!\n");
    exit(255); // This will crash the program since it isn't expecting to exit in the constructor
  }

  void *addr = searchData(mySearchToken, SEARCH_TOKEN_SIZE, (void *)0x4006e0, (void*)0x400791 ); // Thats for 64 bit.

  printf("Token Addr: %p\n", addr);
}
```

And run:

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 21:45]
└─[$] <> gcc -Wall -O2 -fpic -shared shim.c -ldl -o shim.so
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 21:47]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
Token Addr: 0x400734
That's my amazing program!
HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE
MI NO LIK U FIL, MI UPEN HUE.TXT
```

It found at 0x400734! That matches what we saw in objdump call! Let's try to change it with:

```c
((char *)addr)[0] = 'Z';
```

And run

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 21:48]
└─[$] <> gcc -Wall -O2 -fpic -shared shim.c -ldl -o shim.so
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 21:49]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
Token Addr: 0x400734
[1]    27516 segmentation fault (core dumped)  LD_PRELOAD="./shim.so" ./amazingprogram
```

What happened? That's because what I said early. That memory section is protected so we get a segmentation fault. But fear not! We will slash that protection out!

### Removing the memory protection with mprotect

For removing the memory protection we will call *mprotect*. The *mprotect* actually work on memory pages so we will need to change the protection flag for the whole page. For that we will need to do some operations over the address to be able to unlock the page and assume some page size (that is usually 4096).

```c
void unprotectPage(uint64_t addr) {
  mprotect((void*)(addr-(addr%4096)),4096,PROT_READ|PROT_WRITE|PROT_EXEC);
}
```

That will call mprotect with the address pointed to the start of the page (aligned to 4096 size) and set the READ/WRITE/EXEC flag to that page (so 4096 bytes). Notice that this will allow even code execution on that page. With that function we can just call unprotectPage with the variable address.

```c
printf("Token Addr: %p\n", addr);
unprotectPage((uint64_t)(addr));
printf("Unprotected!\n");
((char *)addr)[0] = 'Z';
```

That's our code:

```c
// For RTLD_NEXT
#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <stdint.h>

static FILE *(*real_fopen)(const char *, const char *) = NULL;

#define SEARCH_TOKEN_SIZE 6
char mySearchToken[SEARCH_TOKEN_SIZE] = "That's";

void *searchData(char *data, int len, void *start, void *end) {
  void *i;

  for(i = start; i < end; i += 1) {
    if (memcmp(i, data, len) == 0 && i != (void *)data) {
      return i;
    }
  }

  return NULL;
}


FILE * fopen ( const char * filename, const char * mode ) {
  printf("HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE\n");
  printf("MI NO LIK U FIL, MI UPEN HUE.TXT\n");

  return real_fopen("hue.txt", "w");
}

void unprotectPage(uint64_t addr) {
  mprotect((void*)(addr-(addr%4096)),4096,PROT_READ|PROT_WRITE|PROT_EXEC);
}

void __attribute__((constructor)) initialize(void) {
  real_fopen = dlsym(RTLD_NEXT, "fopen");

  if (real_fopen == NULL) {
    printf("What? We couldn't find our fopen!!!!\n");
    exit(255); // This will crash the program since it isn't expecting to exit in the constructor
  }

  void *addr = searchData(mySearchToken, SEARCH_TOKEN_SIZE, (void *)0x400040, (void*)0x400800 ); // Thats for 64 bit.

  printf("Token Addr: %p\n", addr);
  unprotectPage((uint64_t)(addr));
  printf("Unprotected!\n");
  ((char *)addr)[0] = 'Z';
}
```

Now let's compile and run:

```
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 22:46]
└─[$] <> gcc -Wall -O2 -fpic -shared shim.c -ldl -o shim.so
┌─[lucas@nblucas] - [/media/ELTN/Hacks/shim] - [Sáb Ago 05, 22:49]
└─[$] <> LD_PRELOAD="./shim.so" ./amazingprogram
Token Addr: 0x400734
Unprotected!
Zhat's my amazing program!
HUEBR, GIBE DATA PLOS, OR I REPORT U HUEHUE
MI NO LIK U FIL, MI UPEN HUE.TXT
```

It worked! We changed the addr[0] to Z, so it printed **Zhat's my amazing program!**

### Final Thoughts

I just demonstrated a very simple way to patch binaries during run-time using shims. You can use that for changing code directions or to edit some program code without actually changing the binary in disk. I also showed that you can use a signature to find what you want in the program memory space. In the future I will show you how you can rewrite the program behavior to act like you want (like cracking an executable) without changing anything in the executable.

I hope you like it. It's very simple, but I hope I was clear to you guys the power that you have using *mprotect* and shim over linux binaries.

See you next time!
