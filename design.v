// Project: 8-bit aLU (RTL Design in Verilog)

module alu_8_bit(
    input [7:0]a,
    input [7:0]b,
    input [3:0]alu_sel,   // Operation select
    output reg [7:0]alu_out,
    output reg z, //Zero
    output reg c, //Carry
    output reg o  //Overflow
);
    reg [8:0] temp;
    always @(*) begin
        // Default values
        alu_out=8'b0;
        c=1'b0;
        o=1'b0;
        temp=9'b0;
        case(alu_sel)
            4'b0000: begin //add
                temp = a + b;
                alu_out = temp[7:0];
                c = temp[8];
                o = (~(a[7] ^ b[7])) & (a[7] ^ alu_out[7]);
            end
            4'b0001: begin //sub
                temp = a - b;
                alu_out = temp[7:0];
                c = temp[8]; // borrow flag (inverted carry)
                o = (a[7] ^ b[7]) & (a[7] ^ alu_out[7]);
            end
            4'b0010: begin // AND
                alu_out = a & b;
            end
            4'b0011: begin // OR
                alu_out = a | b;
            end
            4'b0100: begin // XOR
                alu_out = a ^ b;
            end
            4'b0101: begin // NOT a
                alu_out = ~a;
            end
            4'b0110: begin // Logical shift left
                alu_out = a << 1;
                c = a[7];
            end
            4'b0111: begin // Logical shift right
                alu_out = a >> 1;
                c = a[0];
            end
            4'b1000: begin // Arithmetic shift right
                alu_out = {a[7], a[7:1]};
                c = a[0];
            end
            4'b1001: begin // Increment a
                temp = a + 1'b1;
                alu_out = temp[7:0];
                c = temp[8];
            end
            4'b1010: begin // Decrement a
                temp = a - 1'b1;
                alu_out = temp[7:0];
                c = temp[8];
            end
            4'b1011: begin // Compare a and b
                if(a == b)
                    alu_out = 8'b0000_0001; // Equal
                else if(a > b)
                    alu_out = 8'b0000_0010; // Greater
                else
                    alu_out = 8'b0000_0100; // Less
            end
            4'b1100: begin // Pass a
                alu_out = a;
            end

            4'b1101: begin // Pass b
                alu_out = b;
            end
            default: begin
                alu_out = 8'b0;
            end
        endcase
        z = (alu_out == 8'b0);
    end
endmodule


