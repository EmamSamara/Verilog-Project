// ============================================================
// FILE: dff.v
// D Flip-Flop (positive edge triggered) — used by RCA multiplier
// ============================================================
module dff (
    output reg  q,
    input  wire d,
    input  wire clk
);
    always @(posedge clk) q <= d;
endmodule
