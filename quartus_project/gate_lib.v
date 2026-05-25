// ============================================================
// FILE: gate_lib.v
// DESCRIPTION: Basic gate library with delays for Student ID
//              ending in 2 (INV=3, NAND=3, NOR=4, AND=5,
//              OR=5, XOR=6, XNOR=7) in nanoseconds.
// ============================================================

`ifndef GATE_LIB_V
`define GATE_LIB_V

// ---------- INVERTER (delay = 3 ns) ----------
module INV (
    output wire y,
    input  wire a
);
    assign #3 y = ~a;
endmodule

// ---------- NAND (delay = 3 ns) ----------
module NAND2 (
    output wire y,
    input  wire a, b
);
    assign #3 y = ~(a & b);
endmodule

// ---------- NOR (delay = 4 ns) ----------
module NOR2 (
    output wire y,
    input  wire a, b
);
    assign #4 y = ~(a | b);
endmodule

// ---------- AND (delay = 5 ns) ----------
module AND2 (
    output wire y,
    input  wire a, b
);
    assign #5 y = a & b;
endmodule

// ---------- OR (delay = 5 ns) ----------
module OR2 (
    output wire y,
    input  wire a, b
);
    assign #5 y = a | b;
endmodule

// ---------- XOR (delay = 6 ns) ----------
module XOR2 (
    output wire y,
    input  wire a, b
);
    assign #6 y = a ^ b;
endmodule

// ---------- XNOR (delay = 7 ns) ----------
module XNOR2 (
    output wire y,
    input  wire a, b
);
    assign #7 y = ~(a ^ b);
endmodule

`endif // GATE_LIB_V
