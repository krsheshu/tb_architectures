//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief: This is a small ALU which is used as a base design for testing various test bench frameworks
//        The ALU has input 8 bit data which computes the results as 16 bit outputs
//        Assuming single clock outputs for all instructions
// Ref: Book: UVM Premier Ray Salemi ( Tiny ALU: Page nb: 10) : https://github.com/raysalemi/uvmprimer
//-----------------------------------------------------------------------------------------------------


module tiny_alu

  //-------------------------------------------------------------
  //  Imports
  //-------------------------------------------------------------

  import tiny_alu_pkg::OPCODE_BITS  ;
  import tiny_alu_pkg::NOP_OP       ;
  import tiny_alu_pkg::ADD_OP       ;
  import tiny_alu_pkg::AND_OP       ;
  import tiny_alu_pkg::XOR_OP       ;
  import tiny_alu_pkg::MUL_OP       ;


      parameter   ( INPUT_DATA_BITS     =     8   );

  //-------------------------------------------------------------
  //  Ports
  //-------------------------------------------------------------

   (

      tiny_alu_intf         intf

   );



  logic  [ INPUT_DATA_BITS*2-1: 0 ] result        ;
  logic                             done          ;

  //-----------------------------------------------------------------------------------------------------
  // Outputs Assignment
  //-----------------------------------------------------------------------------------------------------

  always_ff @( posedge intf.clk_i, posedge intf.reset_n_i ) begin  : output_assignments
      if ( intf.reset_n_i == 1'b0 )  begin
            intf.result_o  <= 'b0       ;
            intf.done_o    <= 'b0       ;
      end else  begin
            intf.result_o  <= result   ;
            intf.done_o    <= done     ;
      end
  end : output_assignments

  //-----------------------------------------------------------------------------------------------------
  // Combinatorial ALU computations
  //-----------------------------------------------------------------------------------------------------

  always_comb @ ( * ) begin : alu_computations

      done    =   'b0 ;
      result  =   'd0 ;

      if ( intf.start_i )  begin

          case ( intf.opcode_i )

              NOP_OP  :   done    =   'b1       ;

              ADD_OP  :   result  =   intf.a_i + intf.b_i ;
                          done    =   'b1       ;

              AND_OP  :   result  =   intf.a_i & intf.b_i ;
                          done    =   'b1       ;

              XOR_OP  :   result  =   intf.a_i ^ intf.b_i ;
                          done    =   'b1       ;

              MUL_OP  :   result  =   intf.a_i * intf.b_i ;
                          done    =   'b1       ;

              default :   done    =   'b0       ;

          endcase

      end

  end : alu_computations

  //-----------------------------------------------------------------------------------------------------

endmodule // tiny_alu

//-----------------------------------------------------------------------------------------------------
