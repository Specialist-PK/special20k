/*
    greetings to
    AlexBel, HardWareMan, Stanislav Yudin, svofski, Dolphin Soft, fifan, strijar
    and all of tg fahivets85

*/

`define GW_IDE

module top_level(
    input   wire clk27mhz,
    input   wire btn_s1,       // to +3.3v
    input   wire btn_s2,       // to +3.3v

    // SDRAM
    output O_sdram_clk,
    output O_sdram_cke,
    output O_sdram_cs_n,            // chip select
    output O_sdram_cas_n,           // columns address select
    output O_sdram_ras_n,           // row address select
    output O_sdram_wen_n,           // write enable
    inout [31:0] IO_sdram_dq,       // 32 bit bidirectional data bus
    output [10:0] O_sdram_addr,     // 11 bit multiplexed address bus
    output [1:0] O_sdram_ba,        // two banks
    output [3:0] O_sdram_dqm,       // 32/4

    output  wire[1:0]led,

    output  wire [2:0]tmds_d_p,
    output  wire [2:0]tmds_d_n,
    output  wire tmds_clk_p,
    output  wire tmds_clk_n,

	inout   ps2_kb_dat,
	inout   ps2_kb_clk,

    input   wire UART_RXD,
    output  wire UART_TXD,

		// SDCARD
    output wire		SD_CS,		// CS
	output wire 	SD_SCK,		// SCLK
	output wire 	SD_CMD,		// MOSI
	input  wire  	SD_DAT0,	// MISO
    
    output  wire [7:0]dbg

);

wire    reset;
wire    reset_hdmi, lockhdmi, locksdram;
wire    clk2mhz, clk_sound, cpu_clk, clk32mhz, clk12mhz;

wire [15:0]cpu_ADDR;
wire [7:0]o_cpu_data;
wire [7:0]i_cpu_data;
reg cpu_nRESET;
wire cpu_SYNC;
wire cpu_RD;
wire cpu_nWR;
wire cpu_INTR;
wire cpu_INTE;
wire cpu_nMREQ;  // Z80
wire cpu_nRD;    // Z80
wire [7:0]cpu_DATA;
reg [7:0]cpu_STATUS;

wire    [7:0]romdata;
wire    [7:0]low_mem_out;
wire    [13:0]Vmem_addr;
wire    [10:0]Vmem_data;
wire    [10:0]v_mem_out;
wire    VmemWR;

reg startupBB55 = 1;
wire CE_ROM_C000, CE_ROM_C800, CE_ROM_D000, CE_ROM_D800, CE_ROM_E000, CE_ROM_E800, CE_REG_F000, CE_REG_F800;
wire sys_K580BB55_RD;
wire sys_K580BB55_WR;
reg [7:0] sys_porta;
reg [7:0] sys_portb;
reg [7:0] sys_portc;
reg [7:0] sys_portr;
wire [7:0]sys_VV55Ain;
wire [5:0]sys_VV55Bin;
wire [3:0]sys_VV55Cin;
wire     kbshift, kbreset;
wire [5:0] KeyMap [11:0];
wire [5:0]func_keys;
reg     beep;
wire    [15:0]soundL;
wire    [15:0]soundR;

wire    [7:0]sd_o;
wire    [7:0]o_gs_data;

wire    vi53_wren, vi53_rden;
wire	[2:0]vi53_out;
wire	[7:0]vi53_odata;
wire    vi53_sel;

wire    clk_pixel_x5, clk_pixel;

wire    memWR, memRD;
wire    [15:0]mem_addr;
wire    [7:0]o_mem_data;
wire    [7:0]sdramDOUT;
wire    [20:0]sdramADDR;
wire    sdramRD;
wire    sdramWR;
wire    sdramRFSH;
wire    sdramBUSY;

localparam                       UART_BAUD      =  38400;
localparam                       UART_STATUS    =  16'hE100;
localparam                       UART_RXR       =  16'hE101;
localparam                       UART_TXR       =  16'hE102;
reg [1:0]uart_state;
localparam                       IDLE =  0;
localparam                       RCV =  1;
wire    [7:0]uart_rx_data;
wire    [7:0]uart_status;
wire    uart_rx_data_valid;
wire    uart_tx_data_ready;
reg     uart_tx_data_valid;
reg     [15:0]uart_addr;

    assign  led[0] = ~cpu_RD;
    assign  led[1] = cpu_nWR;

//--------------------------------------------------------------------------------------
    assign  reset_hdmi = ~lockhdmi;
    //assign  reset = ( btn_s1 || btn_s2 || !locksdram );
    assign  reset = ( btn_s1 || !locksdram );

    BUFG clk_27m_inst(    .O( clkB27mhz ),    .I( clk27mhz )    );


always @( posedge clkB27mhz or posedge reset )begin
    if( reset )
        cpu_nRESET <= 0;
    else if( !sdramBUSY )
        cpu_nRESET <= 1;
end;
//--------------------------------------------------------------------------------------
    t20k_hdmi clk_hdmi_inst( .clkout( clkU_pixel_x5 ), .lock( lockhdmi ), .clkin( clk27mhz )  );
// pixel clock divider
    CLKDIV #(.DIV_MODE(5)) div5 (  .CLKOUT( clkU_pixel ), .HCLKIN( clk_pixel_x5 ),
        .RESETN( 1'b1 ),        .CALIB( 1'b0 )    );
    BUFG clk_hdmi5_inst(   .O( clk_pixel_x5 ), .I( clkU_pixel_x5 )    );
    BUFG clk_hdmi1_inst(    .O( clk_pixel ),    .I( clkU_pixel )    );

// SDRAM 140 mhz
    t20_sdram clk_sdram_inst( .clkout( clkUout ), .clkoutp( clkUoutp ), .lock( locksdram ), .clkin( clk27mhz )    );
    BUFG clk_sdr_inst(    .O( clkout ),    .I( clkUout )    );
    BUFG clk_sdrp_inst(   .O( clkoutp ),    .I( clkUoutp )    );

// Output Clock frequency = 32mhz for CPU
    CLOCK_DIV #(.CLK_SRC( 371.5 ), .CLK_DIV( 32.0 ), .PRECISION_BITS(16) ) cpuclkd ( .clk_src( clk_pixel_x5 ), .clk_div( clkU32mhz )    );
    BUFG clk_32m_inst(   .O( clk32mhz ),    .I( clkU32mhz )    );

// Output Clock frequency = 48kHz
    CLOCK_DIV #(.CLK_SRC(  27.0 ), .CLK_DIV( 0.048 ),.PRECISION_BITS(16) ) sndclkd (.clk_src( clkB27mhz   ), .clk_div( clkU_sound )    );
    BUFG clk_48k_inst(   .O( clk_sound ),    .I( clkU_sound )    );

reg     [4:0]cpu_div;
//reg     clk_f1, clk_f2;
always @(posedge clk32mhz )begin
    if( reset )begin
        cpu_div <= 5'b00000;
//        clk_f1 <= 0;
//        clk_f2 <= 0;
    end else begin
        cpu_div <= cpu_div + 1'b1;
//        if( (cpu_div > 0 && cpu_div < 4) || (cpu_div > 16 && cpu_div < 20) ) begin clk_f1 <= 1; clk_f2 <= 0; end else
//        if( (cpu_div > 8 && cpu_div < 11)|| (cpu_div > 24 && cpu_div < 27) ) begin clk_f1 <= 0; clk_f2 <= 1; end else
//        begin clk_f1 <= 0; clk_f2 <= 0; end
    end
end
    //assign  cpu_clk = clkB32mhz;    // 32 mhz
    //assign  cpu_clk = cpu_div[0];   // 16 mhz
    //assign  cpu_clk = cpu_div[1];   // 8 mhz
    //assign  cpu_clk = cpu_div[2];   // 4 mhz
    assign  cpu_clk = cpu_div[3];   // 2 mhz
    assign  clk2mhz = cpu_div[3];   // 2 mhz

//--------------------------------------------------------------------------------------


    assign  cpu_INTR = 1'b0;
    assign  i_cpu_data =
    ( sys_K580BB55_RD && cpu_ADDR[1:0] == 2'b00 ) ? sys_VV55Ain :                                   // portA
    ( sys_K580BB55_RD && cpu_ADDR[1:0] == 2'b01 ) ? { sys_VV55Bin, kbshift, /*tapein*/ 1'b0 } :     // portB, rows
    ( sys_K580BB55_RD && cpu_ADDR[1:0] == 2'b10 ) ? { 4'b0000, sys_VV55Cin } :                      // portC
    ( sys_K580BB55_RD && cpu_ADDR[1:0] == 2'b11 ) ? sys_portr :

//                        ( (cpu_ADDR[15:0] == 16'hF700 || cpu_ADDR[15:0] == 16'hF701) && cpu_RD ) ? sd_o :       // sd_msx
    ( cpu_ADDR[15:0] == 16'hF000 && cpu_RD ) ? sd_o :                                       // SD_HWM_PVV
    ( vi53_rden ) ? vi53_odata :                                                            // timer
    (( CE_ROM_C000||CE_ROM_C800||CE_ROM_D000||CE_ROM_D800||startupBB55) ) ? romdata :

    ( cpu_ADDR[15:0] == 16'hF0B3 && cpu_RD ) ? o_gs_data :  // GS data reg
    ( cpu_ADDR[15:0] == 16'hF0BB && cpu_RD ) ? o_gs_data :  // GS status reg

    ( cpu_ADDR[15] == 1'b0 && cpu_RD ) ? low_mem_out : // RAM
    ( cpu_ADDR[15:14] == 2'b10 && cpu_RD ) ? v_mem_out[7:0] : 

    ( cpu_ADDR == UART_STATUS   && cpu_RD ) ? uart_status :
    ( cpu_ADDR == UART_RXR      && cpu_RD ) ? uart_rx_data :

                        8'hFF;

    assign  CE_ROM_C000 = ( cpu_ADDR[15:11] == 5'b11000 ) ? 1'b1 : 1'b0;    // ROM, ro
    assign  CE_ROM_C800 = ( cpu_ADDR[15:11] == 5'b11001 ) ? 1'b1 : 1'b0;    // ROM, ro
    assign  CE_ROM_D000 = ( cpu_ADDR[15:11] == 5'b11010 ) ? 1'b1 : 1'b0;    // SDOS, ro
    assign  CE_ROM_D800 = ( cpu_ADDR[15:11] == 5'b11011 ) ? 1'b1 : 1'b0;    // SDOS buffers, rw
    assign  vi53_sel = cpu_ADDR[15:2] == 14'h3800;      // 0xE00x
    assign  CE_ROM_E800 = ( cpu_ADDR[15:11] == 5'b11101 ) ? 1'b1 : 1'b0;    // SP580 - BB55
    assign  CE_REG_F000 = ( cpu_ADDR[15:11] == 5'b11110 ) ? 1'b1 : 1'b0;    // SP580 - BB55 kbd, STD - BB55
    assign  CE_REG_F800 = ( cpu_ADDR[15:11] == 5'b11111 ) ? 1'b1 : 1'b0;    // SP580 - ROM, STD - BB55 kbd

    assign  sys_K580BB55_RD = ( CE_REG_F800 && cpu_RD  == 1'b1 ) ? 1'b1 : 1'b0;
    assign  sys_K580BB55_WR = ( CE_REG_F800 && cpu_nWR == 1'b0 ) ? 1'b1 : 1'b0;

    assign  vi53_wren = ( vi53_sel && cpu_nWR == 1'b0 ) ? 1'b1 : 1'b0;
    assign  vi53_rden = ( vi53_sel && cpu_RD  == 1'b1 ) ? 1'b1 : 1'b0;

    assign  mem_addr = startupBB55 ? {2'b11, cpu_ADDR[13:0]} :          // startup
                       cpu_ADDR;                                        // normal
    assign  memWR =  ( cpu_ADDR[15]== 1'b0 && !cpu_nWR );
//    assign  memRD =  ( cpu_RD );
    assign  VmemWR = ( !cpu_nWR && cpu_ADDR[15:14] == 2'b10 );
    wire topramWR = ( CE_ROM_D800 && !cpu_nWR );

//--------------------------------------------------------------------------------------
/*
    t20k_rom ROM_inst(
        .dout( romdata ),
        .clk( clk32mhz ),
        .oce( 1'b1 ),
        .ce( 1'b1 ),
        .reset( reset ),
        .ad( cpu_ADDR[12:0] )
    );*/

    t20k_romram ROMRAM(
        .dout( romdata ),
        .clk( clk32mhz ),
        .oce( 1'b1 ),
        .ce( 1'b1 ),
        .reset( reset ),
        .wre( topramWR ),
        .ad( cpu_ADDR[12:0] ),
        .din( o_cpu_data )
    );

/*
    t20k_vmem VRAM_inst(
        .reseta( reset ),
        .resetb( reset_hdmi ),
        .oce( 1'b1 ),
        .clka( clk32mhz ),
        .cea( VmemWR ),
        .ada( cpu_ADDR[13:0] ),
        .din( { sys_portc[7], sys_portc[6], sys_portc[4], o_cpu_data } ),

        .clkb( clk_pixel ),
        .ceb( 1'b1 ),
        .adb( Vmem_addr ),
        .dout( Vmem_data )
    );
*/
    t20k_vmemDP VRAM_inst(
        .clka( clk32mhz ),
        .ocea( 1'b1 ),
        .cea( 1'b1 ),
        .reseta( reset ),
        .wrea( VmemWR ),
        .ada( cpu_ADDR[13:0] ),
        .dina( { sys_portc[7], sys_portc[6], sys_portc[4], o_cpu_data } ),
        .douta( v_mem_out ),


        .clkb( clk_pixel ),
        .oceb( 1'b1 ),
        .ceb( 1'b1 ),
        .resetb( reset_hdmi ),
        .wreb( 1'b0 ),
        .adb( Vmem_addr ),
        .dinb( 11'h000 ),
        .doutb( Vmem_data )
    );

    t20k_mem low_mem_inst(
        .dout( low_mem_out ),
        .clk( clk32mhz ),
        .oce( 1'b1 ),
        .ce( 1'b1 ),
        .reset( reset ),
        .wre(   ( uart_state == RCV ) ? 1'b1 : memWR ),
        .ad(    ( uart_state == RCV ) ? uart_addr : cpu_ADDR[14:0] ),
        .din(   ( uart_state == RCV ) ? uart_rx_data : o_cpu_data )
    );
//--------------------------------------------------------------------------------------
reg sdrd;
reg sdwr;
reg sdrf;
reg [1:0]rdedgedet;
reg [1:0]wredgedet;
reg [1:0]rfedgedet;

    assign o_mem_data = sdramDOUT;
    assign sdramADDR = { 5'b0000, mem_addr };
    assign sdramWR = 0;//sdwr;
    assign sdramRD = 0;//sdrd;
    assign sdramRFSH = sdrf;

reg [1:0]GSrdedgedet;
reg [1:0]GSwredgedet;
    wire GS_MRD, GS_MWR, GS_RF;
    reg sdramGS_RD;
    reg sdramGS_WR;
    wire [20:0]sdramGS_ADDR;
    wire [7:0]sdramGS_DIN;
    wire [7:0]sdramGS_DOUT;


//always @( posedge sdramBUSY or posedge GS_MRD )begin
//    if( sdramBUSY ) sdramGS_RD <= 0;
 //   else if( GS_MRD ) sdramGS_RD <= 1;
//end

always @( posedge clkout )begin

    GSrdedgedet[0] <= GS_MRD;
    GSrdedgedet[1] <= GSrdedgedet[0];
    if( GSrdedgedet == 2'b01 )sdramGS_RD <= 1;
    else sdramGS_RD <= 0;

    GSwredgedet[0] <= GS_MWR;
    GSwredgedet[1] <= GSwredgedet[0];
    if( GSwredgedet == 2'b01 )sdramGS_WR <= 1;
    else sdramGS_WR <= 0;

/*
    rdedgedet[0] <= cpu_RD;//memRD;
    rdedgedet[1] <= rdedgedet[0];
    if( rdedgedet == 2'b01 )
        sdrd <= 1;
    else
        sdrd <= 0;

    wredgedet[0] <= ~cpu_nWR;//memWR;
    wredgedet[1] <= wredgedet[0];
    if( wredgedet == 2'b01 )begin
        sdwr <= 1;
    end else
        sdwr <= 0;
*/
//    rfedgedet[0] <= cpu_SYNC;
//    rfedgedet[0] <= ~cpu_RD;
    rfedgedet[0] <= GS_RF;
    rfedgedet[1] <= rfedgedet[0];
    if( rfedgedet == 2'b01 )        sdrf <= 1;
    else        sdrf <= 0;

end
/*
  MemoryController memory(.clk( clkout ), .clk_sdram( clkoutp ), .resetn( ~reset ),
        .read_a( sdrd ), 
        .read_b( sdramGS_RD ),
        .write_a( sdwr ),
        .write_b( sdramGS_WR ),
        .refresh( 0 ),
        .addr_a( sdramADDR ),
        .addr_b( sdramGS_ADDR ),
        .din_a( o_cpu_data ),
        .din_b( sdramGS_DOUT ),
        .dout_a( sdramDOUT ),
        .dout_b( sdramGS_DIN ),
        .busy( sdramBUSY ),

        .SDRAM_DQ(IO_sdram_dq), .SDRAM_A(O_sdram_addr), .SDRAM_BA(O_sdram_ba), .SDRAM_nCS(O_sdram_cs_n),
        .SDRAM_nWE(O_sdram_wen_n), .SDRAM_nRAS(O_sdram_ras_n), .SDRAM_nCAS(O_sdram_cas_n), 
        .SDRAM_CLK(O_sdram_clk), .SDRAM_CKE(O_sdram_cke), .SDRAM_DQM(O_sdram_dqm)
);*/



MemoryController sdram(
    .clk( clkout ),        // Main logic clock
    .clkp( clkoutp ),        // Main logic clock
    .resetn( ~reset ),
    .RD( sdramGS_RD ),        // Set to 1 to read from RAM
    .WR( sdramGS_WR ),       // Set to 1 to write to RAM
//    .RD( GS_MRD ),        // Set to 1 to read from RAM
//    .WR( GS_MWR ),       // Set to 1 to write to RAM

    .addr( sdramGS_ADDR   ),    // Address to read / write
    .din( sdramGS_DOUT ),      // Data to write
    .dout( sdramGS_DIN ),      // Last read data a, available 4 cycles after read_a is set

//    .GS_RD( sdramGS_RD ),
//    .GS_WR( sdramGS_WR ),
//    .GS_RD( GS_MRD ),
//    .GS_WR( GS_MWR ),
//    .GS_addr( sdramGS_ADDR ),
//    .GS_din( sdramGS_DOUT ),
//    .GS_dout( sdramGS_DIN ),

    .BUSY( sdramBUSY ),   // 1 while an operation is in progress
    .RFSH( sdramRFSH ),
//    .dbg( dbg ),
    // Physical SDRAM interface
        .SDRAM_DQ(IO_sdram_dq), .SDRAM_A(O_sdram_addr), .SDRAM_BA(O_sdram_ba), .SDRAM_nCS(O_sdram_cs_n),
        .SDRAM_nWE(O_sdram_wen_n), .SDRAM_nRAS(O_sdram_ras_n), .SDRAM_nCAS(O_sdram_cas_n), 
        .SDRAM_CLK(O_sdram_clk), .SDRAM_CKE(O_sdram_cke), .SDRAM_DQM(O_sdram_dqm)
);



//--------------------------------------------------------------------------------------
// K580BB55
always @( negedge cpu_nRESET or posedge cpu_clk )begin
    if( !cpu_nRESET )begin
        sys_porta <= 8'h00;
        sys_portb <= 8'h00;
        sys_portc <= 8'h00;
        sys_portr <= 8'h00;
        startupBB55 <= 1;
    end else begin
    
        if( sys_K580BB55_WR == 1'b1 )begin
            case( cpu_ADDR[1:0] )
            2'b00:sys_porta <= o_cpu_data;
            2'b01:sys_portb <= o_cpu_data;
            2'b10: begin
                sys_portc <= o_cpu_data;
                beep <= ~o_cpu_data[5];
                end
            2'b11: begin
                sys_portr <= o_cpu_data;
                startupBB55 <= 1'b0;
                if( o_cpu_data[7] == 1'b0 && o_cpu_data[3:1] == 3'b101 )
                    beep <= ~o_cpu_data[0];
                end
            endcase
        end
    end
end
//--------------------------------------------------------------------------------------

k580wm80a cpuA(
	.clk( cpu_clk ),
	.ce( 1'b1 ),
	.reset( ~cpu_nRESET ),
	.intr( cpu_INTR ),
	.idata( i_cpu_data ),
	.addr( cpu_ADDR ),
	.sync( cpu_SYNC ),
	.rd( cpu_RD ),
	.wr_n( cpu_nWR ),
	.inta_n(),
	.odata( o_cpu_data ),
	.inte_o( cpu_INTE )
);
/*
vm80a cpuC(
	.pin_clk( clk32mhz ),			// global module clock (no in original 8080)
//	.pin_f1( clk_f1 ),			// clock phase 1 (used as clock enable)
//	.pin_f2( clk_f2 ),			// clock phase 2 (used as clock enable)
	.pin_f1( cpu_clk ),			// clock phase 1 (used as clock enable)
	.pin_f2( ~cpu_clk ),			// clock phase 2 (used as clock enable)
	.pin_reset( ~cpu_nRESET ),		// module reset
	.pin_a( cpu_ADDR ),			// address bus outputs
    .pin_d( cpu_DATA ),			//inout
	.pin_hold( 1'b0 ),		//
	.pin_hlda(),		//
	.pin_ready( 1'b1 ),		//
	.pin_wait(),		//
	.pin_int( cpu_INTR ),			//
	.pin_inte( cpu_INTE ),		//
	.pin_sync( cpu_SYNC ),		//
	.pin_dbin( cpu_RD ),
	.pin_wr_n( cpu_nWR )
);
//always @( negedge clk_f1 )begin
//    if( cpu_SYNC )
//        cpu_STATUS <= cpu_DATA;
//end
assign  cpu_DATA = cpu_RD ? i_cpu_data : 8'hZZ;
assign  o_cpu_data = cpu_DATA;
*/

//--------------------------------------------------------------------------------------
// KeyMap[10][4] - '1'
assign  sys_VV55Ain ={(sys_portb[2] ? 1'b1 : KeyMap[7][0]) & (sys_portb[3] ? 1'b1 : KeyMap[7][1]) & (sys_portb[4] ? 1'b1 : KeyMap[7][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[7][3]) & (sys_portb[6] ? 1'b1 : KeyMap[7][4]) & (sys_portb[7] ? 1'b1 : KeyMap[7][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[6][0]) & (sys_portb[3] ? 1'b1 : KeyMap[6][1]) & (sys_portb[4] ? 1'b1 : KeyMap[6][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[6][3]) & (sys_portb[6] ? 1'b1 : KeyMap[6][4]) & (sys_portb[7] ? 1'b1 : KeyMap[6][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[5][0]) & (sys_portb[3] ? 1'b1 : KeyMap[5][1]) & (sys_portb[4] ? 1'b1 : KeyMap[5][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[5][3]) & (sys_portb[6] ? 1'b1 : KeyMap[5][4]) & (sys_portb[7] ? 1'b1 : KeyMap[5][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[4][0]) & (sys_portb[3] ? 1'b1 : KeyMap[4][1]) & (sys_portb[4] ? 1'b1 : KeyMap[4][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[4][3]) & (sys_portb[6] ? 1'b1 : KeyMap[4][4]) & (sys_portb[7] ? 1'b1 : KeyMap[4][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[3][0]) & (sys_portb[3] ? 1'b1 : KeyMap[3][1]) & (sys_portb[4] ? 1'b1 : KeyMap[3][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[3][3]) & (sys_portb[6] ? 1'b1 : KeyMap[3][4]) & (sys_portb[7] ? 1'b1 : KeyMap[3][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[2][0]) & (sys_portb[3] ? 1'b1 : KeyMap[2][1]) & (sys_portb[4] ? 1'b1 : KeyMap[2][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[2][3]) & (sys_portb[6] ? 1'b1 : KeyMap[2][4]) & (sys_portb[7] ? 1'b1 : KeyMap[2][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[1][0]) & (sys_portb[3] ? 1'b1 : KeyMap[1][1]) & (sys_portb[4] ? 1'b1 : KeyMap[1][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[1][3]) & (sys_portb[6] ? 1'b1 : KeyMap[1][4]) & (sys_portb[7] ? 1'b1 : KeyMap[1][5]),
                      (sys_portb[2] ? 1'b1 : KeyMap[0][0]) & (sys_portb[3] ? 1'b1 : KeyMap[0][1]) & (sys_portb[4] ? 1'b1 : KeyMap[0][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[0][3]) & (sys_portb[6] ? 1'b1 : KeyMap[0][4]) & (sys_portb[7] ? 1'b1 : KeyMap[0][5]) };

assign sys_VV55Bin =   (sys_porta[0] ? 6'b111111 : KeyMap[0])  &  (sys_porta[1] ? 6'b111111 : KeyMap[1]) &
                       (sys_porta[2] ? 6'b111111 : KeyMap[2])  &  (sys_porta[3] ? 6'b111111 : KeyMap[3]) &
                       (sys_porta[4] ? 6'b111111 : KeyMap[4])  &  (sys_porta[5] ? 6'b111111 : KeyMap[5]) &
                       (sys_porta[6] ? 6'b111111 : KeyMap[6])  &  (sys_porta[7] ? 6'b111111 : KeyMap[7]) &
                       (sys_portc[0] ? 6'b111111 : KeyMap[8])  &  (sys_portc[1] ? 6'b111111 : KeyMap[9]) &
                       (sys_portc[2] ? 6'b111111 : KeyMap[10]) &  (sys_portc[3] ? 6'b111111 : KeyMap[11]);

assign sys_VV55Cin ={ (sys_portb[2] ? 1'b1 : KeyMap[11][0]) & (sys_portb[3] ? 1'b1 : KeyMap[11][1]) & (sys_portb[4] ? 1'b1 : KeyMap[11][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[11][3]) & (sys_portb[6] ? 1'b1 : KeyMap[11][4]) & (sys_portb[7] ? 1'b1 : KeyMap[11][5]),    // C3
                      (sys_portb[2] ? 1'b1 : KeyMap[10][0]) & (sys_portb[3] ? 1'b1 : KeyMap[10][1]) & (sys_portb[4] ? 1'b1 : KeyMap[10][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[10][3]) & (sys_portb[6] ? 1'b1 : KeyMap[10][4]) & (sys_portb[7] ? 1'b1 : KeyMap[10][5]),    // C2
                      (sys_portb[2] ? 1'b1 : KeyMap[9][0])  & (sys_portb[3] ? 1'b1 : KeyMap[9][1])  & (sys_portb[4] ? 1'b1 : KeyMap[9][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[9][3])  & (sys_portb[6] ? 1'b1 : KeyMap[9][4])  & (sys_portb[7] ? 1'b1 : KeyMap[9][5]),     // C1
                      (sys_portb[2] ? 1'b1 : KeyMap[8][0])  & (sys_portb[3] ? 1'b1 : KeyMap[8][1])  & (sys_portb[4] ? 1'b1 : KeyMap[8][2]) &
                      (sys_portb[5] ? 1'b1 : KeyMap[8][3])  & (sys_portb[6] ? 1'b1 : KeyMap[8][4])  & (sys_portb[7] ? 1'b1 : KeyMap[8][5]) };   // C0
//--------------------------------------------------------------------------------------
/*
ps2kbd kbdPS_inst(
    .ps2_kb_dat( ps2_kb_dat ),
    .ps2_kb_clk( ps2_kb_clk ),
    .clk( clk32mhz ),
    .reset( reset ),
//    .dbg(aaaa),
    .KeyMap0( KeyMap[0] ),    .KeyMap1( KeyMap[1] ),    .KeyMap2( KeyMap[2] ),    .KeyMap3( KeyMap[3] ),
    .KeyMap4( KeyMap[4] ),    .KeyMap5( KeyMap[5] ),    .KeyMap6( KeyMap[6] ),    .KeyMap7( KeyMap[7] ),
    .KeyMap8( KeyMap[8] ),    .KeyMap9( KeyMap[9] ),    .KeyMap10( KeyMap[10] ),    .KeyMap11( KeyMap[11] ),
    .Func( func_keys )
);
*/
b2m_kbd kbdPS_inst(
	.clk( clk32mhz ),
	.reset( reset ),
	.ps2_clk( ps2_kb_clk ),
	.ps2_dat( ps2_kb_dat ),

    .KeyMap0( KeyMap[0] ),    .KeyMap1( KeyMap[1] ),    .KeyMap2( KeyMap[2] ),    .KeyMap3( KeyMap[3] ),
    .KeyMap4( KeyMap[4] ),    .KeyMap5( KeyMap[5] ),    .KeyMap6( KeyMap[6] ),    .KeyMap7( KeyMap[7] ),
    .KeyMap8( KeyMap[8] ),    .KeyMap9( KeyMap[9] ),    .KeyMap10( KeyMap[10] ),    .KeyMap11( KeyMap[11] ),
    .Func( func_keys )
);
    assign  kbshift = ~func_keys[0];

assign  kbreset = func_keys[1];
//assign  LED[5] = ~aaaa;
//--------------------------------------------------------------------------------------
  k580vi53 timer_ins(
    .reset( ~cpu_nRESET ),
    .clk_sys( clk32mhz ),
    .addr( cpu_ADDR[1:0] ),
    .din( o_cpu_data ),
    .dout( vi53_odata ),
    .wr( vi53_wren ),
    .rd( vi53_rden ),
    .clk_timer( { vi53_out[1], clk2mhz, clk2mhz } ),
    .gate( { 1'b1, 1'b1, ~vi53_out[2] } ),
    .out( vi53_out ),
    .sound_active()            
);

wire [15:0]GSsoundL;
wire [15:0]GSsoundR;

reg [15:0]fifosndl[2];
reg [15:0]fifosndr[2];
wire [15:0]fout;

always @( posedge clk_pixel )begin
    fifosndl[0] <= { vi53_out[0] ^ beep, 12'h0000 } + GSsoundL;
    fifosndl[1] <= fifosndl[0];
    fifosndr[0] <= { vi53_out[0] ^ beep, 12'h0000 } + GSsoundR;
    fifosndr[1] <= fifosndr[0];
end


    assign  soundL = fifosndl[1];
    assign  soundR = fifosndr[1];

//    assign  soundL = GSsoundL;
//    assign  soundR = GSsoundR;


/*
reg [127:0]soundbuff;
reg [15:0]soundsum;
logic [13:0]  vsum [96:0];
always @( posedge cpu_clk )begin
    soundbuff <= {soundbuff[126:0], beep};
end

always_comb begin
        for (int i = 0; i < 96; i=i+1) begin
            vsum[i+1] = vsum[i] + soundbuff[i];
        end
    end
    assign  fout = {vsum[96], 4'h0};
//    assign  soundL = !btn_s2 ? fout : { beep, 12'h0000 };
//    assign  soundR = !btn_s2 ? fout : { beep, 12'h0000 };
*/
//--------------------------------------------------------------------------------------
sdos sdos_inst(
    .reset( reset ),
    .c_sclk( cpu_clk ), // 2 mhz
    .cpu_ADDR( cpu_ADDR ),
    .o_cpu_data( o_cpu_data ),
    .cpu_nWR( cpu_nWR ),
    .sd_o( sd_o ),

    .SD_DAT( SD_DAT0 ),					//	SD Card Data
    .SD_DAT3( SD_CS ),				//	SD Card Data 3
    .SD_CMD( SD_CMD ),					//	SD Card Command Signal
    .SD_CLK( SD_SCK )					//	SD Card Clock
);
//--------------------------------------------------------------------------------------
reg uart_RNE;
uart_rx#(	.CLK_FRE( 27 ),	.BAUD_RATE( UART_BAUD )) uart_rx_inst(
	.clk( clk27mhz ), .rst_n( ~reset ),
	.rx_data( uart_rx_data ), .rx_data_valid( uart_rx_data_valid ),
	.rx_data_ready( 1'b1 ), //always can receive data
	.rx_pin( UART_RXD )
);

uart_tx#(	.CLK_FRE( 27 ),	.BAUD_RATE( UART_BAUD )) uart_tx_inst(
	.clk( clk27mhz ), .rst_n( ~reset ),
	.tx_data( o_cpu_data ),
	.tx_data_valid( uart_tx_data_valid ),
	.tx_data_ready( uart_tx_data_ready ),
	.tx_pin( UART_TXD )
);
/* not so stable
always @( posedge clk27mhz or posedge reset )begin
    if( reset )begin
        uart_addr <= 16'h0000;
        uart_state <= IDLE;
    end else begin
        case( uart_state )
            IDLE: begin
                if( uart_rx_data_valid )begin
                    uart_state <= RCV;
                end
            end
            RCV: begin
                if( !uart_rx_data_valid )begin
                    uart_state <= IDLE;
                    uart_addr <= uart_addr + 1'b1;
                end
            end
        endcase
    end
end*/

always @( posedge clk27mhz or posedge reset )begin
    if( reset )begin
        uart_RNE <= 1'b0;         // rx have a byte flag
    end else begin
        if( uart_rx_data_valid )begin
            uart_RNE <= 1'b1;     // uart receive
        end else
        if( cpu_ADDR == UART_RXR && cpu_RD ) begin
            uart_RNE <= 1'b0;     // user read byte
        end
    end
end

always @( posedge clk27mhz or posedge reset )begin
    if( reset )begin
        uart_tx_data_valid <= 1'b0;
    end else begin
        if( !uart_tx_data_ready )           // byte started
            uart_tx_data_valid <= 1'b0;
        else
        if( cpu_ADDR == UART_TXR && !cpu_nWR )begin
            uart_tx_data_valid <= 1'b1;
        end
    end
end

    assign  uart_status = { 6'b000000, uart_tx_data_ready, uart_RNE };

//--------------------------------------------------------------------------------------

    // video
    // Horizontal Timings
    wire [11:0] ActivePixels;
    wire [11:0]TotalPixels;
    //    Vertical Timings
    wire [11:0]ActiveLines;
    wire [11:0]TotalLines;

    parameter LinesMax = 256;
    parameter PixelMax = 384;

    wire [11:0]h_counter;
    wire [11:0]v_counter;
    reg r, g, b, p;
    
    reg [2:0]hscale = 0;
    reg [2:0]vscale = 0;
    reg [7:0]vcnt = 0;
    reg [8:0]hcnt = 0;

    reg [7:0]vid_0_reg;
    reg [7:0]vid_1_reg;    
    reg [7:0]vid_b_reg;
    reg [7:0]vid_c_reg;

    parameter Hscalefactor = 2;
    parameter HOffset_c = 256 - 8;
    reg [8:0]hoffset = 0;
    reg leftborder = 0;

    parameter Vscalefactor = 2;
    parameter VOffset_c = 104;
    reg [7:0]voffset = 0;
    reg topborder = 0;
    reg botborder = 0;
    
    reg screen;
    reg screen1;
    reg blank;
    wire [7:0]Rout;
    wire [7:0]Gout;
    wire [7:0]Bout;
    
    assign Rout = {r, r, r, r, r, r, r, r};
    assign Gout = {g, g, g, g, g, g, g, g};
    assign Bout = {b, p, b, b, b, b, b, b};

    assign  Vmem_addr = {{6'h10 + hcnt[8:3]}, vcnt[7:0] };

//  counters
always @( posedge clk_pixel )begin
        if ( h_counter == (TotalPixels-1) ) begin
           // new line begin, reset all counters
            hscale <= 0;
            hoffset <= 0;     // left offset
            hcnt <= 0;        // speccy pixel counter
            leftborder <= 1'b1;
            if( v_counter == (TotalLines-1) )begin
              // new screen begin, reset all counters
              vscale <= 0;
              voffset <= 0;
              vcnt <= 0;
              topborder <= 1'b1;
              botborder <= 1'b0;
            end else begin                
                if( vscale == (Vscalefactor-1) )begin
                  vscale <= 0;
                   if( topborder == 1'b0 )begin
                       if( vcnt < (LinesMax-1) )begin
                           vcnt <= vcnt + 1'b1;
                       end else begin
                           botborder <= 1'b1;
                       end
                   end
                end else begin
                   vscale <= vscale + 1'b1;
                end
                
               if( voffset < VOffset_c )begin
                   voffset <= voffset + 1'b1;
               end else begin
                   topborder <= 1'b0;
               end    
            end

        end else begin
           if( hscale == (Hscalefactor-1) )begin
               hscale <= 0;
               if( leftborder == 1'b0 )begin
                   if( hcnt < (PixelMax + 7) )begin
                       hcnt <= hcnt + 1'b1;
                   end
               end
           end else begin
               hscale <= hscale + 1'b1;
           end
           
           if( hoffset < HOffset_c) begin
               hoffset <= hoffset + 1'b1;
           end else begin
               leftborder <= 1'b0;
           end
        end
end

always @(posedge clk_pixel )begin

  if( hscale == (Hscalefactor-1) )begin                  // wait for previos vid_dot finish
    case( hcnt[2:0] )
        3'b100: begin 
            vid_0_reg <= Vmem_data[7:0];    // b/w pixel data
		    vid_1_reg <= ~Vmem_data[10:8];    // color pixel data
            end
		3'b111: begin
			vid_b_reg <= vid_0_reg;
			vid_c_reg <= vid_1_reg;
			screen1 <= screen;
		end 
    endcase
  end
end

// enable video output
always @( posedge clk_pixel )begin
	if ( h_counter >= HOffset_c && h_counter < (HOffset_c + (PixelMax * Hscalefactor)) && v_counter > VOffset_c && v_counter <= (VOffset_c + (LinesMax * Vscalefactor)) ) begin
		screen <= 1'b1;
	end else begin
		screen <= 1'b0;
	end
end
// DE
always @(posedge clk_pixel )begin
    if( v_counter < ActiveLines )begin
//        KGI <= 1'b0;
        if( h_counter < ActivePixels )begin
            blank <= 1'b0;
        end else begin
            blank <= 1'b1;
        end
    end else begin
        blank <= 1'b1;
        if( v_counter < (ActiveLines + 100) )begin
//            KGI <= 1'b1;
        end else begin
//            KGI <= 1'b0;
        end
    end
end


wire vid_dot;
// use multipexor as pixel shift
assign vid_dot = 	( hcnt[2:0] == 3'b000) ? vid_b_reg[7] :
					( hcnt[2:0] == 3'b001) ? vid_b_reg[6] :
					( hcnt[2:0] == 3'b010) ? vid_b_reg[5] :
					( hcnt[2:0] == 3'b011) ? vid_b_reg[4] :
					( hcnt[2:0] == 3'b100) ? vid_b_reg[3] :
					( hcnt[2:0] == 3'b101) ? vid_b_reg[2] :
					( hcnt[2:0] == 3'b110) ? vid_b_reg[1] :
						vid_b_reg[0];

always @(posedge clk_pixel )begin
    if( blank == 1'b0 )begin
        if (screen1 == 1) begin
						r <= vid_dot ? vid_c_reg[2] : 1'b0;
						g <= vid_dot ? vid_c_reg[1] : 1'b0;
						b <= vid_dot ? vid_c_reg[0] : 1'b0;
						p <= vid_dot ? vid_c_reg[0] : 1'b0;
        end else begin  // border is black
						r <= 0;
						g <= 0;
						b <= 0; 
						p <= 1;
        end
    end else begin  // blank
						b <= 0;
						r <= 0;
						g <= 0;
						p <= 0;
    end
end
//--------------------------------------------------------------------------------------
    // HDMI output
    logic[2:0] tmds;

    hdmi #( .VIDEO_ID_CODE( 19 ),  // 1280x720@50Hz = 74.25mhZ, 371,25MHz
            .DVI_OUTPUT(0), 
            .VIDEO_REFRESH_RATE( 50.0 ),
            .IT_CONTENT(1),
            .AUDIO_RATE( 48000 ), 
            .AUDIO_BIT_WIDTH( 16 ),
            .START_X(0),
            .START_Y(0) )

    hdmi( .clk_pixel_x5( clk_pixel_x5 ), 
            .clk_pixel( clk_pixel ), 
            .clk_audio( clk_sound ),
            .rgb( {Rout, Gout, Bout} ), 
            .reset( reset_hdmi ),
            .audio_sample_word( {soundL, soundR} ),
            .tmds( tmds ), 
            .tmds_clock( tmdsClk ), 
            .cx( h_counter ), 
            .cy( v_counter ),
            .frame_width( TotalPixels ),
            .frame_height( TotalLines ),
            .screen_width( ActivePixels ),
            .screen_height( ActiveLines )
    );

    // Gowin LVDS output buffer
    ELVDS_OBUF tmds_bufds [3:0] (
        .I({clk_pixel, tmds}),
        .O({tmds_clk_p, tmds_d_p}),
        .OB({tmds_clk_n, tmds_d_n})
    );

//===================================================
wire CSD =   ~( cpu_ADDR[15:0] == 16'hF0B3 && !cpu_nWR );
wire CSC =   ~( cpu_ADDR[15:0] == 16'hF0BB && !cpu_nWR );
wire nCSDD = ~( cpu_ADDR[15:0] == 16'hF0B3 && cpu_RD );
wire CSF =   ~( cpu_ADDR[15:0] == 16'hF0BB && cpu_RD );

    CLOCK_DIV #( .CLK_SRC( 371.5 ), .CLK_DIV( 12.0 ), .PRECISION_BITS(16)
    ) clks (  .clk_src( clk_pixel_x5 ), .clk_div( clkU12mhz )    );
    BUFG clk_12m_inst(   .O( clk12mhz ),    .I( clkU12mhz )    );
/*
reg [4:0]cdiv;
reg cclk;
always @(posedge clk12mhz )begin
    if( cdiv == 1 ) cclk <= 1;
    else cclk <= 0;
    if( cdiv == 5 ) cdiv <= 0;
    else cdiv <= cdiv + 1;
end

    assign  cpu_clk = cclk;
    assign  clk2mhz = cpu_clk;
*/


gensnd snd(
    .clk12mhz( clk12mhz ),
    .rst( ~cpu_nRESET ),

    .MDI( sdramGS_DIN ),    // input
    .MDO( sdramGS_DOUT ),
    .MA( sdramGS_ADDR ),
    .MWR( GS_MWR ),
    .MRD( GS_MRD ),
    .MRF( GS_RF ),
    
    .data_in( o_cpu_data ),
    .data_out( o_gs_data ),
    .CSD( CSD ),
    .CSC( CSC ),
    .nCSDD( nCSDD ),
    .CSF( CSF ),
//    .dbg(dbg),

    .sndLeft( GSsoundL ),
    .sndRight( GSsoundR )
);
//===================================================



    assign dbg[0] = UART_RXD;//GS_MRD;
    assign dbg[1] = UART_TXD;//GS_MWR;
    assign dbg[2] = uart_rx_data_valid;//sdramBUSY;
    assign dbg[3] = uart_tx_data_valid;//sdramGS_DIN[0];
    assign dbg[4] = uart_tx_data_ready;
    assign dbg[5] = cpu_RD;
    assign dbg[6] = ~cpu_nWR;
    assign dbg[7] = 0;


endmodule