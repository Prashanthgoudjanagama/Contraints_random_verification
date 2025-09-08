

// file name : 10_Inline_Soft_constraints.sv
// module name : top_inline_soft

/*
_______________________________________________________________________

Inline Constraints:
_________________________>

    -> Constraint needs to modify during the randomization process.
    -> This allows for more dynamic and flexible constraint definitions.
    -> In the same range of constraint.

Soft Constraints:
_________________________>

    -> declared with soft keyword in constraint.
    -> In the out of range of constraint.

_______________________________________________________________________

*/

class inline_constraint;
    rand bit [7:0] val1, val2;
    
    constraint val1_c {val1 > 100; val1 < 200;}
    constraint val2_c {val2 > 5; val2 < 80;}

    function void post_randomize();
        $display("\t\tval1 = %0d, val2 = %0d", val1, val2);
    endfunction : post_randomize

endclass : inline_constraint

module top_inline;
    inline_constraint tr;

    initial begin
        tr = new();

        $display("\n________________ Before inline constraint range -> val1 [100:200], val2 [5:80] _________________________");
        repeat(5) begin
            tr.randomize();
        end

        $display("\n________________ after inline constraint :inline -> val1 [150:160], val2 [10:15] _________________________");
        repeat(5) begin
            tr.randomize with {
                val1 inside {[150:160]};
                val2 inside {[10:15]};

            };
        end
    end
endmodule : top_inline

/*
_______________________________________________________________________________
    simulation results:
    ___________________>

    # ________________ Before inline constraint range -> val1 [100:200], val2 [5:80] _________________________
    # 		val1 = 169, val2 = 15
    # 		val1 = 186, val2 = 60
    # 		val1 = 136, val2 = 54
    # 		val1 = 176, val2 = 10
    # 		val1 = 170, val2 = 30
    # 
    # ________________ after inline constraint :inline -> val1 [150:160], val2 [10:15] _________________________
    # 		val1 = 150, val2 = 15
    # 		val1 = 159, val2 = 14
    # 		val1 = 150, val2 = 12
    # 		val1 = 160, val2 = 14
    # 		val1 = 152, val2 = 13


_______________________________________________________________________________

*/

class soft_constraint;

    rand bit [7:0] val;
    
    constraint val_c {
        val inside {[100:150]};
    }

    constraint val_soft {
        soft val inside {[100:150]};
    }

    function void post_randomize();
        $display("val = %0d", val);
    endfunction: post_randomize

endclass : soft_constraint

module top_soft;
  soft_constraint ts;;

  initial begin
    ts = new();

        $display("\n________________ Before soft constraint : range -> val [100:150] _________________________");
        ts.val_soft.constraint_mode(0); // disabling soft constraint
        repeat(5) begin
            ts.randomize();
        end

        $display("\n________________ after soft constraint : range -> val [0:50] _________________________");
        ts.val_soft.constraint_mode(1); // disabling soft constraint
        ts.val_c.constraint_mode(0); // disabling soft constraint
        repeat(5) begin
            ts.randomize with {
                val inside {[0:50]};
            };
        end
  end
endmodule
/*
_______________________________________________________________________________
    simulation results:
    ___________________>

    # ________________ Before soft constraint : range -> val [100:150] _________________________
    # val = 144
    # val = 147
    # val = 144
    # val = 117
    # val = 109
    # 
    # ________________ after soft constraint : range -> val [0:50] _________________________
    # val = 17
    # val = 43
    # val = 29
    # val = 19
    # val = 48


_______________________________________________________________________________

*/


module top_inline_soft();

    //top_inline ti();
    top_soft tso();

endmodule : top_inline_soft