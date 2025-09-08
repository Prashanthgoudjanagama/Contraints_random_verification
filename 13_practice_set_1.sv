


//----------------------------1.Basic constraint-------------------------------
class trans;
  rand bit[7:0] data;
  
  constraint data_range {data inside {[10:100]};}
  constraint data_cond {data % 2 == 0;}
  
  function void post_randomize();
      $display("data = %0d", data);
  endfunction
  
endclass

module tb1;
  trans tr;
  initial
    begin
      tr = new();
      repeat(10) begin
        tr.randomize();
      end
    end
  
endmodule

//--------------------------2.patterns_in_constraints--------------------------
//
//===>  i. 01010101  
//-----------------------------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 10;}
  constraint array_condn {foreach(array[i]) 
    			    if(i % 2 == 0)
                              array[i] == 0;
                            else
                              array[i] == 1;
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===> ii. 001100110011  
//--------------------------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 20;}
  constraint array_condn {foreach(array[i]) 
    			    if((i % 4 == 0) || (i % 4 == 1))
                              array[i] == 0;
                            else
                              array[i] == 1;
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===>  iii. 000111000111000111  
//------------------------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 21;}
  constraint array_condn {foreach(array[i]) 
                           if((i % 6 == 0) || (i % 6 == 1) || (i % 6 == 2))
                              array[i] == 0;
                           else
                              array[i] == 1;
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule


//===> iv. 0102030405 
//-------------------------------------------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 21;}
  constraint array_condn {foreach(array[i]) 
                            if(i % 2 == 0)
                              array[i] == 0;
                            else
                              array[i] == (i+1)/2;
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction

endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===> v. 02040608010  
//-----------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 21;}
  constraint array_condn {foreach(array[i]) 
                            if(i % 2 == 0)
                              array[i] == 0;
                            else
                              array[i] == (i+1);
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===> vi. 0103050709  
//------------------------------------------------------------
class trans;
  rand bit[7:0] array[];
  
  constraint array_size {array.size == 21;}
  constraint array_condn {foreach(array[i]) 
                            if(i % 2 == 0)
                              array[i] == 0;
                            else
                              array[i] == i;
                          }
  
  function void post_randomize();
    $display("array = %0p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===> vii. -5 10 -15 20 -25 30
//------------------------------------------------------------
class trans;
  rand int array[];
  
  constraint array_size {array.size == 20;}
  constraint array_condn {foreach(array[i]) 
                            if(i % 2 == 0)
                              array[i] == (-5) * (i+1);
                            else
                              array[i] == (i+1) * 5;
                          }
  
  function void post_randomize();
    $display("array = %p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule



//===> viii. 9 19 29 39 49 59 69 79
//------------------------------------------------------------------------------
class trans;
  rand int array[];
  
  constraint array_size {array.size == 10;}
  constraint array_condn {foreach(array[i]) 
                            array[i] = 9 *(i+1);
                         }
  
  function void post_randomize();
    $display("array = %p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule

//===> ix. 1 2 3 4 5 4 3 2 1 0
//------------------------------------------------------------------------------
class trans;
  rand int array[];
  
  constraint array_size {array.size == 10;}
  constraint array_condn {foreach(array[i]) 
                            if(i < 5)
                              array[i] == i + 1;
                            else
                              array[i] == 10 - i;
                          }
  
  function void post_randomize();
    $display("array = %p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule


//===> x. 1122334455
//----------------------------------------------------------------------
class trans;
  rand int array[];
  
  constraint array_size {array.size == 20;}
  constraint array_condn {foreach(array[i]) 
                            array[i] == (i+2)/2;
                          }
  
  function void post_randomize();
    $display("array = %p", array);
  endfunction
endclass

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule


//===> xi. 122112211221
//----------------------------------------------------------------------------
class trans;
  rand bit[31:0] data[];
  
  constraint data_s {
    data.size == 12;
  }
  
  constraint data_c {
    foreach(data[i])
      if((i%4 == 0) || (i%4 == 3))
        data[i] == 1;
      else
        data[i] == 2;
  }
  
  
  function void post_randomize();
    $display("data ---> %0p", data);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//--------------------------------------------------------------------------------------------------------------
//------>Q3. Write a code to generate random number between 1.35 and 2.57?
//----------------------------------------------------------------------------------
class trans;
  rand int data;
  real num;
  	
  constraint data_size {data inside {[135:257]};}
  
  function void post_randomize();
    num = data / 100.0;
    $display("num = %0f", num);			
  endfunction
  
endclass 


module tb;
  trans tr;
  
  initial begin:
    tr = new();
    repeat(10) begin
      tr.randomize();
    end
  end
  
endmodule


//---------------------->Q4. Write a constraint to generate a random even number between 50 and 100?
//--------------------------------------------------------------------------------------------------
class trans;
  rand int data[];
  
  constraint data_size {data.size == 20;}
  constraint data_condn {foreach(data[i]) {
   		           data[i] inside {[50:100]};
    			   data[i] % 2 == 0;
 				          }     
                        }
  
  function void post_randomize();
                         $display("data = %0p", data);
  endfunction
  
endclass 


module tb;
  trans tr;
  
  initial begin
    tr = new();
    repeat(10) begin
      tr.randomize();
    end
  end
  
endmodule



//---------------------->Q5. Write a constraint to generate a random even & odd number between 20 and 100?
//-------------------------------------------------------------------------------------------------------
class trans;
  rand int even[];
  rand int odd[];
   
  constraint arr_size {even.size == 20;
                        odd.size == 20;}
  
  constraint arr_range {
    foreach(even[i])
      even[i] inside {[20:100]};
    foreach(odd[i])
      odd[i] inside {[20:100]};
                       }
  
  constraint arr_condn {
    foreach(even[i]) 
      even[i] % 2 == 0;
    foreach(odd[i])
      odd[i] % 2 == 1;
                        }
  
  function void post_randomize();
    $display("even = %0p", even);
    $display("odd = %0p", odd);
  endfunction
  
endclass 


module tb;
  trans tr;
  
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule




//-------------->Q6. Write a constraint such that even locations contains odd numbers and odd locations contains even numbers ?
//-------------------------------------------------------------------------------------------------------------------------------
class trans;
  rand bit[7:0] data[];
  
  constraint data_size {
    data.size == 20;
  }
  
  constraint data_cond {
    foreach(data[i])
      if(i % 2 == 0)
        data[i] % 2 == 1;
      else
        data[i] % 2 == 0;
  }
  
  function void post_randomize();
    foreach(data[i])
      $display("data --> %0d : %0d", i, data[i]);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//----->Q7.Write a for a 32 bit rand variable such that it should have 16 number of 1's non consecutively.
//----------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] data;
  
  constraint data_c {
    $countones(data) == 16;
  }
  
  constraint data_s {
    foreach(data[i])
      if(i > 0 && data[i] == 1)
        data[i] != data[i-1];
  }
  
  function void post_randomize();
    $display("data = %0b", data);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//----->Q8. Write a constraint to genarate FACTORIAL of first 10 numbers ?
//----------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] data[];
  
  constraint data_s {
    data.size == 10;
  }
  
  function int fact(int i);
    if(i <= 1)
      fact = 1;
    else
      fact = i * fact(i - 1);
  endfunction
  
  constraint data_c {
    foreach(data[j])
      data[j] == fact(j);
  }
  
  
  function void post_randomize();
    foreach(data[k])
      $display("data ---> %0d : %0d", k, data[k]);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule

 
//----->Q9. Write a constraint to genarate FACTORIAL of first 5 even numbers ?
//----------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] data[];
  
  constraint data_s {
    data.size == 5;
  }
  
  function int fact(int i);
    if(i <= 1)
      fact = 1;
    else
      fact = i * fact(i - 1);
  endfunction
  
  constraint data_c {
    foreach(data[j])
      data[j] == fact(j * 2);
  }
  
  
  function void post_randomize();
    foreach(data[k])
      $display("data ---> %0d : %0d", k*2, data[k]);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//----->Q10. Write a constraint to genarate FACTORIAL of first 5 odd numbers ?
//----------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] data[];
  
  constraint data_s {
    data.size == 5;
  }
  
  function int fact(int i);
    if(i <= 1)
      fact = 1;
    else
      fact = i * fact(i - 1);
  endfunction
  
  constraint data_c {
    foreach(data[j])
      data[j] == fact((j*2)+1);
  }
  
  
  function void post_randomize();
    foreach(data[k])
      $display("data ---> %0d : %0d", (k*2)+1, data[k]);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//----->Q11. Write a SystemVerilog program to randomize a 32-bit variable, but only randomize the 20th bit?.
//----------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] num;
  
  constraint data_c {
    foreach(num[i])
      if(i == 19)
        num[i] inside {[0:1]};
      else
        num[i] == 0;
  }
  
  function void post_randomize();
    $display("num = %b", num);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      repeat(20) begin
        tr.randomize();
      end
    end
endmodule


//----->Q11..Write a constraint such that sum of any three consecutive elements in an array should be an even number ?
//--------------------------------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] data[];
  
  constraint data_s {
    data.size == 12;
  }
  
  constraint dat_range {
    foreach(data[i])
      data[i] inside {[50:100]};
  }
  
  constraint data_c {
    foreach(data[i])
      if(i > 1)
        (data[i] + data[i-1] + data[i-2]) % 2 == 0;
  }
  
  
  function void post_randomize();
    foreach(data[i])
      $display("data ---> %0d : %0d", i, data[i]);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//--->Q12. Write a constraint on a 16 bit num to generate alternate pairs of 0's and 1's (Ex:0011.. or 1100) ?
//--------------------------------------------------------------------------------------------------------------------------
class trans;
  rand bit[15:0] data;
  
  constraint data_c {
    foreach(data[i])
      if(i < 15)
      if(i % 2 == 0)
        data[i + 1] == data[i];
      else
        data[i] != data[i+1];
  }
  
  
  function void post_randomize();
    $display("data ---> %0b", data);
  endfunction
  
endclass


module tb;
  trans tr;
  initial
    begin
      tr = new();
      tr.randomize();
    end
endmodule


//---> Q13. Star pattern Quetions:
//----------------------------------------------------------------------------------------------
// Qi.1
// 		11
// 		111
// 		1111
// 		11111
// 		111111
// 		1111111
// 		11111111
// 		111111111
// 		1111111111


class trans;
//   rand bit a;
  rand bit[31:0] a[];
  
  constraint a_size{
    a.size == 10; 
  }
  
  constraint a_c {
    foreach(a[i])
      a[i] == 2**(i+1) -1;    ////1 11 111 1111 11111 111111 1111111
  }
  
  function void post_randomize();
    foreach(a[i])
      $display("%0b", a[i]);
  endfunction : post_randomize
  
//   function void post_randomize();
//     for(int i = 0; i < 10; i++) begin
//       for(int j = 0; j <= i; j++) begin
//         a = 1;
//         $write("%0p", a);
//       end
//       $display("");
//     end
//   endfunction : post_randomize
  
endclass : trans

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule : tb



//---------------------------------------------------------------------------------------
//---> Qii.1
//				12
//				123
//				1234
//				12345
//				123456
//				1234567
//				12345678
//				123456789

class trans;
  rand bit[31:0] a;
  
  constraint a_range {a inside {[0:9]};}
  
  function void post_randomize();
    for(int i = 0; i < 10; i++) begin
      for(int j = 0; j < i; j++) begin
        a = j+1;
        $write("%0d", a);
      end
      $display("");
    end
  endfunction : post_randomize
  
endclass : trans

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule : tb


//--------------------------------------------------------------------------------
//---> Qiii.		
//      1 2 3 4 5 6 7 8 9 10
//			1 2 3 4 5 6 7 8 9
//			1 2 3 4 5 6 7 8
//			1 2 3 4 5 6 7
//			1 2 3 4 5 6
//			1 2 3 4 5
//			1 2 3 4
//			1 2 3 
//			1 2 
//			1


class trans;
  rand bit[31:0] a;
  
  constraint a_range {a inside {[0:10]};}
  
  function void post_randomize();
    for(int i = 10; i > 0; i--) begin
      for(int j = 0; j < i; j++) begin
        a = j+1;
        $write("%0d ", a);
      end
      $display("");
    end
  endfunction : post_randomize
  
endclass : trans

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule : tb




//---> Q14. write a constraint to Generate a asscending order :
//-------------------------------------------------------------------------------------------
class trans;
  rand bit[31:0] a[];
  
  constraint a_size {
    a.size == 10;
  }
  
  constraint a_range {
    foreach(a[i])
      a[i] inside {[0:100]};
  }
  
  constraint a_con {
    foreach(a[i])
        if(i > 0)
           a[i] > a[i-1];
         //  a[i] < a[i-1];    
  }
  
  function void post_randomize();
    $display("a = %0p", a);
  endfunction : post_randomize
  
endclass : trans
  

module tb;
  trans tr;
  initial begin
    tr = new();
    tr.randomize();
  end
  
endmodule : tb
