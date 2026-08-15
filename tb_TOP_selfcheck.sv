`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Self-checking testbench for TOP (single-cycle RISC-V)
// Program under test: sums a 5-element array stored in data memory
//   Expected final state (computed by hand from the instruction trace):
//     x5  (t0) = 0     (base address)
//     x6  (t1) = 31    (last value loaded, array[4])
//     x7  (t2) = 123   (sum = 25+12+48+7+31)   <-- the key correctness check
//     x28 (t3) = 5     (loop index after exit)
//     x29 (t4) = 5     (size)
//     x30 (t5) = 16    (last offset, i=4 -> 4*4)
//     x31 (t6) = 16    (last computed address)
//     data_mem[0..4] = 25, 12, 48, 7, 31
//////////////////////////////////////////////////////////////////////////////////

module tb_TOP_selfcheck;

    logic clk, reset;

    // pass/fail bookkeeping
    int pass_count = 0;
    int fail_count = 0;

    TOP DUT (
        .clk(clk),
        .reset(reset)
    );

    // clock generation: period = 2ns, first posedge at t=1ns
    always #1 clk = ~clk;

    //////////////////////////////////////////////////////////////////
    // Reusable self-check task (32-bit compare, auto pass/fail log)
    //////////////////////////////////////////////////////////////////
    task automatic check_result(string test_name, logic [31:0] actual, logic [31:0] expected);
        if (actual === expected) begin
            pass_count++;
            $display("PASS: %-28s | expected = %0d (0x%0h), got = %0d (0x%0h)",
                       test_name, expected, expected, actual, actual);
        end
        else begin
            fail_count++;
            $display("FAIL: %-28s | expected = %0d (0x%0h), got = %0d (0x%0h)",
                       test_name, expected, expected, actual, actual);
        end
    endtask

    //////////////////////////////////////////////////////////////////
    // Stimulus
    //////////////////////////////////////////////////////////////////
    initial begin
        clk   = 0;
        reset = 0;               // active-low reset asserted

        // hold reset for a few full cycles, release cleanly on a negedge
        // (avoids the reset/posedge race we hit earlier)
        repeat (3) @(negedge clk);
        reset = 1;

        // Let the program run to completion.
        // Program has ~24 static instructions but the loop body re-executes
        // 5 times before falling through to the final "beq x0,x0,done".
        // Single-cycle CPU => 1 instruction per clk cycle. Give generous margin.
        repeat (60) @(negedge clk);

        //////////////////////////////////////////////////////////////
        // SELF-CHECKING SECTION
        //////////////////////////////////////////////////////////////
        $display("\n================ SELF-CHECK RESULTS ================\n");

        // ---- Register file checks ----
        check_result("x5  (t0) base addr",   DUT.Register_F.register[5],  32'd0);
        check_result("x6  (t1) last loaded", DUT.Register_F.register[6],  32'd31);
        check_result("x7  (t2) sum",         DUT.Register_F.register[7],  32'd123);
        check_result("x28 (t3) loop index",  DUT.Register_F.register[28], 32'd5);
        check_result("x29 (t4) size",        DUT.Register_F.register[29], 32'd5);
        check_result("x30 (t5) last offset", DUT.Register_F.register[30], 32'd16);
        check_result("x31 (t6) last addr",   DUT.Register_F.register[31], 32'd16);

        // ---- Data memory checks ----
        check_result("mem[0] array[0]", DUT.Data_M.data_mem[0], 32'd25);
        check_result("mem[1] array[1]", DUT.Data_M.data_mem[1], 32'd12);
        check_result("mem[2] array[2]", DUT.Data_M.data_mem[2], 32'd48);
        check_result("mem[3] array[3]", DUT.Data_M.data_mem[3], 32'd7);
        check_result("mem[4] array[4]", DUT.Data_M.data_mem[4], 32'd31);
        // NOTE: this 1-to-1 mem[i] <-> array[i] mapping is only correct because
        // data_memory now converts byte address -> word index via Address[6:2].
        // Before that fix, data_mem[i] did NOT correspond to array[i].
        
        //////////////////////////////////////////////////////////////
        // Final summary
        //////////////////////////////////////////////////////////////
        $display("\n======================================================");
        $display("TOTAL: %0d PASSED, %0d FAILED", pass_count, fail_count);
        if (fail_count == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: TESTBENCH FAILED - %0d MISMATCH(ES)", fail_count);
        $display("======================================================\n");

        $finish;
    end

endmodule