

//filename: 01_Basic_keywords_and_ranges.sv
//module : top_basic_constraints

`define min 50
`define max 100

class basic_randomization #(
    parameter int p1 = 76, p2 = 89
);

    rand bit [7:0] d1;      // 0 to 2**7 -1 = 0 to 127
    rand int d2;            // -2**32 to 2**32 -1 
    rand bit [31:0] d3;      // 0 to 2**32 -1 
    rand bit [7:0] d4;       // 0 to 2**7 -1 = 0 to 127
    rand int d5;
    rand bit [3:0] d6;       // 0 to 2**4 -1 = 0 to 15
    randc bit [1:0] d7;      // 0 to 2**2 -1 = 0 to 3


    constraint c1 {
        d1 inside {10, 50, 25};            //  -- fixed
    }

    constraint c2 {
        d2 inside {[150:250]};                      // 150 to 250 -- Range [min:max]
    }

    constraint c3 {
        d3 inside {30, 50, 70, [100:300]};          // mix ranges
    }

    constraint c4 {
        d4 inside {[`min:`max]};                     // `define range
    }

    constraint c5 {
        d5 inside {[p1:p2]};                         // using parameter
    }

    constraint c6 {
        !(d6 inside {[10:15]});                        // not in this range
    }

endclass : basic_randomization


module top_basic_constraints();

    basic_randomization #(10,30) tr;

    initial begin
        tr = new();
        repeat(10) begin
            if(tr.randomize()) begin
                $display("\t\td1 : %0d      | d2 : %0d    | d3 : %0d       | d4 : %0d       | d5 : %0d   | d6 : %0d     | randc- d7 : %0d", tr.d1, tr.d2, tr.d3, tr.d4, tr.d5, tr.d6, tr.d7);
            end 
            else begin
                $display("Randomization failed");
            end
        end
    end

endmodule : top_basic_constraints

/*
    simulation results:
_________________________________________________________________________________________________________________

        d1 : 10      | d2 : 196    | d3 : 168       | d4 : 57       | d5 : 26   | d6 : 9     | randc- d7 : 2
        d1 : 25      | d2 : 183    | d3 : 209       | d4 : 60       | d5 : 10   | d6 : 6     | randc- d7 : 3
		d1 : 10      | d2 : 190    | d3 : 290       | d4 : 94       | d5 : 11   | d6 : 3     | randc- d7 : 0
		d1 : 50      | d2 : 178    | d3 : 173       | d4 : 78       | d5 : 24   | d6 : 1     | randc- d7 : 1
		d1 : 25      | d2 : 165    | d3 : 224       | d4 : 71       | d5 : 24   | d6 : 6     | randc- d7 : 2
		d1 : 25      | d2 : 151    | d3 : 250       | d4 : 72       | d5 : 25   | d6 : 8     | randc- d7 : 1
		d1 : 25      | d2 : 166    | d3 : 126       | d4 : 71       | d5 : 10   | d6 : 0     | randc- d7 : 0
		d1 : 10      | d2 : 243    | d3 : 242       | d4 : 100      | d5 : 16   | d6 : 2     | randc- d7 : 3
		d1 : 10      | d2 : 204    | d3 : 173       | d4 : 58       | d5 : 20   | d6 : 5     | randc- d7 : 3
		d1 : 25      | d2 : 239    | d3 : 144       | d4 : 78       | d5 : 25   | d6 : 2     | randc- d7 : 2

__________________________________________________________________________________________________________________
*/