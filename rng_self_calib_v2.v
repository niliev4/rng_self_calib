

module  rng_self_calib_v2 (

        // inputs

        input  clk,
        input   resetb,

        input  start,
     
        input  bit_from_inv_pair,
         

        output wire [3:0] pres_state_out,

        output [3:0] nconf1,
        output [3:0] nconf0,
        output [3:0] pconf1,
        output [3:0] pconf0,
        output [3:0] clkconf1,
        output [3:0] clkconf0


);


parameter idle=5'd0,nconf1_eq_min=5'd1,nconf1_dec=5'd2,nconf0_eq_max=5'd3,nconf0_inc=5'd4;
parameter pconf1_eq_min=5'd5,pconf1_dec=5'd6,pconf0_eq_max=5'd7,pconf0_inc=5'd8;
parameter clkconf1_eq_min=5'd9,clkconf1_dec=5'd10,clkconf0_eq_max=5'd11,clkconf0_inc=5'd12;
parameter start_bit_a_0=5'd13, start_bit_b_0=5'd14, start_bit_c_0=5'd15, start_bit_d_0=5'd16;

 


// local vars


reg [4:0] pres_state;


 wire [4:0] next_state;
 wire fsm_run;

// temp for datapath
 wire bit_a;
 wire bit_b;
 wire bit_c;
 wire bit_d;

 

parameter SIZE = 8;

// reg array

// index diff_array is 0 to 7
reg [1:0] dff_array [0:7];




generate 
  genvar gi;
  
   for (gi=0;gi<SIZE;gi=gi+1) begin : genreg
      always @(posedge clk or negedge resetb )
      begin
         if ( ~resetb  )
           dff_array[gi] <= 0;
         else
           dff_array[gi] <= next_state[1:0];
      end
    end


endgenerate

assign nconf1[0] = dff_array[0] |
                   dff_array[1] |
dff_array[2] |
dff_array[3] |
dff_array[4] |
dff_array[5] |
dff_array[6] |
dff_array[7];




//////////////// MAIN FSM  and DATAPATH //////////////////////////////////


///  

// FSM state reg
always @(posedge clk or negedge resetb )
begin
  if ( ~resetb  )
     pres_state <= idle;
  else
    pres_state <= next_state;

end


fsm_comb_rng  fsm_comb_rng (
          //  inputs
               .pres_state  ( pres_state),

               .bit_a   ( bit_a ),
               .bit_b   ( bit_b ),
               .bit_c   ( bit_c ),
               .bit_d   ( bit_d ),
               .nconf1 (  nconf1[3:0] ),
               .nconf0 (  nconf0[3:0] ),
               .pconf1 (  pconf1[3:0] ),
               .pconf0 (  pconf0[3:0] ),
               .clkconf1 ( clkconf1[3:0]),
               .clkconf0 ( clkconf0[3:0]),


             
          // outputs
               .next_state ( next_state )
               
           );


assign pres_state_out = pres_state;



////////////////////  data path follows below 


















endmodule

            
