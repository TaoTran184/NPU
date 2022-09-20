module arb_rtl_cp # (
  parameter NUM_AGENTS=2
  )
(
 input clk,
 input rst,
 input [NUM_AGENTS-1:0] req,
 input [NUM_AGENTS-1:0] ack
);


`ifndef DISABLE_RTL_CP
genvar k;
integer i;
property prop_req1_ack01     (i); @(posedge clk) disable iff (rst) !ack[i] |-> ##1 req[i] |-> ##0  ack[i]                                                              ; endproperty
property prop_req11_ack001   (i); @(posedge clk) disable iff (rst) !ack[i] |-> ##1 req[i] |-> ##0 !ack[i] |-> ##1 req[i] |-> ##0  ack[i]                               ; endproperty
property prop_req111_ack0001 (i); @(posedge clk) disable iff (rst) !ack[i] |-> ##1 req[i] |-> ##0 !ack[i] |-> ##1 req[i] |-> ##0 !ack[i] |-> ##1 req[i] |-> ##0 ack[i] ; endproperty
property prop_req_all_ack    (i); @(posedge clk) disable iff (rst) &req && (ack[i])                                                                                    ; endproperty

generate for(k=0; k<NUM_AGENTS; k=k+1)begin
  bp_cp_arb_req1_ack01      : cover property (prop_req1_ack01    (k)); 
  bp_cp_arb_req11_ack001    : cover property (prop_req11_ack001  (k)); 
  bp_cp_arb_req111_ack0001  : cover property (prop_req111_ack0001(k)); 
  bp_cp_arb_req_all_ack     : cover property (prop_req_all_ack   (k)); 
end
endgenerate
`endif

endmodule

    
   
