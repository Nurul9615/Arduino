///////////////////////////////////////////////

// Design unit : fir9

// File name : fir9.sv

// Description : 9-tap digital FIR filter

// Author : Nurul Amin, UCL, zceenam@ucl.ac.uk

////////////////////////////////////////////////



module fir9(

 input logic clk, //Clock input

 input logic rst, //Reset input

 input logic [3:0]c[0:8],	//Filter co-efficients, there are 9 which are 4 bits each

 input logic [3:0]x,	//4 bit input signal

 input logic [10:0] thresh, //Threshold value to compare output to

 output logic y); //Output of circuit



 logic [3:0]x_internal[0:8];	//9 Internal registers containing the input value x

 logic [7:0]multi_output[0:8];	//Output when multiplying input registers by co-efficients

 logic [10:0]sum;	//Sum the 9 multiplied outputs

 logic [10:0]thresh_internal; //Internal register to contain thresh

 logic y_internal; //Internal y register to contain output



 always_ff@(posedge clk, posedge rst) begin  //Sequential logic that performs its code on the rising edge of clock/reset



 	if(rst) begin 

for(int i = 0; i < 9; i++) begin	//Count through 9 times for 9 registers

x_internal[i] <= 0;	//Reset all internal registers and output to zero if rst is pressed on the positive edge of cycle

multi_output[i] <= 0;

end

y <= 0;

thresh_internal <= 0;

end



else begin

x_internal[0] <= x;	//Load input value x into the first internal register



for(int i = 1; i < 9; i++) begin	//Pass on the x value to the rest of the 8 registers by looping through all 9 registers

x_internal[i] <= x_internal[i-1];

end



for(int i = 0; i < 9; i++) begin

multi_output[i] <= c[i] * x_internal[i];	//Set the multiplied output of each register by multiplying the co-efficients by each x input value

end



thresh_internal <= thresh;	//Set the output y to y_internal which depends on the thresh_internal

y = y_internal;

end

//Pipelining is used by splitting the multiplication and adding which increases the clock frequency but increases the total delay. So there is a shorter critical path for each block

 end



 always_comb begin //Combinational logic block which runs when any right hand side assignments change

sum = 0;

for(int i = 0; i < 9; i++) begin	//Sum all 9 multiplied outputs 

sum = sum + multi_output[i];

end



if(sum > thresh_internal) begin	//Set output 1 one if the sum is greater than the thresh

y_internal = 1;

end



else begin

y_internal = 0;

end

 end

 

 endmodule