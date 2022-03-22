beqz R0 begin
pc = 0x50

begin: addi R10 R0 0xFFFF   # R10 = 0xFFFFFFFF
addi R12 R0 0xFF            # R12 = 0xFF
addi R15 R0 0x3             # R15 = 0x3
addi R2 R0 0xFFFF           # R2 = -1 (the i of the second for loop)
addi R3 R0 0x4 	            # R3 = 4
addi R4 R0 0x8 	            # R4 = 8, the S for the first loop   
addi R20 R0 0x7             # R20 = 7, the S-1 for the second loop
addi R1 R0 0x0 	            # R1 = 0, this is j
addi R7 R0 0x4000           # R7 = 0x4000
slli R7 R7                  # R7 << 1
slli R7 R7                  # R7 << 1 -> R7 = 0x00010000
addi R7 R7 0x203            # R7 = 0x00010203 (S[0] S[1] S[2] S[3])

addi R8 R0 0x4040           # R8 = 0x4040
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1
slli R8 R8                  # R8 << 1 -> R8 = 0x04040000
addi R8 R8 0x404            # R8 = 0x04040404

LOOP1: sgei R6 R4 0x48 	    # if (S >= 8 + 64) - last address is 71    
bnez R6 LOOP2               # finished first loop, branch to second loop
sw R7 R4 0x0                # S[i] = i
add R7 R7 R8                # S[i] -> S[i + 4]
addi R4 R4 0x1              # S = S + 1
beqz R0 LOOP1               # go to start of LOOP1

LOOP2: addi R2 R2 0x1       # i = i + 1
addi R20 R20 0x1            # S = S + 1 (word address)
seqi R5 R3 0x8              # R5=1 if R3=8 -> need to make R3=4
beqz R5 0x1                 # PC = PC + 2
addi R3 R0 0x4              # R3 = 4

lw R7 R20 0x0               # R7 = S[i] S[i + 1] S[i + 2] S[i + 3]
add R18 R0 R7               # R18 = S word, R18 is input reg for GETBYTE
addi R16 R0 0x0             # R16 = 0, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R9 R1 R27               # R9 = j + S[i], result of GETBYTE is in R27
lw R13 R3 0                 # R13 = key[i%16] key[(i+1)%16] key[(i+2)%16] key[(i+3)%16]
add R18 R0 R13              # R18 = key word, R18 is input reg for GETBYTE
addi R16 R0 0x0             # R16 = 0, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R14 R9 R27              # R14 = j + S[i] + key[i%16], result of GETBYTE is in R27
and R1 R14 R12              # j = mod(j + S[i] + key[mod(i,16)] , 256)
addi R22 R0 SWAP            # R22 = address of SWAP
jalr R22                    # jalr to SWAP

lw R7 R20 0x0               # R7 = S[i] S[i + 1] S[i + 2] S[i + 3]
addi R2 R2 0x1              # i = i + 1
add R18 R0 R7               # R18 = S word, R18 is input reg for GETBYTE
addi R16 R0 0x1             # R16 = 1, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R9 R1 R27               # R9 = j + S[i + 1], result of GETBYTE is in R27
add R18 R0 R13              # R18 = key word, R18 is input reg for GETBYTE
addi R16 R0 0x1             # R16 = 1, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R14 R9 R27              # R14 = j + S[i + 1] + key[(i+1)%16], result of GETBYTE is in R27
and R1 R14 R12              # j = mod(j + S[i + 1] + key[mod((i + 1),16)] , 256)
addi R22 R0 SWAP            # R22 = address of SWAP
jalr R22                    # jalr to SWAP

lw R7 R20 0x0               # R7 = S[i] S[i + 1] S[i + 2] S[i + 3]
addi R2 R2 0x1              # i = i + 1
add R18 R0 R7               # R18 = S word, R18 is input reg for GETBYTE
addi R16 R0 0x2             # R16 = 2, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R9 R1 R27               # R9 = j + S[i + 2], result of GETBYTE is in R27
add R18 R0 R13              # R18 = key word, R18 is input reg for GETBYTE
addi R16 R0 0x2             # R16 = 2, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R14 R9 R27              # R14 = j + S[i + 2] + key[(i + 2)%16], result of GETBYTE is in R27
and R1 R14 R12              # j = mod(j + S[i + 2] + key[mod((i + 2),16)] , 256)
addi R22 R0 SWAP            # R22 = address of SWAP
jalr R22                    # jalr to SWAP

lw R7 R20 0x0               # R7 = S[i] S[i + 1] S[i + 2] S[i + 3]
addi R2 R2 0x1              # i = i + 1
add R18 R0 R7               # R18 = S word, R18 is input reg for GETBYTE
addi R16 R0 0x3             # R16 = 3, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R9 R1 R27               # R9 = j + S[i + 3], result of GETBYTE is in R27
add R18 R0 R13              # R18 = key word, R18 is input reg for GETBYTE
addi R16 R0 0x3             # R16 = 3, R16 is input num for GETBYTE
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R14 R9 R27              # R14 = j + S[i + 3] + key[(i + 3)%16], result of GETBYTE is in R27
and R1 R14 R12              # j = mod(j + S[i + 3] + key[mod((i + 3),16)] , 256)
addi R22 R0 SWAP            # R22 = address of SWAP
jalr R22                    # jalr to SWAP

addi R3 R3 0x1              # R3 = R3 + 1
sgei R25 R2 0xFF            # set R25 to 1 if i >= 255
beqz R25 LOOP2              # go to start of LOOP2
halt                        # halt - finish program

SWAP: add R28 R0 R31        # save the return address
add R23 R2 R0               # R23 = i
and R16 R23 R15             # R16 = 2 LSB digits of i
add R8 R0 R16               # R8 = R16, save R16 for later
srli R17 R23                # R17 = R23 >> 1 (i>>1)
srli R17 R17                # R17 >> (i>>1)
addi R5 R17 0x8             # R5 is the line address of S[i]
add R19 R0 R5               # R19 = R5, save R5 for later
lw R18 R5 0x0               # R18 = S[i] S[i+1] S[i+2] S[i+3]
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R4 R0 R27               # temp = R4 = S[i]

add R23 R1 R0               # R23 = j
and R16 R23 R15             # R16 = 2 LSB of j
add R21 R0 R16              # R21 = R16, save R16 for later
srli R17 R23                # R17 = R23 >> 1 (j>>1)
srli R17 R17                # R17 >> (j>>1)
addi R5 R17 0x8             # R5 is the line address of S[j]
lw R18 R5 0x0               # R18 = S[j] S[j+1] S[j+2] S[j+3]
addi R22 R0 GETBYTE         # R22 = address of GETBYTE
jalr R22                    # jalr to GETBYTE
add R6 R0 R27               # R6 = S[j]

lw R18 R19 0x0              # R18 = S[i] S[i+1] S[i+2] S[i+3]
add R16 R0 R8               # use the saved R16, R8, the inner location of S[i]
add R11 R0 R6               # R11 = S[j], R11 is input byte of PUTBYTE
addi R22 R0 PUTBYTE         # R22 = address of PUTBYTE
jalr R22                    # jalr to PUTBYTE
sw R18 R19 0x0              # store the new R18

lw R18 R5 0x0               # R18 = S[j] S[j+1] S[j+2] S[j+3]
add R16 R0 R21              # use the saved R16, R21, the inner location of S[j]
add R11 R0 R4               # R11 = temp, R11 is input byte of PUTBYTE
addi R22 R0 PUTBYTE         # R22 = address of PUTBYTE
jalr R22                    # jalr to PUTBYTE
sw R18 R5 0x0               # store the new R18
jr R28                      # go back to where SWAP was called

PUTBYTE: add R29 R0 R31     # save the return address
addi R22 R0 GETBMASK        # R22 = address of GETBMASK
jalr R22                    # jalr to GETBMASK
xor R26 R26 R10             # reverse bitmask, 1->0, 0->1, R26 is result of GETBMASK
and R18 R18 R26             # empty a byte in R18, ex: R18 = [ S[i] 0 S[i+2] S[i+3] ]
add R27 R0 R11              # R27 = S[j], R27 is input reg of MOVLEFT
addi R22 R0 MOVLEFT         # R22 = address of MOVLEFT
jalr R22                    # jalr to MOVLEFT
or R18 R27 R18              # insert byte
jr R29                      # go back to where PUTBYTE was called

GETBYTE: add R29 R0 R31     # save the return address
addi R22 R0 GETBMASK        # R22 = address of GETBMASK
jalr R22                    # jalr to GETBMASK
and R27 R26 R18             # mask the wanted byte, make other bytes zero
addi R22 R0 MOVRIGHT        # R22 = address of MOVRIGHT
jalr R22                    # jalr to MOVRIGHT
jr R29                      # go back to where GETBYTE was called

GETBMASK: addi R26 R0 0xFF  # R26 = 3rd byte bitmask
seqi R25 R16 0x3            # R25 = 1 if (R16 == 3), else 0
beqz R25 0x1                # if (R25 == 0) we don't want byte 3, skip next line
jr R31                      # we want byte 3, got it, now can return
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
seqi R25 R16 0x2            # R25 = 1 if (R16 == 2), else 0
beqz R25 0x1                # if (R25 == 0) we don't want byte 2, skip next line
jr R31                      # we want byte 2, got it, now can return
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1    
seqi R25 R16 0x1            # R25 = 1 if (R16 == 1), else 0
beqz R25 0x1                # if (R25 == 0) we don't want byte 1, skip next line
jr R31                      # we want byte 1, got it, now can return
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1
slli R26 R26                # R26 = R26 << 1     
jr R31                      # we want byte 0, got it, now can return

MOVRIGHT: sgti R25 R16 0x0  # R25 = 1 if (R16 > 0), else 0
bnez R25 0x8                # if (R25 != 0) skip next 8 lines
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1 
sgti R25 R16 0x1            # R25 = 1 if (R16 > 1), else 0
bnez R25 0x8                # if (R25 != 0) skip next 8 lines
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1 
sgti R25 R16 0x2            # R25 = 1 if (R16 > 2), else 0
bnez R25 0x8                # if (R25 != 0) skip next 8 lines
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1
srli R27 R27                # R27 = R27 >> 1 
jr R31                      # go back to where MOVRIGHT was called

MOVLEFT: seqi R25 R16 0x3   # R25 = 1 if (R16 == 3), else 0
beqz R25 0x1                # if R25 == 0, skip a line
jr R31                      # we want byte 3, got it, now can return
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
seqi R25 R16 0x2            # R25 = 1 if (R16 == 2), else 0
beqz R25 0x1                # if R25 == 0, skip a line
jr R31                      # we want byte 2, got it, now can return
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
seqi R25 R16 0x1            # R25 = 1 if (R16 == 1), else 0
beqz R25 0x1                # if R25 == 0, skip a line
jr R31                      # we want byte 1, got it, now can return
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
slli R27 R27                # R27 = R27 << 1 
jr R31                      # we want byte 0, got it, now can return
