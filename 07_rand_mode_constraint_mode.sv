

//file name : 07_rand_mode_constraint_mode.sv
//module name : top_disable_rand

/*
_____________________________________________________________________________________

    rand_mode and constraint_mode:

    ->  rand_mode()  ______________________> 1 - enable
                            |
                            |______________> 0 - disable

    ->  constraint_mode() _________________> 1 - enable
                                    |
                                    |______> 0 - disable

    -> by default all are enabled.

_____________________________________________________________________________________

*/

//______________________ disabling perticuler variable randomization __________________________

class rand_mode_ex;

    rand int a, b;

    constraint c_range{
        a inside {[10:20]};
        b inside {[50:70]};
    }

    constraint a_condn{
        a % 5 == 0;
        b % 5 == 0;
    }

    function void post_randomize();
        $display("\t\ta => %0d | b => %0d", a, b);
    endfunction : post_randomize

endclass : rand_mode_ex

module top_rand_mode();

    rand_mode_ex rm;

    initial begin
        $display("\n____________ Randomization Before Rand mode ________________");

        rm = new();
        repeat(2) begin
            rm.randomize();
        end

        $display("\n____________ Randomization After Rand mode -0 ________________");
        rm.rand_mode(0);      // disabling randomization for all the rand variables
        repeat(2) begin
            rm.randomize();
        end

        $display("\n____________ Randomization After Rand mode -1 ________________");
        rm.rand_mode(1);      // enabling randomization for all the rand variables
        repeat(2) begin
            rm.randomize();
        end
    end

endmodule : top_rand_mode

/*
______________________________________________________________________________
    simulation results:

    for rand_mode():

            # ____________ Randomization Before Rand mode ________________
            # 		a => 15 | b => 65
            # 		a => 20 | b => 55
            # 
            # ____________ Randomization After Rand mode -0 ________________
            # 		a => 20 | b => 55
            # 		a => 20 | b => 55
            # 
            # ____________ Randomization After Rand mode -1 ________________
            # 		a => 10 | b => 65
            # 		a => 15 | b => 55

    obeservation:
        case -1: rand_mode:
        ___________________
                    1. default it is enable.
                    2. after disabling, it retains the last randomized values.
                    3. after enabling, it re-randomizes the values.

________________________________________________________________________________
*/

class constraint_mode_ex;

    rand int d1, d2;

    constraint c_range_cm{
        d1 inside {[10:20]};
        d2 inside {[50:70]};
    }

    constraint a_condn_cm{
        d1 % 5 == 0;
        d2 % 5 == 0;
    }

    function void post_randomize();
        $display("\t\td1 => %0d | d2 => %0d", d1, d2);
    endfunction : post_randomize

endclass : constraint_mode_ex

module top_constraint_mode();

    constraint_mode_ex cm;

    initial begin
        $display("\n____________ Randomization Before Constraint mode ________________");

        cm = new();
        repeat(2) begin
            cm.randomize();
        end

        $display("\n____________ Randomization After Constraint mode -0 ________________");
        cm.a_condn_cm.constraint_mode(0);      // disabling randomization for "a_condn_cm"
        repeat(2) begin
            cm.randomize();
        end

        $display("\n____________ Randomization After Constraint mode -1 ________________");
        cm.a_condn_cm.constraint_mode(1);      // enabling randomization for "a_condn_cm"
        repeat(2) begin
            cm.randomize();
        end
    end

endmodule : top_constraint_mode
/*
________________________________________________________________________________________________
    simulation results:

    for constraint mode:

            # ____________ Randomization Before Constraint mode ________________
            # 		d1 => 20 | d2 => 60
            # 		d1 => 10 | d2 => 55
            # 
            # ____________ Randomization After Constraint mode -0 ________________
            # 		d1 => 12 | d2 => 58
            # 		d1 => 20 | d2 => 70
            # 
            # ____________ Randomization After Constraint mode -1 ________________
            # 		d1 => 15 | d2 => 70
            # 		d1 => 10 | d2 => 55

        observation:
        ___________________
            1. default it is enable.
            2. after disabling, it will not consider the constraint and gives different values.
            3. after enabling, it re-applies the constraint.

________________________________________________________________________________________________
*/


module top_disable_rand();

    //top_disable_rand trm();
    top_constraint_mode tcm();

endmodule : top_disable_rand