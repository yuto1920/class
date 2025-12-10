`timescale 1 ns / 1 ns

module strange_testbench;
  reg  clk, res;
  reg  [1:0] s;

  /* for decoder type */
  wire [1:0] state;
  localparam S0 = 2'd0;
  localparam S1 = 2'd1;
  localparam S2 = 2'd2;
  localparam S3 = 2'd3;

  // /* for one-hot type */
  // wire [3:0] state;
  // localparam S0 = 4'b0001;
  // localparam S1 = 4'b0010;
  // localparam S2 = 4'b0100;
  // localparam S3 = 4'b1000;

  strange strange (
    .clk(clk),
    .res(res),
    .s(s),
    .state(state)
  );

  task check_state;
    input [1:0] ref_state;  // for decoder type
    // input [3:0] ref_state;  // for one-hot type
    begin
      $display ("check state = %d", ref_state);
      #5
      if (state == ref_state)
        $display ("-> OK");
      else begin
        $display ("-> NG: state = %d", state);
        $finish;
      end
    end
  endtask

  task input_s;
    input [1:0] ref_s;
    begin
      $display ("input s = %d", ref_s);
      s <= ref_s;
      @(posedge clk);
    end
  endtask

  initial begin
    clk <= 1'b1;
    forever
      #10 clk <= ~clk;
  end

  initial begin
    $display ("assert/neget reset");
    res <= 1'b1;
    s <= 2'd0;
    repeat (10) @(posedge clk);
    res <= 1'b0;
    check_state (S0);

    input_s (2'd0);
    check_state (S0);

    input_s (2'd1);
    check_state (S1);

    input_s (2'd0);
    check_state (S1);

    input_s (2'd1);
    check_state (S2);

    input_s (2'd0);
    check_state (S2);

    input_s (2'd1);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    input_s (2'd1);
    check_state (S1);

    input_s (2'd2);
    check_state (S2);

    input_s (2'd2);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    input_s (2'd1);
    check_state (S1);

    input_s (2'd2);
    check_state (S2);

    input_s (2'd2);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    input_s (2'd2);
    check_state (S2);

    input_s (2'd3);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    input_s (2'd3);
    check_state (S2);

    input_s (2'd3);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    input_s (2'd1);
    check_state (S1);

    input_s (2'd3);
    check_state (S3);

    @(posedge clk);
    check_state (S0);

    $finish;
  end

endmodule
