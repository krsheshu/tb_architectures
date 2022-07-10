//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief: This is a small ALU which is used as a base design for testing various test bench frameworks
//        The ALU has input 8 bit data which computes the results as 16 bit outputs
//        Assuming single clock outputs for all instructions
// Ref: Book: UVM Premier Ray Salemi ( Tiny ALU: Page nb: 10) : https://github.com/raysalemi/uvmprimer
//-----------------------------------------------------------------------------------------------------

interface tiny_alu_intf

  //-------------------------------------------------------------
  //  Imports
  //-------------------------------------------------------------

  import tiny_alu_pkg ::  OPCODE_BITS  ;

      parameter   ( INPUT_DATA_BITS     =     8   );

  //-------------------------------------------------------------
  //  Ports
  //-------------------------------------------------------------
  (
      input   logic                            clk_i        ;
      input   logic                            reset_n_i
  );

  //-------------------------------------------------------------
  //  Interface signals
  //-------------------------------------------------------------

  logic        [ INPUT_DATA_BITS-1: 0 ]        a_i          ;
  logic        [ INPUT_DATA_BITS-1: 0 ]        b_i          ;

  logic        [ OPCODE_BITS-1: 0 ]            opcode_i     ;
  logic                                        start_i      ;

  logic        [ INPUT_DATA_BITS*2-1: 0 ]      result_o     ;
  logic                                        done_o       ;

//-----------------------------------------------------------------------------------------------------

endinterface : tiny_alu_intf

//-----------------------------------------------------------------------------------------------------
