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

  import  tiny_alu_pkg  ::    NOP_OP       ;
  import  tiny_alu_pkg  ::    ADD_OP       ;
  import  tiny_alu_pkg  ::    AND_OP       ;
  import  tiny_alu_pkg  ::    XOR_OP       ;
  import  tiny_alu_pkg  ::    MUL_OP       ;


  parameter   ( INPUT_DATA_BITS     =     8   );

  //-------------------------------------------------------------
  //  Ports
  //-------------------------------------------------------------

   (
      clk_reset_interface           clk_rst_if  ,

      tiny_alu_bus_interface   #( .INPUT_DATA_BITS  ( INPUT_DATA_BITS ) )    bus_if

   );



  logic  [ INPUT_DATA_BITS*2-1: 0 ] result        ;
  logic                             done          ;

  //-----------------------------------------------------------------------------------------------------
  // Outputs Assignment
  //-----------------------------------------------------------------------------------------------------

  always_ff @( posedge clk_rst_if.clk_i, posedge clk_rst_if.reset_n_i ) begin  : output_assignments
      if ( clk_rst_if.reset_n_i == 1'b0 )  begin
            bus_if.result_o  <= 'b0       ;
            bus_if.done_o    <= 'b0       ;
      end else  begin
            bus_if.result_o  <= result   ;
            bus_if.done_o    <= done     ;
      end
  end : output_assignments

  //-----------------------------------------------------------------------------------------------------
  // Combinatorial ALU computations
  //-----------------------------------------------------------------------------------------------------

  always_comb @ ( * ) begin : alu_computations

      done    =   'b0 ;
      result  =   'd0 ;

      if ( bus_if.start_i )  begin

          case ( bus_if.opcode_i )

              NOP_OP  :   done    =   'b1       ;

              ADD_OP  :   result  =   bus_if.a_i + bus_if.b_i ;
                          done    =   'b1       ;

              AND_OP  :   result  =   bus_if.a_i & bus_if.b_i ;
                          done    =   'b1       ;

              XOR_OP  :   result  =   bus_if.a_i ^ bus_if.b_i ;
                          done    =   'b1       ;

              MUL_OP  :   result  =   bus_if.a_i * bus_if.b_i ;
                          done    =   'b1       ;

              default :   done    =   'b0       ;

          endcase

      end

  end : alu_computations

  //-----------------------------------------------------------------------------------------------------

endmodule // tiny_alu

//-----------------------------------------------------------------------------------------------------
