module cla_4bit (
    output wire [3:0] sum,
    output wire       cout,
    input  wire [3:0] a, b,
    input  wire       cin
);
    wire [3:0] G, P;
    AND2 gand0(.y(G[0]),.a(a[0]),.b(b[0])); AND2 gand1(.y(G[1]),.a(a[1]),.b(b[1]));
    AND2 gand2(.y(G[2]),.a(a[2]),.b(b[2])); AND2 gand3(.y(G[3]),.a(a[3]),.b(b[3]));
    XOR2 pxor0(.y(P[0]),.a(a[0]),.b(b[0])); XOR2 pxor1(.y(P[1]),.a(a[1]),.b(b[1]));
    XOR2 pxor2(.y(P[2]),.a(a[2]),.b(b[2])); XOR2 pxor3(.y(P[3]),.a(a[3]),.b(b[3]));

    wire p0cin, C1;
    AND2 c1a0(.y(p0cin),.a(P[0]),.b(cin));
    OR2  c1o0(.y(C1),   .a(G[0]),.b(p0cin));

    wire p1g0, p1p0cin, c2_or1, C2;
    AND2 c2a0(.y(p1g0),   .a(P[1]),.b(G[0]));
    AND2 c2a1(.y(p1p0cin),.a(P[1]),.b(p0cin));
    OR2  c2o0(.y(c2_or1), .a(G[1]),   .b(p1g0));
    OR2  c2o1(.y(C2),     .a(c2_or1), .b(p1p0cin));

    wire p2g1, p2p1g0, p2p1p0cin, c3_or1, c3_or2, C3;
    AND2 c3a0(.y(p2g1),     .a(P[2]),.b(G[1]));
    AND2 c3a1(.y(p2p1g0),   .a(P[2]),.b(p1g0));
    AND2 c3a2(.y(p2p1p0cin),.a(P[2]),.b(p1p0cin));
    OR2  c3o0(.y(c3_or1),.a(G[2]),   .b(p2g1));
    OR2  c3o1(.y(c3_or2),.a(c3_or1), .b(p2p1g0));
    OR2  c3o2(.y(C3),    .a(c3_or2), .b(p2p1p0cin));

    wire p3g2, p3p2g1, p3p2p1g0, p3p2p1p0cin, c4_or1, c4_or2, c4_or3;
    AND2 c4a0(.y(p3g2),        .a(P[3]),.b(G[2]));
    AND2 c4a1(.y(p3p2g1),      .a(P[3]),.b(p2g1));
    AND2 c4a2(.y(p3p2p1g0),    .a(P[3]),.b(p2p1g0));
    AND2 c4a3(.y(p3p2p1p0cin), .a(P[3]),.b(p2p1p0cin));
    OR2  c4o0(.y(c4_or1),.a(G[3]),   .b(p3g2));
    OR2  c4o1(.y(c4_or2),.a(c4_or1), .b(p3p2g1));
    OR2  c4o2(.y(c4_or3),.a(c4_or2), .b(p3p2p1g0));
    OR2  c4o3(.y(cout),  .a(c4_or3), .b(p3p2p1p0cin));

    XOR2 sxor0(.y(sum[0]),.a(P[0]),.b(cin));
    XOR2 sxor1(.y(sum[1]),.a(P[1]),.b(C1));
    XOR2 sxor2(.y(sum[2]),.a(P[2]),.b(C2));
    XOR2 sxor3(.y(sum[3]),.a(P[3]),.b(C3));
endmodule
