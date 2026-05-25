module rca_4bit (
    output wire [3:0] sum,
    output wire       cout,
    input  wire [3:0] a, b,
    input  wire       cin
);
    wire c1, c2, c3;
    full_adder fa0(.sum(sum[0]),.cout(c1),  .a(a[0]),.b(b[0]),.cin(cin));
    full_adder fa1(.sum(sum[1]),.cout(c2),  .a(a[1]),.b(b[1]),.cin(c1));
    full_adder fa2(.sum(sum[2]),.cout(c3),  .a(a[2]),.b(b[2]),.cin(c2));
    full_adder fa3(.sum(sum[3]),.cout(cout),.a(a[3]),.b(b[3]),.cin(c3));
endmodule
