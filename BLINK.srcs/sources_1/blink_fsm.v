module	blink_fsm (
	clk,
	rst_n,
	OVF,
	LED_BUILTIN,
	TPRD);
// Table to Verilog-HDL converter ver.1.02 w/ Olive+
// https://hello.world.coocan.jp/ARDUINO15/arduino15_2.html#TAB2V

input	clk;
input	rst_n;
input	OVF;
output	LED_BUILTIN;
output	[23:0]	TPRD;


// state code
parameter	[1:0]	T0=2'h0;
parameter	[1:0]	T1=2'h1;
parameter	[1:0]	T2=2'h2;
parameter	[1:0]	T3=2'h3;
// timer period
//`define		SIMULATION
`ifdef		SIMULATION
parameter	[23:0]	TPRD_S=24'd15 - 24'd1;
parameter	[23:0]	TPRD_L=24'd55 - 24'd1;
`else	//	SIMULATION
//parameter	[23:0]	F_CLK_KHZ=24'd24_000;	// fclk=24MHz (for Tang Primer board)
parameter	[23:0]	F_CLK_KHZ=24'd12_000;	// fclk=12MHz (for Cmod A7 board)
parameter	[23:0]	TPRD_S=24'd150*F_CLK_KHZ - 24'h1;	// 150ms for fclk
parameter	[23:0]	TPRD_L=24'd550*F_CLK_KHZ - 24'h1;	// 550ms for fclk
`endif	//	SIMULATION

reg		[1:0]	STAT;
reg		[1:0]	NEXT;
reg		LED_BUILTIN;
reg		LED_BUILTIN_t;
reg		[23:0]	TPRD;

always	@(STAT[1:0] or OVF)
	begin
		casez ({ STAT[1:0],OVF })
`define	COUT	{ NEXT[1:0],LED_BUILTIN_t,TPRD[23:0] }
		{ T0,1'b0 }: `COUT={ T0,1'b0,TPRD_S };	// LED on 150ms
		{ T0,1'b1 }: `COUT={ T1,1'b1,TPRD_S };	// got overflow, move to T1
		{ T1,1'b0 }: `COUT={ T1,1'b1,TPRD_S };	// LED off 150ms
		{ T1,1'b1 }: `COUT={ T2,1'b0,TPRD_S };	// got overflow, move to T2
		{ T2,1'b0 }: `COUT={ T2,1'b0,TPRD_S };	// LED on 150ms
		{ T2,1'b1 }: `COUT={ T3,1'b1,TPRD_L };	// got overflow, move to T3
		{ T3,1'b0 }: `COUT={ T3,1'b1,TPRD_L };	// LED off 550ms
		{ T3,1'b1 }: `COUT={ T0,1'b0,TPRD_S };	// got overflow, move to T0
		default: `COUT={ T0,1'b0,TPRD_S };
`undef	COUT
		endcase
	end

always	@(posedge clk)
	begin
		if (!rst_n)
			LED_BUILTIN<=1'b1;
		else
			LED_BUILTIN<=LED_BUILTIN_t;
	end

always	@(posedge clk)
	begin
		if (!rst_n)
			STAT[1:0]<=T0;
		else
			STAT[1:0]<=NEXT[1:0];
	end

endmodule
