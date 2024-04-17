module red_BRAM(clk, reset, pxl_addr, red_clr);
input clk, reset;
input [13:0] pxl_addr;
output red_clr;
// BRAM_SINGLE_MACRO : In order to incorporate this function into the design,
//   Verilog   : the following instance declaration needs to be placed
//  instance   : in the body of the design code.  The instance name
// declaration : (BRAM_SINGLE_MACRO_inst) and/or the port declarations within the
//    code     : parenthesis may be changed to properly reference and
//             : connect this function to the design.  All inputs
//             : and outputs must be connected.

//  <-----Cut code below this line---->

   // BRAM_SINGLE_MACRO: Single Port RAM
   //                    Artix-7
   // Xilinx HDL Language Template, version 2018.3

   /////////////////////////////////////////////////////////////////////
   //  READ_WIDTH | BRAM_SIZE | READ Depth  | ADDR Width |            //
   // WRITE_WIDTH |           | WRITE Depth |            |  WE Width  //
   // ============|===========|=============|============|============//
   //    37-72    |  "36Kb"   |      512    |    9-bit   |    8-bit   //
   //    19-36    |  "36Kb"   |     1024    |   10-bit   |    4-bit   //
   //    19-36    |  "18Kb"   |      512    |    9-bit   |    4-bit   //
   //    10-18    |  "36Kb"   |     2048    |   11-bit   |    2-bit   //
   //    10-18    |  "18Kb"   |     1024    |   10-bit   |    2-bit   //
   //     5-9     |  "36Kb"   |     4096    |   12-bit   |    1-bit   //
   //     5-9     |  "18Kb"   |     2048    |   11-bit   |    1-bit   //
   //     3-4     |  "36Kb"   |     8192    |   13-bit   |    1-bit   //
   //     3-4     |  "18Kb"   |     4096    |   12-bit   |    1-bit   //
   //       2     |  "36Kb"   |    16384    |   14-bit   |    1-bit   //
   //       2     |  "18Kb"   |     8192    |   13-bit   |    1-bit   //
   //       1     |  "36Kb"   |    32768    |   15-bit   |    1-bit   //
   //       1     |  "18Kb"   |    16384    |   14-bit   |    1-bit   //
   /////////////////////////////////////////////////////////////////////

   BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("18Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .DO_REG(0), // Optional output register (0 or 1)
      .INIT(36'h000000000), // Initial values on output port
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(1), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(1),  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .SRVAL(36'h000000000), // Set/Reset value for port output
      .WRITE_MODE("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      //ex. memory location INIT_00 is for 256 to 0                                                   //lines katw <-- panw
      .INIT_00(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//red(1h)-white 
      .INIT_01(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_02(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-red(2h)
      .INIT_03(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//red(3h)-white
      .INIT_04(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_05(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-red(4h)
      .INIT_06(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//red(5h)-white
      .INIT_07(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_08(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-red(6h)
      .INIT_09(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//red(7h)-white
      .INIT_0A(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_0B(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-red(8h)
      .INIT_0C(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//green(1h)-white
      .INIT_0D(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_0E(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-green(2h)
      .INIT_0F(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//green(3h)-white
      .INIT_10(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_11(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-green(4h)
      .INIT_12(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//green(5h)-white
      .INIT_13(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_14(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-green(6h)
      .INIT_15(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//green(7h)-white
      .INIT_16(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_17(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-green(8h)
      .INIT_18(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//blue(1h)-white
      .INIT_19(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_1A(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-blue(2h)
      .INIT_1B(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//blue(3h)-white
      .INIT_1C(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_1D(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-blue(4h)
      .INIT_1E(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//blue(5h)-white
      .INIT_1F(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_20(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-blue(6h)
      .INIT_21(256'h0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//blue(7h)-white
      .INIT_22(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//white-white
      .INIT_23(256'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_0000_0000_0000_0000_0000_0000_0000_0000),//white-blue(8h)
      .INIT_24(256'hF00F_0000_F00F_0000_F00F_0000_F00F_0000_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF),//black(1h)-white
      .INIT_25(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//white-white
      .INIT_26(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_0000_F00F_0000_F00F_0000_F00F_0000),//white-black(2h)
      .INIT_27(256'hF00F_0000_F00F_0000_F00F_0000_F00F_0000_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//black(3h)-white
      .INIT_28(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//white-white
      .INIT_29(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_0000_F00F_0000_F00F_0000_F00F_0000),//white-black(4h)
      .INIT_2A(256'hF00F_0000_F00F_0000_F00F_0000_F00F_0000_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//black(5h)-white
      .INIT_2B(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//white-white
      .INIT_2C(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_0000_F00F_0000_F00F_0000_F00F_0000),//white-black(6h)
      .INIT_2D(256'hF00F_0000_F00F_0000_F00F_0000_F00F_0000_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//black(7h)-white
      .INIT_2E(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF),//white-white
      .INIT_2F(256'hF00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_FFFF_F00F_0000_F00F_0000_F00F_0000_F00F_0000)//white-black(8h)
      

   ) 
   
   BRAM_SINGLE_MACRO_inst (
      .DO(red_clr),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(pxl_addr),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
      //.DI(DI),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1),       // 1-bit input RAM enable
      //.REGCE(REGCE), // 1-bit input output register enable
      .RST(reset),     // 1-bit input reset
      .WE(1'b0)        // Input write enable, width defined by write port depth
   );

   // End of BRAM_SINGLE_MACRO_inst instantiation
endmodule