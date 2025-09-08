

// file name : 12_Randomization_methods.sv
// module : top_randomization_methods

/*
_________________________________________________________________


                +-------------------+      -> Disable constraints
                |   pre_randomize() |      -> Disable randomization
                +-------------------+
                        |
                        v
                +-------------------+      -> Random
                |    randomize()    |
                +-------------------+
                        |
                        v
                +-------------------+      -> Printing randomized values
                | post_randomize()  |      -> of class variables
                +-------------------+


_________________________________________________________________
*/