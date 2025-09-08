

// file name: 08_static_constraints.sv
// module name : top_static_constraints


/*
____________________________________________________________

    -> Defined inside constraint blocks.
    -> Values are constant expressions (known before simulation starts).
    -> Applied automatically during randomization when calling randomize().
    -> Cannot depend on run-time changing values or simulation state.
    -> Useful for defining permanent restrictions on random variables.
____________________________________________________________
*/


class static_const;
  rand bit [7:0] value1;
  rand bit [7:0] value2;

  constraint value1_c {value1 inside {[10:30]};}
  static constraint value2_c {value2 inside {40,70, 80};}

  function void post_randomize();
    $display("\t\tvalue1 = %0d, value2 = %0d", value1, value2);
  endfunction : post_randomize

endclass : static_const

module top_static_constraints;
  static_const tr1, tr2;

  initial begin
    tr1 = new();
    tr2 = new();
    
    $display("\n__________ Before disabling constraint__________________");
    repeat(10) begin
        tr1.randomize();
    end

    $display("\n__________ After disabling constraint for all value2 alone _______________");
    tr1.value2_c.constraint_mode(0);  // To disable constraint for value2 using handle tr1
    repeat(10) begin
        tr1.randomize();
    end
end
endmodule : top_static_constraints


/*
______________________________________________________________
    simulation results:

        # __________ Before disabling constraint__________________
        # 		value1 = 21, value2 = 70
        # 		value1 = 20, value2 = 80
        # 		value1 = 23, value2 = 70
        # 		value1 = 20, value2 = 40
        # 		value1 = 14, value2 = 80
        # 		value1 = 25, value2 = 80
        # 		value1 = 17, value2 = 40
        # 		value1 = 13, value2 = 40
        # 		value1 = 13, value2 = 70
        # 		value1 = 27, value2 = 70
        # 
        # __________ After disabling constraint for all value2 alone _______________
        # 		value1 = 12, value2 = 136
        # 		value1 = 25, value2 = 54
        # 		value1 = 11, value2 = 5
        # 		value1 = 14, value2 = 95
        # 		value1 = 14, value2 = 49
        # 		value1 = 29, value2 = 35
        # 		value1 = 29, value2 = 190
        # 		value1 = 26, value2 = 82
        # 		value1 = 19, value2 = 246
        # 		value1 = 16, value2 = 68

    observation:
    ____________
        Before disabling the constraint on value2, it was limited to the set {40, 70, 80}.
        After disabling the constraint, value2 was able to take on a much wider range of values, 
        including values outside of the original set. This demonstrates the impact of static 
        constraints on random variable distributions in SystemVerilog.
______________________________________________________________
*/