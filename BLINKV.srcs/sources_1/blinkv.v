module	blinkv (
	sys_clk,
	sys_rst,
	led_drv_0,
	led_drv_1,
	led_drv_r,
	led_drv_g,
	led_drv_b);

// blink on-board LED for Cmod A7
input	sys_clk;
input	sys_rst;
output	led_drv_0;
output	led_drv_1;
output	led_drv_r;
output	led_drv_g;
output	led_drv_b;


wire	clk=sys_clk;
wire	rst_n=~sys_rst;
wire	[23:0]	TPRD;
assign	led_drv_0=~LED_BUILTIN;
assign	led_drv_1=~LED_BUILTIN;
assign	led_drv_r=LED_BUILTIN | 1'b1;
assign	led_drv_g=LED_BUILTIN | 1'b1;
assign	led_drv_b=LED_BUILTIN | 1'b1;


blinkv_fsm	fsm (
	.clk(clk),	// Input
	.rst_n(rst_n),	// Input
	.OVF(OVF),	// Input
	.LED_BUILTIN(LED_BUILTIN),	// Output
	.TPRD(TPRD[23:0])	// Output
);

blinkv_tim	tim (
	.clk(clk),	// Input
	.rst_n(rst_n),	// Input
	.TPRD(TPRD[23:0]),	// Input
	.OVF(OVF)	// Output
);

endmodule


module	blinkv_tim (
	clk,
	rst_n,
	TPRD,
	OVF);

// timer
input	clk;
input	rst_n;
input	[23:0]	TPRD;
output	OVF;


reg		[23:0]	cnt;
reg		OVF;

always	@(posedge clk)
	begin
		if (!rst_n)
			begin
				cnt[23:0]<=24'h0;
				OVF<=1'b0;
			end
		else if (cnt[23:0]==TPRD[23:0])
			begin
				cnt[23:0]<=24'h0;
				OVF<=1'b1;
			end
		else
			begin
				cnt[23:0]<=cnt[23:0] + 24'h1;
				OVF<=1'b0;
			end
	end

endmodule

