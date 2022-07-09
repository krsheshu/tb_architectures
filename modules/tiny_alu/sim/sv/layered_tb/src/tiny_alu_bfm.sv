//-----------------------------------------------------------------------------------------------------
// Copyright: Free
// Author: krsheshu
// Brief: BFM for tiny_alu
//-----------------------------------------------------------------------------------------------------


interface timer_bfm

        parameter   ( INPUT_DATA_BITS     =     8   );

//-------------------------------------------------------------
//  Interface signals
//-------------------------------------------------------------
    import clock_period_pkg::CLKPERIOD_NS   ;
    import tiny_alu_pkg::OPCODE_BITS        ;

    logic                                        clk_i        ;
    logic                                        reset_n_i    ;

    logic        [ INPUT_DATA_BITS-1: 0 ]        a_i          ;
    logic        [ INPUT_DATA_BITS-1: 0 ]        b_i          ;

    logic        [ OPCODE_BITS-1: 0 ]            opcode_i     ;
    logic                                        start_i      ;

    logic        [ INPUT_DATA_BITS*2-1: 0 ]      result_o     ;
    logic                                        done_o       :

//-------------------------------------------------------------
//  Clk Description
//-------------------------------------------------------------

initial begin
    clk_i   =   0;
    forever begin
      # (CLKPERIOD_NS/2);
      clk_i = ~clk_i;
    end
end


//-------------------------------------------------------------
//  Initialize module input signals
//-------------------------------------------------------------

initial begin
    reset_n_i     =   1'b1    ;
    start_i       =   1'b0    ;
end

//----------------------------------------------------------------------------------
// sync_reset_timer
//----------------------------------------------------------------------------------


//----------------------------------------------------------------------------------
endinterface
