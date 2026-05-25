// ============================================================
// FILE: dff_cla.v
// D Flip-Flop (positive edge triggered) — used by CLA multiplier
// ============================================================
module dff_cla (
    output reg  q,
    input  wire d,
    input  wire clk
);
    always @(posedge clk) q <= d;
endmodule
