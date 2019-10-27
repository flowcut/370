combin beq    0      2      quit   if r == 0 return 1 
       beq    1      2      quit   if r == n return 1
start  sw     0      7      BackD  save return address   
       sw     0      1      nNum   store n
       nor    0      2      3      r3 = ~r2
       lw     0      4      pos1   r4 = 1
       add    3      4      7      r7 = ~r2 + 1 = -r2 = -r // ！
       add    7      1      4      r4 = r1 + r3 = n - r    // ！
       add    7      4      3      r3 = r7 + r4 = n - 2r   // ！ 
       lw     0      5      psorng r5 = 2^31-1
       nor    3      5      6      r6 = (n - 2r) nor (2^31-1)
       beq    0      6      rlarge if (r6 == 0) -> n-2r<0 -> r>n/2
       add    2      2      2      r2 = new(2r) // rsmall starts
       add    3      7      6      r6 = n - 3r
       lw     0      3      two    r3 = 2
       beq    3      2      cn1
       add    3      4      1      r4 = n - r + 2 // r1 permanently be diagS
       add    3      6      6      r6 = n - 3r + 2
       nor    5      6      6      r6 = sign(r6) // r6 == 0 -> n-3r+2<0 -> n-r+2 < 2r -> diag/colm -> flag = 1
       lw     0      7      three  r7 = last = 3 
       lw     0      4      four   r4 = i = 4 // start from c(4,1)
       beq    0      6      dFull // negative flag
       beq    0      0      cFirst
rlarge add    3      4      6      r6 = 2n - 3r
       lw     0      3      two    r3 = 2
       add    2      3      1      r2 = r + 2 = new(n-r) + 2 // r1 permanently be diagS
       add    4      4      2      r2 = new(2r) = 2*(n-r)
       beq    3      2      cn1
       lw     0      7      neg2   r7 = -2
       add    7      6      6      r6 = 2n - 3r - 2
       nor    5      6      6      r6 = sign(r6) // r6 == 0 -> 2n-3r-2<0 -> 2n-2r < r+2 -> new(2r) < new(n-r+2) -> colm/diag -> flag = 0      
       lw     0      7      three  r7 = last = 3 
       lw     0      4      four   r4 = i = 4 // start from c(4,1)
       beq    0      6      cFirst
dFull  beq    1      4      dDiagE // r1 is diagS
       lw     0      5      two    r5 = j = 2
dFEvS  add    3      5      5      r5 = j += 2
       beq    5      4      dFEvE 
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      dFEvS
dFEvE  add    7      7      7      r7 = last *= 2
       sw     5      7      Null   a[j-2] = r7
       lw     0      5      two    r5 = j = 2
       add    4      0      7      r7 = last = i //r4 = real i - 1    
dFOdS  add    3      5      5      r5 = j += 2    
       beq    5      4      dFOdE
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6 
       beq    0      0      dFOdS
dFOdE  lw     5      6      Null   r6 = a[j-2]
       add    6      7      6      r6 = r6 + last
       sw     5      6      Null   a[j-2] = r6  
       lw     0      7      pos1   r7 = 1
       add    7      4      7      r7 = last = previous i + 1
       add    4      3      4      r4 = i += 2 // next i  
       beq    7      1      dDiagO skip the first half loop 
       beq    0      0      dFull
dDiagE lw     0      1      base
       add    0      1      5      // r5 = r1 = base 
dDLoop beq    2      4      dColmL // r2 is colmS, r1 becomes base
       add    3      1      1      r1 += 2 // update base 
       add    0      1      5      r5 = base
dDEvS  add    3      5      5      r5 += 2
       beq    5      4      dDEvE
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      dDEvS 
dDEvE  add    7      7      7      r7 = last *= 2
       sw     5      7      Null   a[j-2] = r7
       add    1      3      1      r1 += 2 // update base
       lw     1      7      Null   r7 = last = a[base-1]
       add    0      1      5      r5 = base 
dDOdS  add    3      5      5      r5 = j += 2    
       beq    5      4      dDOdE
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6 
       beq    0      0      dDOdS
dDOdE  lw     5      6      Null   r6 = a[j-2]
       add    6      7      6      r6 = r6 + last
       sw     5      6      Null   a[j-2] = r6  
       lw     1      7      Array  r7 = last = a[base] 
       add    4      3      4      r4 = i += 2 // next i
       beq    0      0      dDLoop
dDiagO lw     3      7      Array  r7 = last = a[base]
       sw     0      3      base   update base 
       beq    0      0      dDiagE
dColmL lw     2      6      Hell
       sw     2      6      Null   // restore last element for even line
dColm  add    3      1      1      r1 += 2 //update base
       add    0      1      5      r5 = base
       beq    1      2      return if (base == r) then ans got
dCS    add    3      5      5      r5 = j += 2
       beq    5      2      dCE 
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      dCS
dCE    lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       lw     1      7      Array  r7 = last = a[base]  
       beq    0      0      dColm
cFirst add    0      7      6      // solve bug of c(n,2) 
       lw     0      5      two    r5 = j = 2
cFull  beq    2      4      cColmL
       lw     0      5      two    r5 = j = 2
cFEvS  add    3      5      5      r5 = j += 2
       beq    5      4      cFEvE 
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      cFEvS
cFEvE  add    7      7      7      r7 = last *= 2
       sw     5      7      Null   a[j-2] = r7
       lw     0      5      two    r5 = j = 2
       add    4      0      7      r7 = last = i //r4 = real i - 1	
cFOdS  add    3      5      5      r5 = j += 2    
       beq    5      4      cFOdE
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6 
       beq    0      0      cFOdS
cFOdE  lw     5      6      Null   r6 = a[j-2]
       add    6      7      6      r6 = r6 + last
       sw     5      6      Null   a[j-2] = r6  
       lw     0      7      pos1   r7 = 1
       add    7      4      7      r7 = last = previous i + 1  
       add    4      3      4      r4 = i += 2 // next i
       beq    0      0      cFull
cColmL sw     5      6      Array  a[j] = r6 = a[j-2] // to make computation consistent
cColm  beq    1      4      cDiagL
       lw     0      5      two    r5 = j = 2
cCS    add    3      5      5      r5 = j += 2
       beq    5      2      cCE 
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      cCS
cCE    lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    4      0      7      r7 = last = i    
       lw     0      6      pos1   r6 = 1
       add    4      6      4      r4 = i += 1 // next i    
       beq    0      0      cColm
cDiagL lw     0      1      base   r1 = base //initially 0
cDiag  add    3      1      1      r1 += 2 //update base
       add    1      0      5      r5 = base
       beq    5      2      return if (base == r) then ans got
cDS    add    3      5      5      r5 = j += 2
       beq    5      2      cDE 
       lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       add    0      6      7      r7 = last = r6
       beq    0      0      cDS
cDE    lw     5      6      Null   r6 = a[j-2]
       add    6      7      7      r7 = r6 + last
       sw     5      7      Null   a[j-2] = r7
       lw     1      7      Array  r7 = last = a[base] 
       beq    0      0      cDiag
return lw     5      3      Null   ans = a[j-2] 
       lw     0      7      BackD
       beq    0      0      end 
cn1    lw     0      3      nNum   r3 = ans = r1 = n
       lw     0      7      BackD
       beq    0	0      end
quit   lw     0      3      pos1
end    jalr   7      4	   	
psorng .fill  2147483647           0b01111111111111111...	
oddchk .fill  -2                   0b111111...1110
base   .fill  0 
five   .fill  5
four   .fill  4 
three  .fill  3
two    .fill  2
pos1   .fill  1
neg1   .fill  -1
neg2   .fill  -2 
zero   .fill  0
diagS  .fill  0
colmS  .fill  0 
rNum2  .fill  0
nNum   .fill  0 
blFlag .fill  0
Caddr  .fill  combin
BackD  .fill  0 
Hell   .fill  0                    sorry for this 
       .fill  0
Null   .fill  0                    0 to complete calculation	
       .fill  0 
Array  .fill  0                    a slot that won't be filled'
