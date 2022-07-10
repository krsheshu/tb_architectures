//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief: BFM for tiny_alu
//-----------------------------------------------------------------------------------------------------


interface tiny_alu_bfm

  //-------------------------------------------------------------
  //  Interface signals
  //-------------------------------------------------------------
  clk_reset_interface           clk_rst_if  ;

  tiny_alu_bus_interface   #( .INPUT_DATA_BITS  ( INPUT_DATA_BITS ) )    bus_if ;

  //----------------------------------------------------------------------------------
  // Task: compute
  //----------------------------------------------------------------------------------

  task compute (  input logic [ OPCODE_BITS.1     : 0 ]   opcode  ,
                  input logic [ INPUT_DATA_BITS-1 : 0 ]   a       ,
                  input logic [ INPUT_DATA_BITS-1 : 0 ]   b       )

    @ (posedge clk_rst_if.clk_i)  ;
        bus_if.start_i  <= 1'b1   ;
        bus_if.a_i      <= a      ;
        bus_if.b_i      <= b      ;

  endtask : compute


  //----------------------------------------------------------------------------------
  // Task: stop_compute
  //----------------------------------------------------------------------------------

  task stop_compute ( )

    @ (posedge clk_rst_if.clk_i) ;
        bus_if.start_i = 1'b0;

  endtask : end_compute


  //----------------------------------------------------------------------------------
  // Task: get_compute
  //----------------------------------------------------------------------------------

  task get_result ( output logic                              valid   ,
                    output logic [ INPUT_DATA_BITS*2-1 : 0 ]  result  )

    @ (posedge clk_rst_if.clk_i) ;
        result  = ( bus_if.done == 1'b1 ) ?  bus_if.result_o : 'd0  ;
        valid   = bus_if.done_o ;

  endtask


//----------------------------------------------------------------------------------
endmodule : tiny_alu_bfm
