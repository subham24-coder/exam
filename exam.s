 AREA     appcode, CODE, READONLY
     EXPORT __main
	 EXPORT __COSINE
	 EXPORT __SINE
	 ENTRY 
__SINE  FUNCTION		         
     loop3   VLDR.F32   s7, =360 ;theta tken from 360
             CMP s7, #1	   ;
        VLDR.F32   s2, = 1 ;initial value taken 1
		VLDR.F32   s1, = 1 ; initial value taken 1 
		VLDR.F32   s6, = 2 ;initial value taken 1
				
	    MOV R5 , #1111 ; R5 stored the value 1111 so that the last term is X^(110)/110 (for infinity loop below I have written what should be modified)
loop   CMP R5 , #0x01 ;
		VMUL.F32 s2 , s2, s7 ;s2=s2*s7
	    VDIV.F32  s4 , s2, s1 ;s4=s2/s1
	    VADD.f32 s11, s11, s4 ;s11=s11+s4
	    VADD.f32 s1 , s1 , s6 ;  s1=s1+s6
		    MOV r6,s2 ; load s2 into r6
           MOV r4,s1
           MOV r7,#1 ; if n = 0,
;loop1 is made for x^n
loop1   CMP r4, #0

            MULGT r7, r7, r6

          SUBGT r4, r4, #1 ; de

         BGT loop1 ; 
   
	   	     MOV r9,s1 ; LOAD S1 IN R9

        MOV r2,#1 ; 
;loop2 is made for n factorial purpose which is at the denominator
loop2   CMP r9, #0

        MULGT r2, r9, r2

        SUBGT r9, r9, #1 ; 

        BGT loop2 ; 
	    ;VDIV.f32  s4 , s2, r1 ;s4=s2/s1
	    VSUB.f32 s11, s11, s4 ;s11=s11-s4
		VADD.f32 s1 , s1 , s6 ;s1=s1+s6
		SUB R5 ,R5 , #01 ;
	   B loop ;
       VSUB.f32 s7, s7, s2 ;s7=s7-s2;decrese s7(theta) by 1
       B loop3 ;go back to the main loop3
      
          	
     ENDFUNC
 
 :HERE THE SINE FUNCTION IS COMPLETED
 
 __COSINE  FUNCTION	
 loopl   VLDR.F32   s10, =360 ;theta tken from 360
             CMP s10, #1		 
       VLDR.F32   s7, = 15 ;here store the value of x(I have taken 15) 
        VLDR.F32   s2, = 1 ;initial value taken 1
		VLDR.F32   s1, = 1 ; initial value taken 1 
		VLDR.F32   s6, = 2 ;initial value taken 1
			VLDR.F32   s5, = 0;	;
	    MOV R5 , #1111; R5 stored the value 1111 so that the last term is X^(110)/110 (for infinity loop below I have written what should be modified)
loopk   CMP R5 , #0x01 ;
		VMUL.F32 s2 , s2, s7 ;s2=s2*s7
	    VDIV.F32  s4 , s2, s1 ;s4=s2/s1
	    VADD.f32 s8, s8, s5 ;s8=s8+s5
	    VADD.f32 s1 , s5 , s6 ;  s1=s5+s6
		    MOV r6,s2 ; load s2 into r6
           MOV r4,s1
           MOV r7,#1 ; if n = 0,
;loop4 is made for x^n
loop4   CMP r4, #0

            MULGT r7, r7, r6

            SUBGT r4, r4, #1 ; de

         BGT loop4 ;
       ; VMUL.f32 s2 , s2 ,s7  ;s2=s2*s7
	   	     MOV r9,s1 ; 

        MOV r2,#1 ; 
;loop5 is made for n factorial purpose which is at the denominator
loop5   CMP r9, #0

        MULGT r2, r9, r2

        SUBGT r9, r9, #1 ; de

        BGT loop2 ; do another mul if counter!= 0
	    ;VDIV.f32  s4 , s2, r1 ;s4=s2/s1
	    VSUB.f32 s8, s8, s4 ;s8=s8-s4
		VADD.f32 s1 , s1 , s6 ;s1=s1+s6
		SUB R5 ,R5 , #01 ;decreasing r5 value by 1(if I do not write this line It would run infinity times as required)
	  
	  B loopk ;
       VSUB.f32 s10, s10, s2 ;s7=s7-s2
       B loopl   	
     ENDFUNC
	 
	 :HERE THE COSINE FUNCTION IS COMPLETED
		 
		 
		 
		 
		 
 _main  FUNCTION	
	 MOV R7 , #0010
	 VLDR.F32   s9, = 1
	  
       VLDR.F32   s13, = 3 ;This is the initial radius
	back       CMP R7 , #0x01 

           VMUL.F32 s12 , s13, s11 ;This is Rcos(theta)
	       VMUL.F32 s14 , s12, s8;This is Rsin(theta)
		  VLDR.F32   s5, = 2
	       VDIV.f32  s9 , s9, s5 ;   
           

;Making the spirality


	     VADD.f32 s13 , s13 , s9 ;adding the value of radius by 0.5 unit
         SUB R7 ,R7 , #01:making the spiral in a step for 10 times
            bne back
 
                          
stop    B stop                              ; stop program

     ENDFUNC
	 END
 
