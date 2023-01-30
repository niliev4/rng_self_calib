
`include "fsm_defines_rng.v"

module fsm_comb_rng (

        //  inputs
           pres_state,
          
           bit_a,
           bit_b,
           bit_c,
           bit_d,

           nconf1,
           nconf0,
           pconf1,
           pconf0,
           clkconf1,
           clkconf0,

        // outputs
           next_state
      
   );

   input [4:0]  pres_state;


    input   bit_a;
    input   bit_b;
    input   bit_c;
    input   bit_d;
    input [3:0] nconf1;
    input [3:0] nconf0;
    input [3:0] pconf1;
    input [3:0] pconf0;
    input [3:0] clkconf1;
    input [3:0] clkconf0;


   output [4:0] next_state;
 





parameter idle=5'd0,nconf1_eq_min=5'd1,nconf1_dec=5'd2,nconf0_eq_max=5'd3,nconf0_inc=5'd4;
parameter pconf1_eq_min=5'd5,pconf1_dec=5'd6,pconf0_eq_max=5'd7,pconf0_inc=5'd8;
parameter clkconf1_eq_min=5'd9,clkconf1_dec=5'd10,clkconf0_eq_max=5'd11,clkconf0_inc=5'd12;
parameter start_bit_a_0=5'd13, start_bit_b_0=5'd14, start_bit_c_0=5'd15, start_bit_d_0=5'd16;

 
 

reg [4:0] next_state;





always @( *  )
begin
  case ( pres_state)
 
 
    // Initial , Idle state 
    idle : 
     begin
       if ( bit_a == 1'b1  )
         begin
             next_state = nconf1_eq_min;
         end
        else
        begin
             next_state = start_bit_a_0;
        end
     end

    
    nconf1_eq_min : 
      begin
         if ( nconf1 == `NCONF1_MIN )
            next_state = nconf0_eq_max;
          else
             next_state = nconf1_dec;
      end

   nconf0_eq_max : 
      begin
         if ( nconf0 == `NCONF0_MAX )
            next_state = pconf1_eq_min;
         else
              next_state = nconf0_inc;
      end

   nconf1_dec : 
      begin
         if ( bit_b == 1'b1 )
             next_state = nconf1_eq_min; 
         else
              next_state = start_bit_b_0;
      end


   nconf0_inc : 
      begin
         if ( bit_c == 1'b1 )
           next_state = nconf1_eq_min ;
         else
              next_state = start_bit_c_0;
      end


    pconf1_eq_min : 
      begin
         if ( pconf1 == `PCONF1_MIN )
            next_state = pconf0_eq_max;
          else
             next_state = pconf1_dec;
      end

   pconf0_eq_max : 
      begin
         if ( pconf0 == `PCONF0_MAX )
            next_state = clkconf1_eq_min;
         else
              next_state = pconf0_inc;
      end

   pconf1_dec : 
      begin
         if ( bit_d == 1'b1 )
             next_state = pconf1_eq_min; 
         else
              next_state = start_bit_d_0;
      end


   pconf0_inc : 
      begin
         if ( bit_a == 1'b1 )
           next_state = pconf1_eq_min ;
         else
              next_state = start_bit_a_0;
      end


    clkconf1_eq_min : 
      begin
         if ( clkconf1 == `CLKCONF1_MIN )
            next_state = clkconf0_eq_max;
          else
             next_state = clkconf1_dec;
      end

   clkconf0_eq_max : 
      begin
         if ( clkconf0 == `CLKCONF0_MAX )
            next_state = nconf1_eq_min;
         else
              next_state = clkconf0_inc;
      end

   clkconf1_dec : 
      begin
         if ( bit_b == 1'b1 )
             next_state = clkconf1_eq_min; 
         else
              next_state = start_bit_b_0;
      end


   clkconf0_inc : 
      begin
         if ( bit_c == 1'b1 )
           next_state = clkconf1_eq_min ;
         else
              next_state = start_bit_c_0;
      end


  
     default :
         begin
             next_state = idle;
            
         end
 endcase

end





endmodule // fsm_comb
