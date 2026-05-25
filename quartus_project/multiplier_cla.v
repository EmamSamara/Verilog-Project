// ============================================================
// FILE: multiplier_cla.v  —  Stage 2: CLA Multiplier
// 4-bit x 8-bit unsigned multiplier, result = 12 bits
// Max latency ≈ 143 ns  |  Max Fclk ≈ 6.99 MHz
// ============================================================
module multiplier_cla (
    output wire [11:0] res,
    input  wire [3:0]  x,
    input  wire [7:0]  y,
    input  wire        clk
);
    wire [3:0] xr; wire [7:0] yr;
    dff_cla dff_x0(.q(xr[0]),.d(x[0]),.clk(clk)); dff_cla dff_x1(.q(xr[1]),.d(x[1]),.clk(clk));
    dff_cla dff_x2(.q(xr[2]),.d(x[2]),.clk(clk)); dff_cla dff_x3(.q(xr[3]),.d(x[3]),.clk(clk));
    dff_cla dff_y0(.q(yr[0]),.d(y[0]),.clk(clk)); dff_cla dff_y1(.q(yr[1]),.d(y[1]),.clk(clk));
    dff_cla dff_y2(.q(yr[2]),.d(y[2]),.clk(clk)); dff_cla dff_y3(.q(yr[3]),.d(y[3]),.clk(clk));
    dff_cla dff_y4(.q(yr[4]),.d(y[4]),.clk(clk)); dff_cla dff_y5(.q(yr[5]),.d(y[5]),.clk(clk));
    dff_cla dff_y6(.q(yr[6]),.d(y[6]),.clk(clk)); dff_cla dff_y7(.q(yr[7]),.d(y[7]),.clk(clk));

    wire [7:0] pp0, pp1, pp2, pp3;
    AND2 pp0a0(.y(pp0[0]),.a(yr[0]),.b(xr[0])); AND2 pp0a1(.y(pp0[1]),.a(yr[1]),.b(xr[0]));
    AND2 pp0a2(.y(pp0[2]),.a(yr[2]),.b(xr[0])); AND2 pp0a3(.y(pp0[3]),.a(yr[3]),.b(xr[0]));
    AND2 pp0a4(.y(pp0[4]),.a(yr[4]),.b(xr[0])); AND2 pp0a5(.y(pp0[5]),.a(yr[5]),.b(xr[0]));
    AND2 pp0a6(.y(pp0[6]),.a(yr[6]),.b(xr[0])); AND2 pp0a7(.y(pp0[7]),.a(yr[7]),.b(xr[0]));
    AND2 pp1a0(.y(pp1[0]),.a(yr[0]),.b(xr[1])); AND2 pp1a1(.y(pp1[1]),.a(yr[1]),.b(xr[1]));
    AND2 pp1a2(.y(pp1[2]),.a(yr[2]),.b(xr[1])); AND2 pp1a3(.y(pp1[3]),.a(yr[3]),.b(xr[1]));
    AND2 pp1a4(.y(pp1[4]),.a(yr[4]),.b(xr[1])); AND2 pp1a5(.y(pp1[5]),.a(yr[5]),.b(xr[1]));
    AND2 pp1a6(.y(pp1[6]),.a(yr[6]),.b(xr[1])); AND2 pp1a7(.y(pp1[7]),.a(yr[7]),.b(xr[1]));
    AND2 pp2a0(.y(pp2[0]),.a(yr[0]),.b(xr[2])); AND2 pp2a1(.y(pp2[1]),.a(yr[1]),.b(xr[2]));
    AND2 pp2a2(.y(pp2[2]),.a(yr[2]),.b(xr[2])); AND2 pp2a3(.y(pp2[3]),.a(yr[3]),.b(xr[2]));
    AND2 pp2a4(.y(pp2[4]),.a(yr[4]),.b(xr[2])); AND2 pp2a5(.y(pp2[5]),.a(yr[5]),.b(xr[2]));
    AND2 pp2a6(.y(pp2[6]),.a(yr[6]),.b(xr[2])); AND2 pp2a7(.y(pp2[7]),.a(yr[7]),.b(xr[2]));
    AND2 pp3a0(.y(pp3[0]),.a(yr[0]),.b(xr[3])); AND2 pp3a1(.y(pp3[1]),.a(yr[1]),.b(xr[3]));
    AND2 pp3a2(.y(pp3[2]),.a(yr[2]),.b(xr[3])); AND2 pp3a3(.y(pp3[3]),.a(yr[3]),.b(xr[3]));
    AND2 pp3a4(.y(pp3[4]),.a(yr[4]),.b(xr[3])); AND2 pp3a5(.y(pp3[5]),.a(yr[5]),.b(xr[3]));
    AND2 pp3a6(.y(pp3[6]),.a(yr[6]),.b(xr[3])); AND2 pp3a7(.y(pp3[7]),.a(yr[7]),.b(xr[3]));

    wire [3:0] s1_lo; wire c1_lo; wire [3:0] s1_hi; wire c1_hi;
    cla_4bit add1_lo(.sum(s1_lo),.cout(c1_lo),.a(pp0[4:1]),       .b(pp1[3:0]),.cin(1'b0));
    cla_4bit add1_hi(.sum(s1_hi),.cout(c1_hi),.a({1'b0,pp0[7:5]}),.b(pp1[7:4]),.cin(c1_lo));
    wire [9:0] acc1;
    assign acc1[0]=pp0[0]; assign acc1[4:1]=s1_lo; assign acc1[8:5]=s1_hi; assign acc1[9]=c1_hi;

    wire [3:0] s2_lo; wire c2_lo; wire [3:0] s2_hi; wire c2_hi;
    cla_4bit add2_lo(.sum(s2_lo),.cout(c2_lo),.a(acc1[5:2]),.b(pp2[3:0]),.cin(1'b0));
    cla_4bit add2_hi(.sum(s2_hi),.cout(c2_hi),.a(acc1[9:6]),.b(pp2[7:4]),.cin(c2_lo));
    wire [10:0] acc2;
    assign acc2[1:0]=acc1[1:0]; assign acc2[5:2]=s2_lo; assign acc2[9:6]=s2_hi; assign acc2[10]=c2_hi;

    wire [3:0] s3_lo; wire c3_lo; wire [3:0] s3_hi; wire c3_hi;
    cla_4bit add3_lo(.sum(s3_lo),.cout(c3_lo),.a(acc2[6:3]), .b(pp3[3:0]),.cin(1'b0));
    cla_4bit add3_hi(.sum(s3_hi),.cout(c3_hi),.a(acc2[10:7]),.b(pp3[7:4]),.cin(c3_lo));
    wire [11:0] result_comb;
    assign result_comb[2:0]=acc2[2:0]; assign result_comb[6:3]=s3_lo;
    assign result_comb[10:7]=s3_hi;    assign result_comb[11]=c3_hi;

    dff_cla dff_r0 (.q(res[0]), .d(result_comb[0]), .clk(clk));
    dff_cla dff_r1 (.q(res[1]), .d(result_comb[1]), .clk(clk));
    dff_cla dff_r2 (.q(res[2]), .d(result_comb[2]), .clk(clk));
    dff_cla dff_r3 (.q(res[3]), .d(result_comb[3]), .clk(clk));
    dff_cla dff_r4 (.q(res[4]), .d(result_comb[4]), .clk(clk));
    dff_cla dff_r5 (.q(res[5]), .d(result_comb[5]), .clk(clk));
    dff_cla dff_r6 (.q(res[6]), .d(result_comb[6]), .clk(clk));
    dff_cla dff_r7 (.q(res[7]), .d(result_comb[7]), .clk(clk));
    dff_cla dff_r8 (.q(res[8]), .d(result_comb[8]), .clk(clk));
    dff_cla dff_r9 (.q(res[9]), .d(result_comb[9]), .clk(clk));
    dff_cla dff_r10(.q(res[10]),.d(result_comb[10]),.clk(clk));
    dff_cla dff_r11(.q(res[11]),.d(result_comb[11]),.clk(clk));
endmodule
