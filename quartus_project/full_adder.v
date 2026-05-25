`ifndef GATE_LIB_V
`define GATE_LIB_V
module INV  (output wire y, input wire a);           assign #3 y = ~a;       endmodule
module NAND2(output wire y, input wire a, b);         assign #3 y = ~(a & b); endmodule
module NOR2 (output wire y, input wire a, b);         assign #4 y = ~(a | b); endmodule
module AND2 (output wire y, input wire a, b);         assign #5 y = a & b;    endmodule
module OR2  (output wire y, input wire a, b);         assign #5 y = a | b;    endmodule
module XOR2 (output wire y, input wire a, b);         assign #6 y = a ^ b;    endmodule
module XNOR2(output wire y, input wire a, b);         assign #7 y = ~(a ^ b); endmodule
`endif

module full_adder (
    output wire sum, cout,
    input  wire a, b, cin
);
    wire axb, ab, bcin, acin, carry_or1;
    XOR2 xor1(.y(axb),       .a(a),   .b(b));
    XOR2 xor2(.y(sum),       .a(axb), .b(cin));
    AND2 and1(.y(ab),        .a(a),   .b(b));
    AND2 and2(.y(bcin),      .a(b),   .b(cin));
    AND2 and3(.y(acin),      .a(a),   .b(cin));
    OR2  or1 (.y(carry_or1), .a(ab),        .b(bcin));
    OR2  or2 (.y(cout),      .a(carry_or1), .b(acin));
endmodule
