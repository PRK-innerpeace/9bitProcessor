movi r0,0
movi r1,2
load r4,r0
movi r5,1
add r0,r5
load r2,r0

mov r3,r2


mmsw r2,r4
mlsw r3,r4
mov r6,r2
bxor r2,r6
add r2,r6
mov r5,r2
write r2,r1
mov r4,r3

bwxx r2,r4
lshf r2
mov r7,r2
add r3,r7
mov r2,r6

bwxy r2,r4
lsht r2
mov r7,r2
add r3,r7
mov r2,r6

bwxz r2,r4
lsh r2
mov r7,r2
add r3,r7
mov r6,r3


bxor r2,r5
add r2,r6
mov r7,r2
bxor r2,r7
add r2,r6

movi r5,1
add r1,r5
write r2,r1

add r1,r5
add r0,r5
movi r7,2
mov r3,r0
sub r3,r7
breq r3,1
jump 1


halt
