# DLX Processor  
  
A full design of a DLX processor, including all Datapath elements such as ALU, GPR, MMU, etc. and Control elements such as MAC, Control State Machine.
The program used for this matter is the XILINX ISE Design Suite.  
  
# Key-Scheduling-Algorithm
  
An assembly implementation of the Key Scheduling Algorithm (KSA). This algorithm is known as the first step in the RC4 stream cipher algorithm. The goal of KSA is generating a pseudo-random permutation of a 256-byte array (S) based on a 16-byte key (K).  
This code was tested on the DLX processor, running on FPGA.  
  
In KSA, the first step is initializing a 256-byte vector (S) with the identity permutation, meaning the values in the array are equal to their index.  
The next step is shuffling the array in a pseudo-random manner, making it a permutation array.  
  
Hereby presented the C implementation of the algorithm. Though it seems quite short, the Assembly implementation is a little bit longer...  

int i;  
for (i = 0; i < 256; i++){  
    S[i] = i;  
}  
  
int j = 0;  
for (i = 0; i < 256; i++){  
    j = mod(j + S[i] + key[mod(i, 16)], 256);  
    swap(S[i], S[j]);  
}  
