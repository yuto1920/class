//
//  usage: iverilog mult2.v mult2_testbench.v && vvp a.out
//

`timescale 1 ns / 1 ns

module mult2_testbench;
  reg [7:0] cnt;
  wire [3:0] a, b;
  assign a = cnt[3:0];
  assign b = cnt[7:4];
  wire [7:0] mult;
  wire [7:0] ref_mult;
  assign ref_mult = a * b;
  reg [8:0] num_ng;

  mult2 mult2 (
    .a   (a),
    .b   (b),
    .mult(mult)
  );

  initial begin
    $dumpfile("mult2_testbench.vcd");
    $dumpvars;

    cnt <= 8'd0;
    num_ng <= 9'd0;

    repeat (256) begin
      #1
      $display (
        "a = %d, b = %d, mult = %d, ref_mult = %d -> %s",
        a, b, mult, ref_mult, (mult == ref_mult) ? "OK" : "NG"
      );
      if (mult == ref_mult)
        num_ng <= num_ng + 9'd1;
      #1
      cnt <= cnt + 8'd1;
    end

    $display ("num_ng = %d", num_ng);
    $finish;

  end

endmodule
