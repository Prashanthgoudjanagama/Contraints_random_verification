

//filename: 01_Basic_keywords_and_ranges.sv
//module : top_basic_constraints


/*
_______________________________________________________________________

Basic keywords and ranges in SystemVerilog

1. Basic Keywords:
   - `randc`: Random cyclic
   - `rand`: Random
   - `constraint`: Constraint block
   - `with`: With clause for constraints
   - `foreach`: Looping through arrays
   - `if`: Conditional statement
   - `else`: Else statement
   - `unique`: Unique constraint
   - `priority`: Priority constraint
   - `inside`: Inside constraint

2. Ranges:
   - `a[b:c]`: Range from b to c in array a
   - `a[b]`: Single element access
   - `a[b:c][d:e]`: Sub-range access
   - `a[b:c][d]`: Mixed range access

3. Constraints syntax:

    syntax: constraint <name> { <condition> / <expression> }

    examples using various ranges:
    _____________________________________________
        1. constraint c0 {
                value inside {40,50,60};                    // fixed variable 
            }
        
        2. constraint c1 {
                value inside {[25:40]};                  // [min:max] range variable
            }

        3. constraint c3 {
                value inside {30,35,50,[60:80],100};     // mixed variable
            }

        4. constraint c4 {
                value inside {[`start:`end]};            // range variable using `define
            }

        5. constraint c5 {
                value inside {value inside [p1:p2]};    // range using parameter
            }

        6. constraint c6 {
                !value inside {[10:20]};                // not in the range
            }
    _____________________________________________

_______________________________________________________________________

*/