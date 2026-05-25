// ============================================================
// FILE: full_adder_buggy.v
// Intentional bug: XNOR instead of AND in carry computation
// ============================================================
module full_adder_buggy (
    output wire sum, cout,
    input  wire a, b, cin
);
    wire axb, ab_wrong, bcin, acin, carry_or1;
    XOR2  xor1    (.y(axb),       .a(a),        .b(b));
    XOR2  xor2    (.y(sum),       .a(axb),      .b(cin));
    XNOR2 bug_gate(.y(ab_wrong),  .a(a),        .b(b));   // BUG: should be AND2
    AND2  and2    (.y(bcin),      .a(b),        .b(cin));
    AND2  and3    (.y(acin),      .a(a),        .b(cin));
    OR2   or1     (.y(carry_or1), .a(ab_wrong), .b(bcin));
    OR2   or2     (.y(cout),      .a(carry_or1),.b(acin));
endmodule
