// ====================================================================
//                Bashkiria-2M FPGA REPLICA
//
//            Copyright (C) 2010 Dmitry Tselikov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// An open implementation of Bashkiria-2M home computer
//
// Author: Dmitry Tselikov   http://bashkiria-2m.narod.ru/
// 
// Design File: b2m_kbd.v
//
// Keyboard interface design file of Bashkiria-2M replica.

module b2m_kbd(
	input clk,
	input reset,
	input ps2_clk,
	input ps2_dat,

    output  reg[5:0]KeyMap0,
    output  reg[5:0]KeyMap1,
    output  reg[5:0]KeyMap2,
    output  reg[5:0]KeyMap3,
    output  reg[5:0]KeyMap4,
    output  reg[5:0]KeyMap5,
    output  reg[5:0]KeyMap6,
    output  reg[5:0]KeyMap7,
    output  reg[5:0]KeyMap8,
    output  reg[5:0]KeyMap9,
    output  reg[5:0]KeyMap10,
    output  reg[5:0]KeyMap11,
    output  reg[5:0]Func            // x, x, x, x, reset, shift
);

reg extkey;
reg press_release;
reg[3:0] prev_clk;
reg[11:0] shift_reg;

wire[11:0] kdata = {ps2_dat,shift_reg[11:1]};
wire[7:0] kcode = kdata[9:2];

wire shift = Func[0];
reg rus, ctrl, alt;


/*
always begin

	8'h4E: {c,r} <= 7'h74; // -
	8'h41: {c,r} <= 7'h05; // ,
	8'h4C: {c,r} <= 7'h15; // ;
	8'h55: {c,r} <= 7'h25; // =
	8'h0E: {c,r} <= 7'h35; // `
	8'h5D: {c,r} <= 7'h55; // \!
	8'h45: {c,r} <= 7'h65; // 0
	8'h16: {c,r} <= 7'h45; // 1
	8'h1E: {c,r} <= 7'h64; // 2
	8'h26: {c,r} <= 7'h54; // 3
	8'h25: {c,r} <= 7'h44; // 4
	8'h2E: {c,r} <= 7'h34; // 5
	8'h36: {c,r} <= 7'h24; // 6
	8'h3D: {c,r} <= 7'h14; // 7
	8'h3E: {c,r} <= 7'h04; // 8
	8'h46: {c,r} <= 7'h75; // 9
	8'h1C: {c,r} <= 7'h10; // A
	8'h32: {c,r} <= 7'h61; // B
	8'h21: {c,r} <= 7'h42; // C
	8'h23: {c,r} <= 7'h02; // D
	8'h24: {c,r} <= 7'h22; // E
	8'h2B: {c,r} <= 7'h60; // F
	8'h34: {c,r} <= 7'h72; // G
	8'h33: {c,r} <= 7'h52; // H
	8'h43: {c,r} <= 7'h43; // I
	8'h3B: {c,r} <= 7'h01; // J
	8'h42: {c,r} <= 7'h31; // K
	8'h4B: {c,r} <= 7'h30; // L
	8'h3A: {c,r} <= 7'h73; // M
	8'h31: {c,r} <= 7'h32; // N
	8'h44: {c,r} <= 7'h23; // O
	8'h4D: {c,r} <= 7'h53; // P
	8'h15: {c,r} <= 7'h51; // Q
	8'h2D: {c,r} <= 7'h41; // R
	8'h1B: {c,r} <= 7'h63; // S
	8'h2C: {c,r} <= 7'h20; // T
	8'h3C: {c,r} <= 7'h00; // U
	8'h2A: {c,r} <= 7'h21; // V
	8'h1D: {c,r} <= 7'h40; // W
	8'h22: {c,r} <= 7'h13; // X
	8'h35: {c,r} <= 7'h11; // Y
	8'h1A: {c,r} <= 7'h62; // Z
	8'h54: {c,r} <= 7'h71; // [
	8'h5B: {c,r} <= 7'h03; // ]
	8'h0B: {c,r} <= 7'h50; // F6
	8'h83: {c,r} <= 7'h70; // F7
	8'h0A: {c,r} <= 7'h12; // F8
	8'h01: {c,r} <= 7'h33; // F9
	8'h29: {c,r} <= 7'h06; // space
	8'h0D: {c,r} <= 7'h16; // tab
	8'h66: {c,r} <= 7'h26; // bksp
	8'h7C: {c,r} <= 7'h46; // gray*
	8'h07: {c,r} <= 7'h56; // F12 - stop
	8'h7B: {c,r} <= 7'h66; // gray-
	8'h76: {c,r} <= 7'h47; // esc
	8'h78: {c,r} <= 7'h67; // F11 - rus
	8'h6C: {c,r} <= 7'h08; // 7 home
	8'h74: {c,r} <= 7'h18; // 6 right
	8'h73: {c,r} <= 7'h28; // 5 center
	8'h6B: {c,r} <= 7'h38; // 4 left
	8'h7A: {c,r} <= 7'h48; // 3 pgdn
	8'h72: {c,r} <= 7'h58; // 2 down
	8'h69: {c,r} <= 7'h68; // 1 end
	8'h70: {c,r} <= 7'h78; // 0 ins
	8'h4A: {c,r} <= extkey ? 7'h36 : 7'h09; // gray/ + /
	8'h71: {c,r} <= 7'h19; // . del
	8'h52: {c,r} <= 7'h29; // '
	8'h49: {c,r} <= 7'h39; // .
	8'h7D: {c,r} <= 7'h69; // 9 pgup
	8'h75: {c,r} <= 7'h79; // 8 up
	8'h06: {c,r} <= 7'h6A; // F2
	8'h04: {c,r} <= 7'h5A; // F3
	8'h0C: {c,r} <= 7'h4A; // F4
	8'h03: {c,r} <= 7'h3A; // F5
	default: {c,r} <= 7'h7F;
	endcase
end*/

always @(posedge clk or posedge reset) begin
	if (reset) begin
		prev_clk <= 0;
		shift_reg <= 12'hFFF;
		extkey <= 0;
		press_release <= 0;
        KeyMap0 <= 6'b111111;
        KeyMap1 <= 6'b111111;
        KeyMap2 <= 6'b111111;
        KeyMap3 <= 6'b111111;
        KeyMap4 <= 6'b111111;
        KeyMap5 <= 6'b111111;
        KeyMap6 <= 6'b111111;
        KeyMap7 <= 6'b111111;
        KeyMap8 <= 6'b111111;
        KeyMap9 <= 6'b111111;
        KeyMap10 <= 6'b111111;
        KeyMap11 <= 6'b111111;
		Func <= 6'b000000;
        rus <= 0;
        ctrl <= 0;
        alt <= 0;
	end else begin
		prev_clk <= {ps2_clk,prev_clk[3:1]};
		if( prev_clk == 4'b1 )begin
			if( kdata[11] == 1'b1 && ^kdata[10:2] == 1'b1 && kdata[1:0] == 2'b1 )begin
				shift_reg <= 12'hFFF;
				if( kcode == 8'hE0 ) extkey <= 1'b1; else
				if( kcode == 8'hF0 ) press_release <= 1'b1; else
				begin
					extkey <= 0;
					press_release <= 0;
					//if( r != 4'hF ) keystate[r][c] <= ~unpress;
    //------------------------------------------------
	case (kcode)
	8'h12, 8'h59: begin // lshift, rshift
                                Func[0] <= ~press_release;             // Shift
                                if( alt )begin
                                    KeyMap11[0] <= press_release;       // RUS/LAT
                                    if( press_release ) rus <= ~rus;
                                end
    end
    8'h11:begin if( shift )begin                 // lAlt
                                KeyMap11[0] <= press_release;       // RUS/LAT
                                if( press_release ) rus <= ~rus;
                            end
                                alt <= ~press_release;
    end
    8'h14: ctrl <= ~press_release; // rctrl + lctrl
    8'h71:	begin if( ctrl && alt ) Func[1]<=~press_release; end // del

    8'h07:	KeyMap0[5] <= press_release; // F12
    8'h78:	KeyMap1[5] <= press_release; // F11
    8'h09:	KeyMap2[5] <= press_release; // F10
    8'h01:	KeyMap3[5] <= press_release; // F9
    8'h0a:	KeyMap4[5] <= press_release; // F8
    8'h83:	KeyMap5[5] <= press_release; // F7
    8'h0b:	KeyMap6[5] <= press_release; // F6
    8'h03:	KeyMap7[5] <= press_release; // F5
    8'h0c:	KeyMap8[5] <= press_release; // F4
    8'h04:	KeyMap9[5] <= press_release; // F3
    8'h06:	KeyMap10[5]<= press_release; // F2
	8'h05:  KeyMap11[5]<= press_release; // F1

    8'h16: KeyMap10[4] <= press_release;  // !1
    8'h1e: if( shift ) KeyMap3[1] <= press_release; else KeyMap9[4] <= press_release;  // @2
    8'h26: KeyMap8[4] <= press_release;  // #3
    8'h25: KeyMap7[4] <= press_release;  // $4
    8'h2e: KeyMap6[4] <= press_release;  // %5
    8'h36: //begin if( shift )begin
                            //Func[0] <= 1'b0;    // remove shift
                            //KeyMap10[1] <= press_release;// ^
                        //end else
                            KeyMap5[4] <= press_release; // 6
                        //end
    8'h3d: if( shift )KeyMap5[4] <= press_release; else KeyMap4[4] <= press_release;  // &7
    8'h3e: if( shift )KeyMap0[3] <= press_release; else KeyMap3[4] <= press_release;  // *8
    8'h46: if( shift )KeyMap3[4] <= press_release; else KeyMap2[4] <= press_release;  // (9
    8'h45: if( shift )KeyMap2[4] <= press_release; else KeyMap1[4] <= press_release;  // )0

    8'h1C:  if(rus)KeyMap11[2]<=press_release;else KeyMap8[2]<=press_release;  // фA
    8'h32:  if(rus)KeyMap7[1]<=press_release;else KeyMap4[1]<=press_release;   // иB
    8'h21:  if(rus)KeyMap9[1]<=press_release;else KeyMap10[3]<=press_release;  // сC
    8'h23:  if(rus)KeyMap9[2]<=press_release;else KeyMap3[2]<=press_release;   // вD
    8'h24:  if(rus)KeyMap9[3]<=press_release;else KeyMap7[3]<=press_release;   // уE
    8'h2b:  if(rus)KeyMap8[2]<=press_release;else KeyMap11[2]<=press_release;  // аF
    8'h34:  if(rus)KeyMap7[2]<=press_release;else KeyMap5[3]<=press_release;   // пG
    8'h33:  if(rus)KeyMap6[2]<=press_release;else KeyMap1[3]<=press_release;   // рH
    8'h43:  if(rus)KeyMap4[3]<=press_release;else KeyMap7[1]<=press_release;   // шI
    8'h3B:  if(rus)KeyMap5[2]<=press_release;else KeyMap11[3]<=press_release;  // оJ
    8'h42:  if(rus)KeyMap4[2]<=press_release;else KeyMap8[3]<=press_release;   // лK
    8'h4B:  if(rus)KeyMap3[2]<=press_release;else KeyMap4[2]<=press_release;   // дL

    8'h3A:  if(rus)KeyMap5[1]<=press_release;else KeyMap8[1]<=press_release;   // ьM
    8'h31:  if(rus)KeyMap6[1]<=press_release;else KeyMap6[3]<=press_release;   // тN
    8'h44:  if(rus)KeyMap3[3]<=press_release;else KeyMap5[2]<=press_release;   // щO
    8'h4D:  if(rus)KeyMap2[3]<=press_release;else KeyMap7[2]<=press_release;   // зP
    8'h15:  if(rus)KeyMap11[3]<=press_release;else KeyMap11[1]<=press_release; // йQ
    8'h2D:  if(rus)KeyMap8[3]<=press_release;else KeyMap6[2]<=press_release;   // кR
    8'h1B:  if(rus)KeyMap10[2]<=press_release;else KeyMap9[1]<=press_release;  // ыS
    8'h2C:  if(rus)KeyMap7[3]<=press_release;else KeyMap6[1]<=press_release;   // еT
    8'h3C:  if(rus)KeyMap5[3]<=press_release;else KeyMap9[3]<=press_release;   // гU
    8'h2A:  if(rus)KeyMap8[1]<=press_release;else KeyMap2[2]<=press_release;   // мV
    8'h1D:  if(rus)KeyMap10[3]<=press_release;else KeyMap9[2]<=press_release;  // цW
    8'h22:  if(rus)KeyMap10[1]<=press_release;else KeyMap5[1]<=press_release;  // чX
    8'h35:  if(rus)KeyMap6[3]<=press_release;else KeyMap10[2]<=press_release;  // нY
    8'h1A:  if(rus)KeyMap11[1]<=press_release;else KeyMap2[3]<=press_release;  // яZ

                8'h55:  if(shift)KeyMap11[4] <= press_release;else KeyMap0[4]<=press_release;  // pc =+ sp =*
                8'h4C:  if(rus)KeyMap2[2]<=press_release;else if(shift)begin Func[0] <= press_release;KeyMap0[3]<=press_release;end else KeyMap11[4] <= press_release;  // pc ;: sp ж;
                8'h4E:  KeyMap0[4] <= press_release;  // pc -_ sp -
                8'h52:  KeyMap1[2]<=press_release;  // э
                8'h41:  if(rus)KeyMap4[1]<=press_release;else KeyMap2[1] <= press_release;  // pc <, sp б
                8'h49:  if(rus)KeyMap3[1]<=press_release;else KeyMap0[2] <= press_release;  // pc >. sp ю
                8'h5D:  KeyMap1[2]<=press_release;  // |
                8'h4A:  KeyMap1[1]<=press_release;  // ?
                8'h54:  if(rus)KeyMap1[3]<=press_release;else KeyMap4[3] <= press_release;  // pc [ sp х
                8'h5B:  if(rus)KeyMap5[1]<=press_release;else KeyMap3[3] <= press_release;  // pc ] sp ъ

    8'h29:	KeyMap5[0]	<= press_release; // Space
	8'h5A: KeyMap0[0] <= press_release; //Enter
                8'h66:  KeyMap0[1] <= press_release;  // bsps - ЗБ
                8'h0D:  KeyMap3[0] <= press_release;  // tab - ПВ
                8'h74:  KeyMap2[0] <= press_release;  // right arrow
                8'h6B:  KeyMap4[0] <= press_release;  // left arrow
                8'h72:  KeyMap8[0] <= press_release;  // down arrow
                8'h75:  KeyMap9[0] <= press_release;  // up arrow
                8'h6C:  KeyMap10[0] <= press_release;  // home
                8'h69:  KeyMap1[0] <= press_release;  // end - ПС


	endcase
    //------------------------------------------------
				end
			end else
				shift_reg <= kdata;
		end
	end
end

endmodule
