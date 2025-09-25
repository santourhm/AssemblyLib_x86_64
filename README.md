



General Purpose Registers

		# STACK POINTER REGISTER (RSP)
		
			rsp used to point on the top of the current stack 

		# BASE POINTER REGISTER (RBP)

			used during function calls points on the top of stack frame
		
		# INSTRUCTION POINTER REGISTER (RIP)

			point to the next instrcution to be executed

		# r8 to r15
		
			general registers used to do operations on data (eg. data transfer , arithmitic operations ...)

		
		# FLAG REGISTERS (rFlags)

			The flag register, rFlags, is used for status and CPU control information. The rFlag
			register is updated by the CPU after each instruction and not directly accessible by
			programs (CF = Carry, PF = Parity =1 even ,0 odd ,AF = Adjust, ZF = ZERO , Sign = SF, 
			Direction = DF , OF = Overflow )

		

little-endian
               # means that the the LSB is stored in the lowest memory address. and the MSB stored in the highest memory location 



 
Memory Layout :
			|	stack		|
			|	.		    |
			|	.		    |
			|	.		    |   
			|	heap 		|
			|	bss un data |
			|	data		|
			|	text(code)	|
			|	reserved	|


	The reserved section is not available to user programs


Program Format : 

	An asselbly program is written in three fondamentals sections , .data section where we declare intialized data and .bss section where we conserve uninitialized data and .txt 
	section for program code

	comments are declared by ; 

	hex precided by √'0x' , octal ends by 'q'
 
	defining constants : <name>  equ <value>

	data section : 
			<variable_name>   <data_type>    <initial_value>

	this section is for intialized variables, possible type 
                       	db =  8-bit variable
			dw =  16-bit variable
			dd = 2dw
			dq = 2dd
			ddq = 2dq
			dt = 128-bit variable float

	Bvar      db         10   ;   byte variable
	Cvar      db         "H"  ;   char represented in a byte
	str       db     "Hello, World√" ; string
	arr       db      10,20,30
	      
						

       BSS section :
			
		<variableName> <resType>  <count>
		
		data type defined bye <resType>  and <cout> is the number of these variables 
	
	
		resb	8-bit variable(s)
		resw	16-bit variable(s)
		resd	32-bit variable(s)
		resq	64-bit variable(s)
		resdq	128-bit variable(s)

	Text Section :

		The code is placed in the "section .text" section 

	for a simple program we can start it bye : 
		
		section .text
		global _start
		_start		

Instruction Set Overview : 
	
	The instructions are presented in the following order:
		
		Data Movement
		Conversion Instructions
		Arithmetic Instructions
		Logical Instructions
		Control Instructions

	Data Movement : 

		mov	<dest>, <src>
		mov	rax   , dword [myvar]
		mov	ax, 42
		mov	cl, byte [bvar]
		mov	dword [dVar], eax
		move	qword [qVar], rdx
	Data Conversion :
	
    	convert unsigned values from smaller types to larger ones
			movzx  <dest>, <src>

    Logical Instructions

        and <dst>, <src>    b0101 and b0011 = b0001
        or  <dst>, <src>    b0101 or  b0011 = b0111
        xor <dst>, <src>    b0101 xor b0011 = b0110
        not <op>            <op> <- not(op)
    
    Shift Operations :

        shifiting left is devising by power of 2, shifting right multipling by power 2

            unsigned shit : 

                    shl <dst>, <cl/imm>   
                    shr <dst>, <cl/imm> 
    
            signed shit (arithmitic shift)
                    this shift preserve the sign of the integer
                    sal <dst>, <cl/imm>
                    sar <dst>, <cl/imm>

    Rotate Operations : 

            The rotate operation shifts bits within an operand, either left or right, with the bit that is
            shifted outside the operand is rotated around and placed at the other end.

                    rol <dst>, <cl/imm>
                    ror <dst>, <cl/imm>

   Control Instructions :


            Labels : 

                        label_name :
                it's an address where the program jumps to when are used a control instruction

            Unconditional Control Instructions : 

                        jmp <label> 

                as soon as we hit  jmp <label> we jump to label's address without any condition

            Conditional Control Instructions : 

                        jcc <label>

                cc in { e,ne,l,le,g,ge,b,be,a,ae}

            we do a compare instrcution for exmaple : cmp <op1>, <op2>

            condition codes changes with respect to the compare function and then jcc jumps or not to label based on rFlag register (cc)

            NB : for code condtion starting with b =  < ,a = > are for unsigned comparision

            Iteration : 

                loop <label>

            decrement the number of the rcx register and cmp to 0 and jums to the specifed label if rcx != 0


Addressing Modes : 


            the basic addressing modes are :
                   - Register       mov   rax, rcx
                   - Immediate      mov   rax, 6   
                   - Memory         mov   rax, qword [var]


            accessing memory is done only with '[]' name of a var variable is the address of it and its value is [var]
             
            values are byte addressable , each byte has its own address for exmplae the list :

                        list        db          100,101,102

                    |   102     |   <- list + 8 = list + 2*4
                    |   101     |   <- list + 4
                    |   101     |   <- list

            accessing  101 is done by :

                    mov     eax, dword [list + 4]
                    mov     rsi, 4
                    mov     rbx, list
                    mov     eax, dword [rbx + rsi]
                    mov     eax, dword [rbx + 4  ]

            in general format of memory addressing is as follow : 

                    [ baseAddr + (indexReg * scaleValue ) + displacement ]

            for example if we want to access the 2nd elemment of the list using this method

                    mov     rsi, 1          ; index of the element list[1] for 101
                    mov     eax, dword [list + rsi*4]       ; 4 is the scaleValue which is the size of content element which is dword = 4 bytes




Process Stack :

            
            A push operation puts things onto the stack, and a pop operation takes things off the
            stack. The format for these commands is :

                    push    <operand64>
                    pop     <operand64>

            The operand can be a register or memory, but an immediate is not allowed




                    
Functions : 

            A function must be written before it can be used. Functions are located in the code
            segment. The general format is:

                global <procName>
                <procName>:
                ; function body
                ret            

            standard calling convention  (System V AMD64 ABI for C programming language):
                call <fnName>
                ...
                <fnName>
                ...
                ret

                call : baranching to the function name and saving the next executed function after the return from that routine into the stack , push rip
                ret  : pop rip changes to the calling routine function to continue execution
        
            while calling there's the prologue of a function that saves the current state (stack, register,..) and the epilogue helps restores the state after thr return
        
           

            passing Params :

                    a mix of the stack and register is used to pass parameters to a function :
                            1st-arg ->  rdi | edi | di  | dil
                            2nd-arg ->  rsi | esi | si  | sil
                            3th-arg ->  rdx | edx | dx  | dl
                            4th-arg ->  rcx | ecx | cx  | cl
                            5th-arg ->  r8  | r8d | r8w | r8b
                            6th-arg ->  r9  | r9d | r9w | r9b 

                    any additional argument is passed on the stack , the calling routine pushes these arguments and the called routines
                    is the responsable of cleaning the stack by substruction the rsp register by nb_of_arguments*8 t adjust the rsp
                    to the correct  position ignoring the arguments and creating a new context, the A register is where we return the 
                    value if needed based in the size of the returned valu, rbx, r12 ... r15 is a call saved register we done modify them
                    when we call a function 


            Call Frame :

                    stack layout while a call routine : 



                                            |           ...             |
                                            |           8-th arg        |
                                            |           7-th arg        |
                                            |           rip             | <- returna address pushed by call instruction
                                            |           rbp             | <- save caller's base pointer to remeber its contex
                                            |           rbx             | <-|
                                            |           ...             | <-| SAVE ALL SAVE CALL REGISTER HERE LIKE RBX ...
                                            |           r12             | <- rsp , current stack pointer after performing prologue instrcutions                   
                                            |       ... 128 bytes       | <- reserved for local variable 
                                                   
                                                                                    
                    a basic prologe code : 
                                            push    rbp
                                            mov     rbp, rsp
                                            push    rbx     ; save call saved registers
                                            sub     rsp, 16 
                                            
                    a epilogue code     :
                                            mov rax,    qword [return_value]
                                            mov rsp,    rbp  ; deallocate used memory for local values
                                            pop rbx          ; restore asved registers
                                            pop rbp          ; 
                                            ret
                                            
                    caller's responsibility to clean any pushed arguments .


