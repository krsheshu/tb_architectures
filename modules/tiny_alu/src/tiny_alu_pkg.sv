//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief:
//-----------------------------------------------------------------------------------------------------


package tiny_alu_pkg;

  localparam OPCODE_BITS                      = 3                       ;

  localparam [ OPCODE_BITS -1: 0 ] NOP_OP     = { OPCODE_BITS { 'd0 } } ;
  localparam [ OPCODE_BITS -1: 0 ] ADD_OP     = { OPCODE_BITS { 'd1 } } ;
  localparam [ OPCODE_BITS -1: 0 ] AND_OP     = { OPCODE_BITS { 'd2 } } ;
  localparam [ OPCODE_BITS -1: 0 ] XOR_OP     = { OPCODE_BITS { 'd3 } } ;
  localparam [ OPCODE_BITS -1: 0 ] MUL_OP     = { OPCODE_BITS { 'd4 } } ;


endpackage // tiny_alu_pkg

//-----------------------------------------------------------------------------------------------------
