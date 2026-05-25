// ============================================================
// FILE: tb_multiplier_rca.v  —  Testbench: Stage 1 RCA
// Run: iverilog -o tb_rca tb_multiplier_rca.v && vvp tb_rca
// Clock = 600 ns period (safe margin above 251 ns latency)
// ============================================================
`timescale 1ns/1ps

module tb_multiplier_rca;
    reg  [3:0]  x;
    reg  [7:0]  y;
    reg         clk;
    wire [11:0] res;

    multiplier_rca uut (.res(res),.x(x),.y(y),.clk(clk));

    initial clk = 0;
    always #300 clk = ~clk;

    integer pass_count, fail_count, xi, yi;
    reg [11:0] expected;

    task apply_and_check;
        input [3:0] tx; input [7:0] ty; input [11:0] texp;
        begin
            x=tx; y=ty;
            @(posedge clk); #1;
            @(posedge clk); #1;
            if (res===texp) pass_count=pass_count+1;
            else begin
                $display("FAIL: x=%0d y=%0d | expected=%0d got=%0d",tx,ty,texp,res);
                fail_count=fail_count+1;
            end
        end
    endtask

    initial begin
        pass_count=0; fail_count=0; x=0; y=0;
        repeat(4) @(posedge clk);
        $display("========================================");
        $display("  RCA Multiplier - Complete Verification");
        $display("  Testing all 16 x 256 = 4096 cases");
        $display("========================================");
        for(xi=0;xi<=15;xi=xi+1)
            for(yi=0;yi<=255;yi=yi+1) begin
                expected = xi*yi;
                apply_and_check(xi[3:0],yi[7:0],expected);
            end
        $display("========================================");
        $display("  RESULTS: %0d PASSED  |  %0d FAILED",pass_count,fail_count);
        $display("========================================");
        if(fail_count==0) $display("  *** ALL TESTS PASSED ***");
        else              $display("  *** FAILURES DETECTED ***");
        $finish;
    end

    initial begin
        $dumpfile("tb_multiplier_rca.vcd");
        $dumpvars(0,tb_multiplier_rca);
    end
endmodule
