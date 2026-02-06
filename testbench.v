// 2. TESTbENCH
`include"ALU_DESIGN.v"
module tb;
    reg  [7:0]a,b;
    reg  [3:0]alu_sel;
    wire [7:0]alu_out;
    wire z, c, o;
    alu_8_bit dut(.a(a), .b(b), .alu_sel(alu_sel),.alu_out(alu_out), .z(z), .c(c), .o(o));
    initial begin
        $display("Time\ta\tb\tSel\tOut\tC\tZ\tO");
        $monitor("%0t\t%h\t%h\t%b\t%h\t%b\t%b\t%b",
                  $time, a, b, alu_sel, alu_out, c, z, o);
        // Test vectors
        a = 8'h14; b = 8'h05;
        alu_sel = 4'b0000; #1; // ADD
        alu_sel = 4'b0001; #1; // SUb
        alu_sel = 4'b0010; #1; // AND
        alu_sel = 4'b0011; #1; // OR
        alu_sel = 4'b0100; #1; // XOR
        alu_sel = 4'b0101; #1; // NOT
        alu_sel = 4'b0110; #1; // SHL
        alu_sel = 4'b0111; #1; // SHR
        alu_sel = 4'b1000; #1; // aSR
        alu_sel = 4'b1001; #1; // INC
        alu_sel = 4'b1010; #1; // DEC
        alu_sel = 4'b1011; #1; // CMP
        alu_sel = 4'b1100; #1; // PASS a
        alu_sel = 4'b1101; #1; // PASS b
        // overflow test
        a = 8'h7F; b = 8'h01; alu_sel = 4'b0000; #1; // + overflow
        a = 8'h80; b = 8'h01; alu_sel = 4'b0001; #1; // - overflow
        $stop;
    end
endmodule
