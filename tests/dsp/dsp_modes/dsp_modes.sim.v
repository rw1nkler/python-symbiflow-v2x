/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "../dsp_combinational/dsp_combinational.sim.v"
`include "../dsp_inout_registered/dsp_inout_registered.sim.v"
`include "../dsp_in_registered/dsp_in_registered.sim.v"
`include "../dsp_out_registered/dsp_out_registered.sim.v"
`include "../dsp_partial_registered/dsp_partial_registered.sim.v"

/* DSP Block with register on both the inputs and the output */
(* MODES="REGISTERED_NONE; REGISTERED_IN; REGISTERED_OUT; REGISTERED_INOUT; REGISTERED_PARTIAL" *)
module DSP_MODES (clk, a, b, m, out);
	localparam DATA_WIDTH = 4;

	parameter MODE = "REGISTERED_INOUT";

	input wire clk;
	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;
	output wire [DATA_WIDTH-1:0] out;

	/* Register modes */
	generate
		if (MODE == "REGISTERED_NONE") begin
			DSP_COMBINATIONAL dsp_int_comb (.a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_INOUT") begin
			DSP_INOUT_REGISTERED dsp_int_regio (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_IN") begin
			DSP_IN_REGISTERED dsp_int_regi (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_OUT") begin
			DSP_OUT_REGISTERED dsp_int_rego (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_PARTIAL") begin
			DSP_PARTIAL_REGISTERED dsp_int_part (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end
	endgenerate
endmodule
