

// file name : 02_control_flow.sv
// module name : top_control_flow


class control_flow;

    rand bit [7:0] data;
    randc bit [3:0] addr;

    constraint c_range {
        addr inside {[0:5]};
        data inside {10, 20, 30, 19};
    }

    // constraint  c_condn_operator {
    //     data == (addr == 3) ? 30 : 40;
    // }

    constraint c_if_else {
        if(addr == 0) 
            data == 10;
        else if(addr == 1 | addr == 2) 
            data == 20;
        else 
            data == 30;
    }

    function void post_randomize();
        $display("\taddr = %0d | data = %0d", addr, data);
    endfunction : post_randomize

endclass : control_flow

module top_if_else();

    control_flow cf;

    initial begin
        cf = new();
        $display("\n___________if else_if else_________________");
        repeat(10) begin
            cf.randomize();
        end
    end
endmodule : top_if_else

// ______________________________________________________________________________

class implication_oper;
    rand bit [7:0] value;
    randc enum {LOW, HIGH} scale;

    constraint scale_c { 
        (scale == LOW) -> value <50; 
    }

    function void post_randomize();
        $display("\tscale = %s, value = %0d", scale.name(), value);
    endfunction
endclass

module impli_oper;
  implication_oper item;
  
  initial begin
    item = new();
        
    $display("\n___________implication operator_________________");
    repeat(5) begin
      item.randomize();
    end
  end
endmodule

module top_control_flow();

    top_if_else tp();
    impli_oper ip();

endmodule : top_control_flow


/*
_________________________________________________
simulation results:

    # ___________if else_if else_________________
    # 	addr = 0 | data = 10
    # 	addr = 3 | data = 30
    # 	addr = 1 | data = 20
    # 	addr = 5 | data = 30
    # 	addr = 2 | data = 20
    # 	addr = 4 | data = 30
    # 	addr = 5 | data = 30
    # 	addr = 1 | data = 20
    # 	addr = 3 | data = 30
    # 	addr = 0 | data = 10
    # 
    # ___________implication operator_________________
    # 	scale = HIGH, value = 38
    # 	scale = LOW, value = 12
    # 	scale = HIGH, value = 215
    # 	scale = LOW, value = 13
    # 	scale = HIGH, value = 63

_________________________________________________
*/