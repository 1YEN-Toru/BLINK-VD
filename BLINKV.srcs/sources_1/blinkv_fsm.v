module	blinkv_fsm (
	clk,
	rst_n,
	OVF,
	LED_BUILTIN,
	TPRD);
// This module was converted by tab2v.olv w/ Olive+
// http://hello.world.coocan.jp/ARDUINO/index.html

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
`ifdef		SIMULATION
parameter	[23:0]	TPRD_S=24'd15 - 24'd1;
parameter	[23:0]	TPRD_L=24'd55 - 24'd1;
`else	//	SIMULATION
parameter	[23:0]	F_CLK_KHZ=24'd12_000;	// fclk=12MHz
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
		casex ({ STAT[1:0],OVF })
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
