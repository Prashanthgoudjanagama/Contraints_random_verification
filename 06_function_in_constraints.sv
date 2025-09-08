

// file name: 06_function_in_constraints.sv
// module name: top_func

class function_in;

    rand bit[7:0] a, b;
    rand bit[8:0] sum;

    constraint c_range {
        a inside {[10:30]};
        b inside {[50:70]};
    }

    constraint c_func{
        sum == add(a, b);
    }

    function int add(bit [7:0] d1, d2);
        return d1 + d2;
    endfunction : add

    function void post_randomize();
        $display("sum => %0d + %0d => %0d", a, b, sum);
    endfunction : post_randomize

endclass : function_in


module top_func();
    function_in fi;

    initial begin
        fi = new();

        $display("\n___________ function in constraints________________");
        repeat(3) begin
            assert(fi.randomize());
        end
    end

endmodule : top_func

/*
________________________________________________________________________________

    simulation results:
        # ___________ function in constraints________________

        # sum => 14 + 65 => 79
        # sum => 14 + 51 => 65
        # sum => 27 + 57 => 84

________________________________________________________________________________

*/