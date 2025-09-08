


// file name : 04_distribution(dist).sv
// module name : top_dist

/*
___________________________________________________________________
  Distribution (dist) keyword in constraints:

-----------------using ":/" operator:
    1. For specific value: Assign mentioned weight to that value
    2. For range of values ([<range1>: <range2>]):  Assigns weight/(number of value) 
       to each value in that range
        -> constraint value_c {value dist {3:/4, [5:8] :/ 7}; }

                value = 3. weightage = 4

                value = 5. weightage = 7/4 = 1.75
                value = 6. weightage = 7/4 = 1.75
                value = 7. weightage = 7/4 = 1.75
                value = 8. weightage = 7/4 = 1.75

-----------------using ":/" operator:

    1. For a specific value or range of value, the mentioned weight is assigned.
        -> constraint value_c {value dist {3:=4, [5:8] := 7}; }

                value = 3. weightage = 4

                value = 5. weightage = 7
                value = 6. weightage = 7
                value = 7. weightage = 7
                value = 8. weightage = 7
___________________________________________________________________

*/

class dist_key;

    rand bit[7:0] val;

    constraint c_dist {
        val dist {10:=2, 20:=2};    
        //val dist {10:=4, 20:=1};    
    }

    /* 
    _________________________________________

    probabilty check - 1:
        10 having a weightage of 4 / 10 = 0.4
        20 having a weightage of 1 / 20 = 0.05
        simulation :
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10

    probabilty check - 2:
        10 ----> 4 weightage
        20 ----> 1 weightage
        simulation : 
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 10
                # val : 20
    _________________________________________

    */

    function void post_randomize();
        $display("val : %0d", val);
    endfunction : post_randomize

endclass : dist_key

module top_dist();

    dist_key ds;

    initial begin
        ds = new();
        repeat(10)
            ds.randomize();
    end
endmodule : top_dist