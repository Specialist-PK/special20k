// A bridge controller connecting SDRAM to NES.
// The main function is to 2 read buffers (dout_a and dout_b) for CPU and PPU
// nand2mario, 2022.10
// 
// Memory layout:
// Total address space 4MB
module MemoryController(
    input clk,                // Main logic clock
    input clk_sdram,          // 180-degree of clk
    input resetn,
    input read_a,             // Set to 1 to read from RAM
    input read_b,             // Set to 1 to read from RAM
    input write_a,              // Set to 1 to write to RAM
    input write_b,
    input refresh,            // Set to 1 to auto-refresh RAM
    input [21:0]addr_a,        // Address to read / write
    input [21:0]addr_b,
    input [7:0] din_a,          // Data to write
    input [7:0] din_b,
    output [7:0] dout_a,      // Last read data a, available 4 cycles after read_a is set
    output [7:0] dout_b,      // Last read data b, available 4 cycles after read_b is set
    output reg busy,          // 1 while an operation is in progress

    // debug interface
    //output reg fail,          // timing mistake or sdram malfunction detected
    //output reg [19:0] total_written,

    // Physical SDRAM interface
	inout  [31:0] SDRAM_DQ,   // 16 bit bidirectional data bus
	output [10:0] SDRAM_A,    // 13 bit multiplexed address bus
	output [1:0] SDRAM_BA,   // 4 banks
	output SDRAM_nCS,  // a single chip select
	output SDRAM_nWE,  // write enable
	output SDRAM_nRAS, // row address select
	output SDRAM_nCAS, // columns address select
	output SDRAM_CLK,
	output SDRAM_CKE,
    output [3:0] SDRAM_DQM
);

parameter [3:0]   T_RC = 4'd9;      // 140MHz
//parameter [3:0]   T_RC = 4'd4;      // 66MHz


reg [22:0] MemAddr;
reg MemRD, MemWR, MemRefresh, MemInitializing;
reg [7:0] MemDin;
wire [7:0] MemDout;
reg [3:0] cycles;
reg r_read_a, r_read_b;
reg [7:0] da, db;
wire MemBusy, MemDataReady;

assign dout_a = (cycles == T_RC && r_read_a) ? MemDout : da;
assign dout_b = (cycles == T_RC && r_read_b) ? MemDout : db;


// SDRAM driver
sdram #(
//    .FREQ(FREQ)
) u_sdram (
    .clk( clk ), .clk_sdram( clk_sdram ), .resetn( resetn ),
	.addr( busy ? MemAddr : ( read_a || write_a ) ? {1'b0, addr_a} : {1'b0, addr_b}),
    .rd(busy ? MemRD : (read_a  || read_b) ), 
    .wr(busy ? MemWR : (write_a || write_b) ),
    .refresh(busy ? MemRefresh : refresh),
	.din(busy ? MemDin : write_a ? din_a : din_b ),
    .dout(MemDout), .busy(MemBusy), .data_ready(MemDataReady),

    .SDRAM_DQ(SDRAM_DQ), .SDRAM_A(SDRAM_A), .SDRAM_BA(SDRAM_BA), 
    .SDRAM_nCS(SDRAM_nCS), .SDRAM_nWE(SDRAM_nWE), .SDRAM_nRAS(SDRAM_nRAS),
    .SDRAM_nCAS(SDRAM_nCAS), .SDRAM_CLK(SDRAM_CLK), .SDRAM_CKE(SDRAM_CKE),
    .SDRAM_DQM(SDRAM_DQM)
);

always @( posedge clk )begin
    MemWR <= 1'b0; MemRD <= 1'b0; MemRefresh <= 1'b0;
    //cycles <= cycles == 3'd7 ? 3'd7 : cycles + 3'd1;
    if( cycles <= 9) cycles <= cycles + 4'd1;
    
    // Initiate read or write
    if( !busy )begin
        if( read_a || read_b || write_a || write_b || refresh) begin
            if( read_a || write_a ) MemAddr <= {1'b0, addr_a};
            else                    MemAddr <= {1'b0, addr_b};
            MemWR <= ( write_a || write_b );
            MemRD <= ( read_a || read_b );
            MemRefresh <= refresh;
            busy <= 1'b1;
            if( write_a )   MemDin <= din_a;
            else            MemDin <= din_b;
            cycles <= 3'd1;
            r_read_a <= read_a;
            r_read_b <= read_b;

        end 
    end else if( MemInitializing )begin
        if( ~MemBusy )begin            // initialization is done
            MemInitializing <= 1'b0;
            busy <= 1'b0;
        end
    end else begin
        // Wait for operation to finish and latch incoming data on read.
        //if( cycles == T_RC )begin
        if( !MemBusy )begin
            busy <= 0;
            if( r_read_a || r_read_b )begin
//                if (~MemDataReady)      // assert data ready
//                    fail <= 1'b1;
                if( r_read_a ) da <= MemDout;
                if( r_read_b ) db <= MemDout;
                r_read_a <= 1'b0;
                r_read_b <= 1'b0;
            end
        end
    end

    if( ~resetn )begin
        busy <= 1'b1;
        MemInitializing <= 1'b1;
    end
end

endmodule
