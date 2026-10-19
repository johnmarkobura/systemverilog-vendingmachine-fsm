module vending_machine(
    input  logic clk,
    input  logic reset,
    input  logic N,       // nickel
    input  logic D,       // dime
    output logic Z,       // candy
    output logic C        // change
);

    // State encoding
    parameter S0 = 3'b000;   // 0 cents
    parameter S1 = 3'b001;   // 5 cents
    parameter S2 = 3'b010;   // 10 cents
    parameter S3 = 3'b011;   // candy
    parameter S4 = 3'b100;   // candy + change

    logic [2:0] state, next_state;


    // State register
    always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            state <= S0;
        else
            state <= next_state;
    end


    // Next-state logic
    always_comb begin

        case (state)

            S0: begin
                if (N)
                    next_state = S1;
                else if (D)
                    next_state = S2;
                else
                    next_state = S0;
            end

            S1: begin
                if (N)
                    next_state = S2;
                else if (D)
                    next_state = S3;
                else
                    next_state = S1;
            end

            S2: begin
                if (N)
                    next_state = S3;
                else if (D)
                    next_state = S4;
                else
                    next_state = S2;
            end

            S3: begin
                next_state = S0;
            end

            S4: begin
                next_state = S0;
            end

            default: begin
                next_state = S0;
            end

        endcase
    end


    // Output logic
    always_comb begin

        Z = 0;
        C = 0;

        if (state == S3)
            Z = 1;

        else if (state == S4) begin
            Z = 1;
            C = 1;
        end

    end

endmodule