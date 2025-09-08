
// file name : 09_unique_bidirectional_solve_before.sv
// module name : top_unique_bidirectional_solve_before

/*
___________________________________________________________________________________________________
UNIQUE CONSTRAINTS:
_________________________>

    -> The unique constraint ensures that a set of variables (individual variables or array 
       elements) receive distinct values each time randomization occurs. It’s particularly 
       useful when you want uniqueness across array elements or multiple variables.

    -> Syntax example:

        constraint array_c { unique {array}; }
        constraint val_c { unique {val1, val2, val3, val4}; }


    -> This guarantees that elements of array or the variables val1 .. val4 
    are all assigned different random value

BIDIRECTIONAL CONSTRAINTS:
__________________________>

    1. Constraints are solved together, not line by line.
    2. Variables can influence each other both ways.
    3. The order of writing constraints does not matter.
    4. If constraints conflict, randomization will fail.
    5. Works well for interdependent variables (e.g., sums, differences).
    6. Unlike code execution, constraints are declarative, not sequential.

SOLVE BEFORE CONSTRAINTS
_________________________>

    1. Constraints are solved before the main randomization process.
    2. Ensures that certain conditions are met prior to variable assignments.
    3. Useful for establishing initial states or relationships between variables.

_____________________________________________________________________________________________________

*/

class unique_constraint;

    rand bit[3:0] data;
    rand bit[7:0] array[10];

    constraint c_cond{
        data inside {[1:12]};
        foreach(array[i]) {
            array[i] % 10 == 0;
        }
    }

    constraint c_unique{
        unique {data};
        unique {array};
    }

    function void post_randomize();
        // foreach(array[i]) begin
        //     $display("Array[%0d]: %0d", i, array[i]);
        // end
        $display("data : %0d   |||||   Array: %0p", data, array);
    endfunction: post_randomize

endclass : unique_constraint

module top_unique();
    unique_constraint u_c;

    initial begin
        $display("________with using unique key word____________");
        u_c = new();
        repeat(10) begin
            assert(u_c.randomize());
        end

        $display("________without using unique key word____________");
        u_c.c_unique.constraint_mode(0); // disabling the "c_unique" constraint
        repeat(10) begin
            assert(u_c.randomize());
        end
    end
endmodule : top_unique

/*
___________________________________________________________________________

    simulation results:

    # ________with using unique key word____________
    # data : 11   |||||   Array: 190 170 130 220 10 100 0 120 180 50
    # data : 8    |||||   Array: 140 10 70 110 210 190 20 180 130 250
    # data : 11   |||||   Array: 130 190 160 230 240 170 70 90 140 150
    # data : 7    |||||   Array: 100 200 40 150 120 130 50 180 190 210
    # data : 10   |||||   Array: 30 160 150 70 10 230 210 80 220 180
    # data : 8    |||||   Array: 20 240 120 250 220 160 150 110 40 90
    # data : 8    |||||   Array: 20 120 130 220 190 200 150 30 40 250
    # data : 12   |||||   Array: 240 130 110 60 40 10 30 0 160 80
    # data : 1    |||||   Array: 140 150 90 10 210 160 0 70 200 100
    # data : 6    |||||   Array: 140 30 130 70 50 150 20 240 10 100
    #
    # ________without using unique key word____________
    # data : 5    |||||   Array: 30 10 190 160 0 10 160 100 0 40
    # data : 8    |||||   Array: 0 250 90 220 190 90 30 220 120 210
    # data : 11   |||||   Array: 190 40 110 150 160 70 90 130 140 220
    # data : 4    |||||   Array: 0 70 120 40 80 230 60 240 140 130
    # data : 10   |||||   Array: 170 130 90 80 60 60 170 130 90 70
    # data : 6    |||||   Array: 20 130 30 20 20 120 10 220 180 150
    # data : 1    |||||   Array: 170 110 70 240 120 190 170 180 210 10
    # data : 1    |||||   Array: 100 10 60 60 130 220 50 40 0 230
    # data : 7    |||||   Array: 70 220 130 160 80 50 120 200 190 30
    # data : 9    |||||   Array: 190 140 80 130 250 110 20 150 190 210
___________________________________________________________________________

*/


class bidirectional_constraint;
    rand bit [7:0] val1, val2, val3, val4;
    rand bit[1:0] t1, t2;
    
    constraint val_c {
        val2 > val1; 
        val3 == val2 - val1;  // val3 depends on val1 and val2
        val4 < val3;          // val4 depends on val3
        val4 == val1/val3;    // val4 depends on val1 and val3
    }
  
    constraint t_c { 
        (t1 == 1) -> t2 == 3;     // t1 and t2 are bi-directionally dependent
    }

    function void post_randomize();
        $display("\tval1 = %0d, val2 = %0d, val3 = %0d, val4 = %0d", val1, val2, val3, val4);
        $display("\tt1 = %0h, t2 = %0h", t1, t2);
    endfunction: post_randomize

endclass : bidirectional_constraint

module top_bidirectional;
    bidirectional_constraint bc;

    initial begin
        bc = new();

        $display("__________ Bidirectional constraint solving ____________");
        repeat(5) begin
            assert(bc.randomize());
        end
    end
endmodule : top_bidirectional

/*
____________________________________________________
    simulation results:

            # __________ Bidirectional constraint solving ____________
            # 	val1 = 17, val2 = 22, val3 = 5, val4 = 3
            # 	t1 = 1, t2 = 0
            # 	val1 = 213, val2 = 254, val3 = 41, val4 = 5
            # 	t1 = 0, t2 = 0
            # 	val1 = 75, val2 = 97, val3 = 22, val4 = 3
            # 	t1 = 0, t2 = 1
            # 	val1 = 78, val2 = 205, val3 = 127, val4 = 0
            # 	t1 = 1, t2 = 0
            # 	val1 = 41, val2 = 56, val3 = 15, val4 = 2
            # 	t1 = 1, t2 = 0
____________________________________________________
*/

class slove_before;
    rand bit [7:0] val;
    rand bit en;
    
    constraint c_without { 
        if(en == 1) { 
            val inside {[0:100]}; 
        } else { 
            val inside {[150:255]}; 
        }
    }

    constraint c_solve_before { 
        solve en before val;
        if(en == 1) { 
            val inside {[0:100]}; 
        } else { 
            val inside {[150:255]}; 
        }
    }

    function void post_randomize();
        $display("en = %0d, val = %0d", en, val);
    endfunction : post_randomize

endclass : slove_before

module top_solve_before;
  slove_before sb;

  initial begin
    sb = new();

    $display("\n__________without Solve before ____________");
    sb.c_solve_before.constraint_mode(0);
    repeat(10) begin
      sb.randomize();
    end

    $display("\n__________with Solve before ____________");
    sb.c_solve_before.constraint_mode(1);
    sb.c_without.constraint_mode(0);
    repeat(10) begin
      sb.randomize();
    end
  end
endmodule : top_solve_before


/*
____________________________________________________
    simulation results:

        # __________without Solve before ____________
        # en = 1, val = 10
        # en = 0, val = 174
        # en = 1, val = 2
        # en = 0, val = 196
        # en = 1, val = 49
        # en = 0, val = 211
        # en = 0, val = 154
        # en = 0, val = 195
        # en = 0, val = 240
        # en = 1, val = 75
        # 
        # __________with Solve before ____________
        # en = 1, val = 35
        # en = 0, val = 203
        # en = 0, val = 160
        # en = 0, val = 190
        # en = 0, val = 165
        # en = 0, val = 239
        # en = 1, val = 34
        # en = 0, val = 198
        # en = 0, val = 154
        # en = 1, val = 85
____________________________________________________
*/

module top_unique_bidirectional_solve_before;

    //top_unique u_tu();
    //top_bidirectional t_bi();
    top_solve_before t_sb();

endmodule : top_unique_bidirectional_solve_before