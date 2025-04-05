module MemoryController(
    input clk,                // Main logic clock
    input clkp,                // Main logic clock
    input resetn,
    input RD,             // Set to 1 to read from RAM
    input WR,              // Set to 1 to write to RAM
    input [20:0] addr,        // Address to read / write
    input [7:0] din,          // Data to write
    output reg [7:0] dout,      // Last read data a, available 4 cycles after read_a is set
    input   RFSH,
    output BUSY,          // 1 while an operation is in progress
//    output [7:0]dbg,
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

parameter   init = 0;
parameter   idle = 1;
parameter   read = 2;
parameter   write = 3;
parameter   refresh = 4;

reg [22:0] sdr_addr;
reg sdr_rd, sdr_wr, sdr_refresh;
reg [7:0] sdr_din;
wire [7:0] sdr_dout;
wire [31:0] sdr_dout32;
reg [2:0] cycles;
wire sdr_data_ready, sdr_busy;
reg [2:0]state;

/*
assign dbg[0] = RD;
assign dbg[1] = sdr_rd;
assign dbg[2] = WR;
assign dbg[3] = state[0];
assign dbg[4] = state[1];
assign dbg[5] = sdr_dout[1];
assign dbg[6] = sdr_busy;
assign dbg[7] = sdr_data_ready;
*/

// SDRAM driver
sdram #(
//    .FREQ( 140_000_000 )
) u_sdram (
    .clk( clk ), .clk_sdram( clkp ), .resetn( resetn ),
	.addr( sdr_addr ),
    .rd( sdr_rd ), .wr( sdr_wr ), .refresh( sdr_refresh ),
	.din( sdr_din ), .dout( sdr_dout ), .dout32( sdr_dout32 ),
    .busy( sdr_busy ), .data_ready( sdr_data_ready ),

    .SDRAM_DQ(SDRAM_DQ), .SDRAM_A(SDRAM_A), .SDRAM_BA(SDRAM_BA), 
    .SDRAM_nCS(SDRAM_nCS), .SDRAM_nWE(SDRAM_nWE), .SDRAM_nRAS(SDRAM_nRAS),
    .SDRAM_nCAS(SDRAM_nCAS), .SDRAM_CLK(SDRAM_CLK), .SDRAM_CKE(SDRAM_CKE),
    .SDRAM_DQM(SDRAM_DQM)
);

assign  BUSY        = sdr_busy;

always @( posedge clk or negedge resetn )begin
    if( !resetn )begin
        state <= init;
        sdr_wr <= 1'b0; 
        sdr_rd <= 1'b0;
        sdr_refresh <= 1'b0;
    end else begin
        case( state )
        init: begin
            if( !sdr_busy ) state <= idle;
            end
        idle: begin
                if( WR )begin
                    state <= write;
                    sdr_addr <= {2'b00, addr};
                    sdr_din <= din;
					sdr_wr <= 1'b1;
                end else
                if( RD )begin
                    state <= read;
                    sdr_addr <= {2'b00, addr};
                    sdr_rd <= 1'b1;
				end else
                if( RFSH ) begin 
					state <= refresh;
					sdr_addr <= {2'b00, addr};
					sdr_refresh <= 1'b1;
                end
            end
        read: begin
                sdr_rd <= 1'b0;
                if( sdr_data_ready )begin
                //if( !sdr_busy )begin
					dout <= sdr_dout;
					state <= idle;
                end
            end
        write: begin
				sdr_wr <= 1'b0;
                if( !sdr_busy )
                    state <= idle;
            end
        refresh: begin
				sdr_refresh <= 1'b0;
                if( !sdr_busy )
                    state <= idle;
            end
        endcase
    end
end

endmodule