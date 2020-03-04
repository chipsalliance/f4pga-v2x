/*
 * `input wire a` should be detected as a clock because it drives the flip
 * flop. However, it has the attribute CLOCK set to 0 which should force it
 * to be a regular input.
 */
module BLOCK(a, b, c);
    (* CLOCK=0 *)
	input wire a;
	input wire b;
	output wire c;

	reg r;
	always @ ( posedge a ) begin
		r <= b;
	end
	assign c = r;
endmodule
