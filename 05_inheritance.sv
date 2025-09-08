

// file name: 05_inheritance.sv
// module : top_inher

/*
____________________________________________________________________________________

    Inheritance in class:

        -> Here the parent class constraint will override the child class constraint.
        -> Both the child and parent class nomenclature must be same.
____________________________________________________________________________________

*/


class parent;
  rand bit [5:0] value;

  constraint value_c {value > 0; value < 10;}  // range 0-10

  function void post_randomize();
    $display("[Parent] value = %0d", value);
  endfunction : post_randomize

endclass

class child extends parent;

  constraint value_c {value inside {[20:30]};}  // now range 20:30

  function void post_randomize();
    $display("[Child] value = %0d", value);
  endfunction : post_randomize

endclass

module top_inher;
  parent p;
  child c;
  
  initial begin
    p = new();
    c = new();

    $display("\n______________using parent class_______________________");
    repeat(3) begin
        p.randomize();
    end

    $display("\n______________using child class_______________________");
    repeat(3) begin
        c.randomize();
    end
  end
endmodule

/*
__________________________________________________________________________________________

    simulation results
            # ______________using parent class_______________________
            # [Parent] value = 6
            # [Parent] value = 7
            # [Parent] value = 3
            # 
            # ______________using child class_______________________
            # [Child] value = 20
            # [Child] value = 27
            # [Child] value = 26
___________________________________________________________________________________________

*/