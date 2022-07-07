//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief: This is a small ALU which is used as a base design for testing various test bench frameworks
//        The ALU has input 8 bit data which computes the results as 16 bit outputs
//        Assuming single clock outputs for all instructions
// Ref: Book: UVM Premier Ray Salemi ( Tiny ALU: Page nb: 10) : https://github.com/raysalemi/uvmprimer
//-----------------------------------------------------------------------------------------------------


module tiny_alu

      parameter   ( INPUT_DATA_BITS     =     8   ,
                    OPCODE_BITS         =     3   );

            (

                  input   wire                                        clk_i       ,
                  input   wire                                        reset_n_i   , // Active low reset maynot be relevant for FPGAs, but maybe for ASICs

                  input   wire        [ INPUT_DATA_BITS-1: 0 ]        a_i         ,
                  input   wire        [ INPUT_DATA_BITS-1: 0 ]        b_i         ,

                  input   wire        [ OPCODE_BITS-1: 0 ]            opcode_i    ,
                  input   wire                                        start_i     ,

                  output  wire        [ INPUT_DATA_BITS*2-1: 0 ]      result_o    ,
                  output  wire                                        done_o

              );




  wire  [ INPUT_DATA_BITS*2-1: 0 ] result       ;

  localparam [ OPCODE_BITS -1: 0 ] NOP_OP     = { OPCODE_BITS { 'd0 } } ;
  localparam [ OPCODE_BITS -1: 0 ] ADD_OP     = { OPCODE_BITS { 'd1 } } ;
  localparam [ OPCODE_BITS -1: 0 ] AND_OP     = { OPCODE_BITS { 'd2 } } ;
  localparam [ OPCODE_BITS -1: 0 ] XOR_OP     = { OPCODE_BITS { 'd3 } } ;
  localparam [ OPCODE_BITS -1: 0 ] MUL_OP     = { OPCODE_BITS { 'd4 } } ;

  //-----------------------------------------------------------------------------------------------------
  // Outputs Assignment
  //-----------------------------------------------------------------------------------------------------

  always @( posedge clk_i, posedge reset_i ) begin  : output_assignments
      if ( reset_n_i == 1'b0 )  begin
            result_o  <= 'b0       ;
            done_o    <= 'b0       ;
      end else  begin
            result_o  <= result   ;
            done_o    <= done     ;
      end
  end : output_assignments

  //-----------------------------------------------------------------------------------------------------
  // Combinatorial ALU computations
  //-----------------------------------------------------------------------------------------------------

  always @ ( * ) begin : alu_computations

      done    =   'b0 ;
      result  =   'd0 ;

      if ( start_i )  begin

          case ( opcode_i )

              NOP_OP  :   done    =   'b1       ;

              ADD_OP  :   result  =   a_i + b_i ;
                          done    =   'b1       ;

              AND_OP  :   result  =   a_i & b_i ;
                          done    =   'b1       ;

              XOR_OP  :   result  =   a_i ^ b_i ;
                          done    =   'b1       ;

              MUL_OP  :   result  =   a_i * b_i ;
                          done    =   'b1       ;

              default :   done    =   'b0       ;

          endcase

      end

  end : alu_computations

  //-----------------------------------------------------------------------------------------------------

endmodule // tiny_alu

//-----------------------------------------------------------------------------------------------------
