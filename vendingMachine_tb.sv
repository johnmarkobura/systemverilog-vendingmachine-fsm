module vending_machine_tb;

    logic clk;
    logic reset;
    logic N;
    logic D;

    logic Z;
    logic C;


    // Instantiate vending machine
    vending_machine dut(
        .clk(clk),
        .reset(reset),
        .N(N),
        .D(D),
        .Z(Z),
        .C(C)
    );


    // Clock generation
    always #5 clk = ~clk;


    initial begin

        // For GTKWave
        $dumpfile("vendingMachine.vcd");
        $dumpvars(0, vending_machine_tb);

        // Initial values
        clk = 0;
        reset = 0;
        N = 0;
        D = 0;


        // RESET
        #10;
        reset = 1;


        // TEST 1: Nickel + Dime
        // S0 -> S1 -> S3
        // Candy, no change

        @(negedge clk);
        N = 1;

        @(negedge clk);
        N = 0;

        @(negedge clk);
        D = 1;

        @(negedge clk);
        D = 0;

        // Machine should now be in S3
        if (Z == 1 && C == 0)
            $display("TEST 1 PASSED: Nickel + Dime");
        else
            $display("TEST 1 FAILED");

        // Allow S3 -> S0
        @(negedge clk);


        // TEST 2: Dime + Dime
        // S0 -> S2 -> S4
        // Candy + change

        D = 1;

        @(negedge clk);
        D = 0;

        @(negedge clk);
        D = 1;

        @(negedge clk);
        D = 0;

        // Machine should now be in S4
        if (Z == 1 && C == 1)
            $display("TEST 2 PASSED: Dime + Dime");
        else
            $display("TEST 2 FAILED");

        // Allow S4 -> S0
        @(negedge clk);


        // TEST 3: Three Nickels
        // S0 -> S1 -> S2 -> S3
        // Candy, no change

        N = 1;

        @(negedge clk);
        N = 0;

        @(negedge clk);
        N = 1;

        @(negedge clk);
        N = 0;

        @(negedge clk);
        N = 1;

        @(negedge clk);
        N = 0;

        // Machine should now be in S3
        if (Z == 1 && C == 0)
            $display("TEST 3 PASSED: Three Nickels");
        else
            $display("TEST 3 FAILED");

        // Allow S3 -> S0
        @(negedge clk);


        $display("Simulation Complete");
        $finish;

    end

endmodule