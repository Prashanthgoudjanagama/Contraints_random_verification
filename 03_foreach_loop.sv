

// file: 03_foreach_loop.sv
// module : top_foreach_loop

class foreach_loop;

    rand bit [7:0] array [10];     //    |_7_|_6_|_5_|_4_|_3_|_2_|_1_|_0_|

    constraint c_range {
        foreach(array[i])
            array[i] inside {[0:20]};
    }

    // even location with odd num odd with even num
    constraint c_condn {
        foreach (array[i]) {
            if(i % 2 == 0)
                array[i] % 2 == 1;
            else 
                array[i] % 2 == 0;
        }
    }

    function void post_randomize();
        $display("\n____________ foreach _____________");
        foreach(array[i]) begin
            $display("array[%0d] = %0d", i, array[i]);
        end

        $display(" array : %0p", array);
    endfunction : post_randomize

endclass : foreach_loop


module top_foreach_loop();

    foreach_loop fl;

    initial begin
        fl = new();
        if(fl.randomize()) 
            $display("Randomization passed");
        else               
            $display("Randomization failed"); 
    end

endmodule : top_foreach_loop


/*
_____________________________________________________________________

simulation results:

        # ____________ foreach _____________
        # array[0] = 11
        # array[1] = 14
        # array[2] = 13
        # array[3] = 14
        # array[4] = 3
        # array[5] = 10
        # array[6] = 7
        # array[7] = 0
        #  array : 11 14 13 14 3 10 7 0
        # Randomization passed
_____________________________________________________________________

*/