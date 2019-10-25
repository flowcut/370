combin beq    0      2      quit   if r == 0 return 1 
       beq    1      2      quit   if r == n return 1
start  sw     0      7      backD  save return address   
       nor    0      2      3      r3 = ~r2
       lw     0      4      pos1   r4 = 1
       add    3      4      3      r3 = ~r2 + 1 = -r2 = -r
       add    3      1      4      r4 = r1 + r3 = n - r
       add    3      4      3      r3 = r3 + r4 = n - 2r
       lw     0      5      psorng r5 = 2^31-1
       nor    3      5      3      r3 = (n - 2r) nor (2^31-1)
       beq    0      3      rlarge if (r3 == 0) -> n-2r<0 -> r>n/2
       beq    0	0      rsmall
rlarge add    0      4      2      r2 = r := n-r 
rsmall lw     0      4      pos1   r4 = 0 -> i = 0
       beq    4      2      cn1
       lw     0      4      three  r4 = i = 3 // start from c(4,1)
       lw     0      3      pos1   r3 = 1
       add    4      0      7      r7 = last = i	
       add    4      3      4      r4 = i += 1
loopSt lw     0      5      pos1   r5 = j = 1 
ifeven add    3      5      5      r5 = j += 1
       add    5      5      6      r6 = 2*j
       beq    6      4      edeven 
       lw     5      6      Null   r6 = a[j-1]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-1] = r7
       add    0      6      7      r7 = last = r6
       beq    1      4      check1
       beq    0      0      ifeven 
check1 beq    2      5      return
       beq    0      0      ifeven
edeven add    7      7      7      r7 = last *= 2
       sw     5      7      Null   a[j-1] = r7
       beq    1      4      check2
       beq    0      0      next
check2 beq    2      5      return 
next   lw     0      5      pos1   r5 = j = 1 
       lw     0      6      neg1   r6 = -1
       add    1      6      1      r1 = n -= 1 // n temporarily-1 
       add    4      0      7      r7 = last = i //r4 = real i - 1	
ifodd  add    3      5      5      r5 = j += 1
       add    5      5      6      r6 = 2*j	    
       beq    6      4      edodd
       lw     5      6      Null   r6 = a[j-1]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-1] = r7
       add    0      6      7      r7 = last = r6 
       beq    1      4      check3
       beq    0      0      ifodd 
check3 beq    2      5      return
       beq    0      0      ifodd
edodd  lw     5      6      Null   r6 = a[j-1]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-1] = r7  
       beq    1      4      check4
       beq    0      0      loopEd
check4 beq    2      5      return
loopEd add    4      3      4      r4 = i += 1 // real i
       add    0      4      7      r7 = last = i
       add    4      3      4      r4 = i += 1 // next i
       add    1      3      1      restore n
       beq    0      0      loopSt  
return lw     5      3      Null  ans = a[j-1] 
       lw     0      7      backD
       beq    0      0      end 
cn1    add    0      1      3      r3 = ans = r1 = n
       beq    0	0      end	
quit   lw     0      3      pos1
end    jalr   7      4	   	
psorng .fill  2147483647           0b01111111111111111...	
oddchk .fill  -2                   0b111111...1110
four   .fill  4 
three  .fill  3
zero   .fill  0
pos1   .fill  1
neg1   .fill  -1
Caddr  .fill  combin
backD  .fill  0 
Null   .fill  0                    0 to complete calculation	
Array  .fill  0                    a slot that won't be filled
