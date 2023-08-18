`timescale	1ns / 1ns


module	test;

reg		sys_clk;
reg		sys_rst;

// toggle clk every 40ns
always
	begin
		sys_clk=1'b1;
		#40;
		sys_clk=1'b0;
		#40;
	end

// stimulus
initial
	begin
		$dumpfile ("test.vcd");
		$dumpvars (0, test);

		// initialize
		sys_rst=1'b0;

//		// run
//		repeat (256)
//			@(posedge sys_clk);

		// user reset
		sys_rst=1'b1;
		repeat (4)
			@(posedge sys_clk);
		sys_rst=1'b0;
		// run
		repeat (256)
			@(posedge sys_clk);

		// finish
		$finish;
	end

// DUT
blinkv	top (
	.sys_clk(sys_clk),
	.sys_rst(sys_rst),
	.led_drv_0(led_drv_0),
	.led_drv_1(led_drv_1),
	.led_drv_r(led_drv_r),
	.led_drv_g(led_drv_g),
	.led_drv_b(led_drv_b)
);

endmodule

