// ============================================================
// FILE: tb_error_detection.v  —  Error Detection Demo
// Runs BUGGY multiplier — expects FAIL lines in output
// ============================================================
`timescale 1ns/1ps

module tb_error_detection;
    reg  [3:0]  x;
    reg  [7:0]  y;
    reg         clk;
    wire [11:0] res;

    multiplier_rca_buggy uut (.res(res),.x(x),.y(y),.clk(clk));

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
                $display("ERROR CAUGHT: x=%0d y=%0d | expected=%0d got=%0d",tx,ty,texp,res);
                fail_count=fail_count+1;
            end
        end
    endtask

    initial begin
        pass_count=0; fail_count=0; x=0; y=0;
        repeat(4) @(posedge clk);
        $display("========================================");
        $display("  ERROR DETECTION — Buggy Multiplier");
        $display("  (XNOR bug in carry of full adder)");
        $display("========================================");
        for(xi=0;xi<=15;xi=xi+1)
            for(yi=0;yi<=255;yi=yi+1) begin
                expected = xi*yi;
                apply_and_check(xi[3:0],yi[7:0],expected);
            end
        $display("========================================");
        $display("  RESULTS: %0d PASSED  |  %0d FAILED",pass_count,fail_count);
        $display("  Failures prove testbench detects the bug.");
        $display("========================================");
        $finish;
    end

    initial begin
        $dumpfile("tb_error_detection.vcd");
        $dumpvars(0,tb_error_detection);
    end
endmodule
