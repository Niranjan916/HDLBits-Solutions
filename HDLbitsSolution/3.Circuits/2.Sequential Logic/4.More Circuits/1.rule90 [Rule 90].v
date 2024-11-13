module top_module(
    input clk,           // Clock signal
    input load,          // Load signal to load the state
    input [511:0] data,  // Input data for loading the state
    output reg [511:0] q // Output state of the system
);

    // Internal signal for next state calculation
    reg [511:0] next_q;
    
    always @(posedge clk) begin
        if (load) begin
            // Load the state when load signal is high
            q <= data;
        end else begin
            // Rule 90: XOR the left and right neighbors for each cell
            next_q[0] = 0 ^ q[1]; // Boundary condition for the first cell
            next_q[511] = q[510] ^ 0; // Boundary condition for the last cell
            
            // Iterate over the rest of the cells
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            
            // Update the state
            q <= next_q;
        end
    end

endmodule
