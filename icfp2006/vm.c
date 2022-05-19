#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>

#ifdef __linux__
    #include <byteswap.h>
    #define bswap32 __bswap_32
#elif defined(__APPLE__)
    #include <libkern/OSByteOrder.h>
    #define bswap32 OSSwapInt32
#else
    #include <sys/endian.h>
#endif

typedef uint32_t  u32;
typedef uint32_t* p32;

#define MAXMEM (1<<29)
#define NEXT goto**(inst+((op=*ip++)>>28))
#define A (0b111&(op>>6))
#define B (0b111&(op>>3))
#define C (0b111&op)
#define D (0b111&(op>>25))
#define rA regs[A]
#define rB regs[B]
#define rC regs[C]
#define rD regs[D]

void run(int interactive, p32 z, u32 z_sz) {
    void*inst[] = {&&movnz,&&load,&&set,&&add,&&mul,&&div,&&nand,&&halt,&&alloc,&&free,&&out,&&in,&&jmp,&&mov,&&unknown,&&unknown};
    p32*mm=calloc(MAXMEM,sizeof(p32));  mm[0]=z;
    p32 sz=calloc(MAXMEM,4);            sz[0]=z_sz;
    u32 next=1; // next free lot. The next free is sz[next] etc, or next+1 if sz[next] is zero.
    u32 regs[8] = {0};
    p32 ip = z;
    u32 i=0,op;
    char*in="";

    NEXT;

    mov:  rD=0x1FFFFFF&op; NEXT;
    movnz:if(rC)rA=rB; NEXT;
    add:  rA=rB+rC; NEXT;
    mul:  rA=rB*rC; NEXT;
    div:  rA=rB/rC; NEXT;
    nand: rA=~(rB&rC); NEXT;
    load: rA=mm[rB][rC]; NEXT;
    set:  mm[rA][rB]=rC; NEXT;
    out:  fputc(rC,stdout); fflush(stdout); NEXT;
    in:   rC=*in?*in++:getchar(); NEXT;
    alloc:
            i=next; next=sz[next]?sz[next]:next+1;
            if(i>=MAXMEM){ printf("[trying to allocate too much memory, quitting]\n");exit(1); }
            mm[rB=i]=calloc(sz[i]=rC,4);
            NEXT;
    free: free(mm[rC]); sz[rC]=next; next=rC; NEXT;
    jmp:
            if(rB) {
                if(sz[rB]>sz[0]) { // only realloc if zero array doesn't have enough space
                    z=mm[0]=realloc(mm[0],4*sz[rB]);
                    sz[0]=sz[rB];
                }
                memcpy(mm[0],mm[rB],4*sz[rB]);
            }
            ip=z+rC; NEXT;
    unknown: printf("[unknown op %u]\n", op>>28); exit(1);
    halt: return;
}

int main(int argc, char const *argv[]) {
    if (argc<2) { printf("%s [program]\n", argv[0]); return 1; }

    int fd = open(argv[1], O_RDONLY);
    u32 sz = lseek(fd, 0, SEEK_END)/4;
    lseek(fd, 0, SEEK_SET);
    p32 zero = malloc(4*sz);
    int i=read(fd, zero, 4*sz);

    #if BYTE_ORDER == LITTLE_ENDIAN
    for(i=0;i<sz;++i) zero[i]=bswap32(zero[i]);
    #endif

    close(fd);

    run(1, zero, sz);

    return 0;
}
