//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module KEY2_s1_arbitrator (
                            // inputs:
                             KEY2_s1_irq,
                             KEY2_s1_readdata,
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_read,
                             cpu_data_master_waitrequest,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,

                            // outputs:
                             KEY2_s1_address,
                             KEY2_s1_chipselect,
                             KEY2_s1_irq_from_sa,
                             KEY2_s1_readdata_from_sa,
                             KEY2_s1_reset_n,
                             KEY2_s1_write_n,
                             KEY2_s1_writedata,
                             cpu_data_master_granted_KEY2_s1,
                             cpu_data_master_qualified_request_KEY2_s1,
                             cpu_data_master_read_data_valid_KEY2_s1,
                             cpu_data_master_requests_KEY2_s1,
                             d1_KEY2_s1_end_xfer
                          )
;

  output  [  1: 0] KEY2_s1_address;
  output           KEY2_s1_chipselect;
  output           KEY2_s1_irq_from_sa;
  output  [ 31: 0] KEY2_s1_readdata_from_sa;
  output           KEY2_s1_reset_n;
  output           KEY2_s1_write_n;
  output  [ 31: 0] KEY2_s1_writedata;
  output           cpu_data_master_granted_KEY2_s1;
  output           cpu_data_master_qualified_request_KEY2_s1;
  output           cpu_data_master_read_data_valid_KEY2_s1;
  output           cpu_data_master_requests_KEY2_s1;
  output           d1_KEY2_s1_end_xfer;
  input            KEY2_s1_irq;
  input   [ 31: 0] KEY2_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] KEY2_s1_address;
  wire             KEY2_s1_allgrants;
  wire             KEY2_s1_allow_new_arb_cycle;
  wire             KEY2_s1_any_bursting_master_saved_grant;
  wire             KEY2_s1_any_continuerequest;
  wire             KEY2_s1_arb_counter_enable;
  reg     [  1: 0] KEY2_s1_arb_share_counter;
  wire    [  1: 0] KEY2_s1_arb_share_counter_next_value;
  wire    [  1: 0] KEY2_s1_arb_share_set_values;
  wire             KEY2_s1_beginbursttransfer_internal;
  wire             KEY2_s1_begins_xfer;
  wire             KEY2_s1_chipselect;
  wire             KEY2_s1_end_xfer;
  wire             KEY2_s1_firsttransfer;
  wire             KEY2_s1_grant_vector;
  wire             KEY2_s1_in_a_read_cycle;
  wire             KEY2_s1_in_a_write_cycle;
  wire             KEY2_s1_irq_from_sa;
  wire             KEY2_s1_master_qreq_vector;
  wire             KEY2_s1_non_bursting_master_requests;
  wire    [ 31: 0] KEY2_s1_readdata_from_sa;
  reg              KEY2_s1_reg_firsttransfer;
  wire             KEY2_s1_reset_n;
  reg              KEY2_s1_slavearbiterlockenable;
  wire             KEY2_s1_slavearbiterlockenable2;
  wire             KEY2_s1_unreg_firsttransfer;
  wire             KEY2_s1_waits_for_read;
  wire             KEY2_s1_waits_for_write;
  wire             KEY2_s1_write_n;
  wire    [ 31: 0] KEY2_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_KEY2_s1;
  wire             cpu_data_master_qualified_request_KEY2_s1;
  wire             cpu_data_master_read_data_valid_KEY2_s1;
  wire             cpu_data_master_requests_KEY2_s1;
  wire             cpu_data_master_saved_grant_KEY2_s1;
  reg              d1_KEY2_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_KEY2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_KEY2_s1_from_cpu_data_master;
  wire             wait_for_KEY2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~KEY2_s1_end_xfer;
    end


  assign KEY2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_KEY2_s1));
  //assign KEY2_s1_readdata_from_sa = KEY2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY2_s1_readdata_from_sa = KEY2_s1_readdata;

  assign cpu_data_master_requests_KEY2_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1850) & (cpu_data_master_read | cpu_data_master_write);
  //KEY2_s1_arb_share_counter set values, which is an e_mux
  assign KEY2_s1_arb_share_set_values = 1;

  //KEY2_s1_non_bursting_master_requests mux, which is an e_mux
  assign KEY2_s1_non_bursting_master_requests = cpu_data_master_requests_KEY2_s1;

  //KEY2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign KEY2_s1_any_bursting_master_saved_grant = 0;

  //KEY2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign KEY2_s1_arb_share_counter_next_value = KEY2_s1_firsttransfer ? (KEY2_s1_arb_share_set_values - 1) : |KEY2_s1_arb_share_counter ? (KEY2_s1_arb_share_counter - 1) : 0;

  //KEY2_s1_allgrants all slave grants, which is an e_mux
  assign KEY2_s1_allgrants = |KEY2_s1_grant_vector;

  //KEY2_s1_end_xfer assignment, which is an e_assign
  assign KEY2_s1_end_xfer = ~(KEY2_s1_waits_for_read | KEY2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_KEY2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_KEY2_s1 = KEY2_s1_end_xfer & (~KEY2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //KEY2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign KEY2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_KEY2_s1 & KEY2_s1_allgrants) | (end_xfer_arb_share_counter_term_KEY2_s1 & ~KEY2_s1_non_bursting_master_requests);

  //KEY2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY2_s1_arb_share_counter <= 0;
      else if (KEY2_s1_arb_counter_enable)
          KEY2_s1_arb_share_counter <= KEY2_s1_arb_share_counter_next_value;
    end


  //KEY2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY2_s1_slavearbiterlockenable <= 0;
      else if ((|KEY2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_KEY2_s1) | (end_xfer_arb_share_counter_term_KEY2_s1 & ~KEY2_s1_non_bursting_master_requests))
          KEY2_s1_slavearbiterlockenable <= |KEY2_s1_arb_share_counter_next_value;
    end


  //cpu/data_master KEY2/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = KEY2_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //KEY2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign KEY2_s1_slavearbiterlockenable2 = |KEY2_s1_arb_share_counter_next_value;

  //cpu/data_master KEY2/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = KEY2_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //KEY2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign KEY2_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_KEY2_s1 = cpu_data_master_requests_KEY2_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //KEY2_s1_writedata mux, which is an e_mux
  assign KEY2_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_KEY2_s1 = cpu_data_master_qualified_request_KEY2_s1;

  //cpu/data_master saved-grant KEY2/s1, which is an e_assign
  assign cpu_data_master_saved_grant_KEY2_s1 = cpu_data_master_requests_KEY2_s1;

  //allow new arb cycle for KEY2/s1, which is an e_assign
  assign KEY2_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign KEY2_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign KEY2_s1_master_qreq_vector = 1;

  //KEY2_s1_reset_n assignment, which is an e_assign
  assign KEY2_s1_reset_n = reset_n;

  assign KEY2_s1_chipselect = cpu_data_master_granted_KEY2_s1;
  //KEY2_s1_firsttransfer first transaction, which is an e_assign
  assign KEY2_s1_firsttransfer = KEY2_s1_begins_xfer ? KEY2_s1_unreg_firsttransfer : KEY2_s1_reg_firsttransfer;

  //KEY2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign KEY2_s1_unreg_firsttransfer = ~(KEY2_s1_slavearbiterlockenable & KEY2_s1_any_continuerequest);

  //KEY2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY2_s1_reg_firsttransfer <= 1'b1;
      else if (KEY2_s1_begins_xfer)
          KEY2_s1_reg_firsttransfer <= KEY2_s1_unreg_firsttransfer;
    end


  //KEY2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign KEY2_s1_beginbursttransfer_internal = KEY2_s1_begins_xfer;

  //~KEY2_s1_write_n assignment, which is an e_mux
  assign KEY2_s1_write_n = ~(cpu_data_master_granted_KEY2_s1 & cpu_data_master_write);

  assign shifted_address_to_KEY2_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //KEY2_s1_address mux, which is an e_mux
  assign KEY2_s1_address = shifted_address_to_KEY2_s1_from_cpu_data_master >> 2;

  //d1_KEY2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_KEY2_s1_end_xfer <= 1;
      else 
        d1_KEY2_s1_end_xfer <= KEY2_s1_end_xfer;
    end


  //KEY2_s1_waits_for_read in a cycle, which is an e_mux
  assign KEY2_s1_waits_for_read = KEY2_s1_in_a_read_cycle & KEY2_s1_begins_xfer;

  //KEY2_s1_in_a_read_cycle assignment, which is an e_assign
  assign KEY2_s1_in_a_read_cycle = cpu_data_master_granted_KEY2_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = KEY2_s1_in_a_read_cycle;

  //KEY2_s1_waits_for_write in a cycle, which is an e_mux
  assign KEY2_s1_waits_for_write = KEY2_s1_in_a_write_cycle & 0;

  //KEY2_s1_in_a_write_cycle assignment, which is an e_assign
  assign KEY2_s1_in_a_write_cycle = cpu_data_master_granted_KEY2_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = KEY2_s1_in_a_write_cycle;

  assign wait_for_KEY2_s1_counter = 0;
  //assign KEY2_s1_irq_from_sa = KEY2_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY2_s1_irq_from_sa = KEY2_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //KEY2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module KEY3_s1_arbitrator (
                            // inputs:
                             KEY3_s1_irq,
                             KEY3_s1_readdata,
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_read,
                             cpu_data_master_waitrequest,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,

                            // outputs:
                             KEY3_s1_address,
                             KEY3_s1_chipselect,
                             KEY3_s1_irq_from_sa,
                             KEY3_s1_readdata_from_sa,
                             KEY3_s1_reset_n,
                             KEY3_s1_write_n,
                             KEY3_s1_writedata,
                             cpu_data_master_granted_KEY3_s1,
                             cpu_data_master_qualified_request_KEY3_s1,
                             cpu_data_master_read_data_valid_KEY3_s1,
                             cpu_data_master_requests_KEY3_s1,
                             d1_KEY3_s1_end_xfer
                          )
;

  output  [  1: 0] KEY3_s1_address;
  output           KEY3_s1_chipselect;
  output           KEY3_s1_irq_from_sa;
  output  [ 31: 0] KEY3_s1_readdata_from_sa;
  output           KEY3_s1_reset_n;
  output           KEY3_s1_write_n;
  output  [ 31: 0] KEY3_s1_writedata;
  output           cpu_data_master_granted_KEY3_s1;
  output           cpu_data_master_qualified_request_KEY3_s1;
  output           cpu_data_master_read_data_valid_KEY3_s1;
  output           cpu_data_master_requests_KEY3_s1;
  output           d1_KEY3_s1_end_xfer;
  input            KEY3_s1_irq;
  input   [ 31: 0] KEY3_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] KEY3_s1_address;
  wire             KEY3_s1_allgrants;
  wire             KEY3_s1_allow_new_arb_cycle;
  wire             KEY3_s1_any_bursting_master_saved_grant;
  wire             KEY3_s1_any_continuerequest;
  wire             KEY3_s1_arb_counter_enable;
  reg     [  1: 0] KEY3_s1_arb_share_counter;
  wire    [  1: 0] KEY3_s1_arb_share_counter_next_value;
  wire    [  1: 0] KEY3_s1_arb_share_set_values;
  wire             KEY3_s1_beginbursttransfer_internal;
  wire             KEY3_s1_begins_xfer;
  wire             KEY3_s1_chipselect;
  wire             KEY3_s1_end_xfer;
  wire             KEY3_s1_firsttransfer;
  wire             KEY3_s1_grant_vector;
  wire             KEY3_s1_in_a_read_cycle;
  wire             KEY3_s1_in_a_write_cycle;
  wire             KEY3_s1_irq_from_sa;
  wire             KEY3_s1_master_qreq_vector;
  wire             KEY3_s1_non_bursting_master_requests;
  wire    [ 31: 0] KEY3_s1_readdata_from_sa;
  reg              KEY3_s1_reg_firsttransfer;
  wire             KEY3_s1_reset_n;
  reg              KEY3_s1_slavearbiterlockenable;
  wire             KEY3_s1_slavearbiterlockenable2;
  wire             KEY3_s1_unreg_firsttransfer;
  wire             KEY3_s1_waits_for_read;
  wire             KEY3_s1_waits_for_write;
  wire             KEY3_s1_write_n;
  wire    [ 31: 0] KEY3_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_KEY3_s1;
  wire             cpu_data_master_qualified_request_KEY3_s1;
  wire             cpu_data_master_read_data_valid_KEY3_s1;
  wire             cpu_data_master_requests_KEY3_s1;
  wire             cpu_data_master_saved_grant_KEY3_s1;
  reg              d1_KEY3_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_KEY3_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_KEY3_s1_from_cpu_data_master;
  wire             wait_for_KEY3_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~KEY3_s1_end_xfer;
    end


  assign KEY3_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_KEY3_s1));
  //assign KEY3_s1_readdata_from_sa = KEY3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY3_s1_readdata_from_sa = KEY3_s1_readdata;

  assign cpu_data_master_requests_KEY3_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1860) & (cpu_data_master_read | cpu_data_master_write);
  //KEY3_s1_arb_share_counter set values, which is an e_mux
  assign KEY3_s1_arb_share_set_values = 1;

  //KEY3_s1_non_bursting_master_requests mux, which is an e_mux
  assign KEY3_s1_non_bursting_master_requests = cpu_data_master_requests_KEY3_s1;

  //KEY3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign KEY3_s1_any_bursting_master_saved_grant = 0;

  //KEY3_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign KEY3_s1_arb_share_counter_next_value = KEY3_s1_firsttransfer ? (KEY3_s1_arb_share_set_values - 1) : |KEY3_s1_arb_share_counter ? (KEY3_s1_arb_share_counter - 1) : 0;

  //KEY3_s1_allgrants all slave grants, which is an e_mux
  assign KEY3_s1_allgrants = |KEY3_s1_grant_vector;

  //KEY3_s1_end_xfer assignment, which is an e_assign
  assign KEY3_s1_end_xfer = ~(KEY3_s1_waits_for_read | KEY3_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_KEY3_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_KEY3_s1 = KEY3_s1_end_xfer & (~KEY3_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //KEY3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign KEY3_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_KEY3_s1 & KEY3_s1_allgrants) | (end_xfer_arb_share_counter_term_KEY3_s1 & ~KEY3_s1_non_bursting_master_requests);

  //KEY3_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY3_s1_arb_share_counter <= 0;
      else if (KEY3_s1_arb_counter_enable)
          KEY3_s1_arb_share_counter <= KEY3_s1_arb_share_counter_next_value;
    end


  //KEY3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY3_s1_slavearbiterlockenable <= 0;
      else if ((|KEY3_s1_master_qreq_vector & end_xfer_arb_share_counter_term_KEY3_s1) | (end_xfer_arb_share_counter_term_KEY3_s1 & ~KEY3_s1_non_bursting_master_requests))
          KEY3_s1_slavearbiterlockenable <= |KEY3_s1_arb_share_counter_next_value;
    end


  //cpu/data_master KEY3/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = KEY3_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //KEY3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign KEY3_s1_slavearbiterlockenable2 = |KEY3_s1_arb_share_counter_next_value;

  //cpu/data_master KEY3/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = KEY3_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //KEY3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign KEY3_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_KEY3_s1 = cpu_data_master_requests_KEY3_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //KEY3_s1_writedata mux, which is an e_mux
  assign KEY3_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_KEY3_s1 = cpu_data_master_qualified_request_KEY3_s1;

  //cpu/data_master saved-grant KEY3/s1, which is an e_assign
  assign cpu_data_master_saved_grant_KEY3_s1 = cpu_data_master_requests_KEY3_s1;

  //allow new arb cycle for KEY3/s1, which is an e_assign
  assign KEY3_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign KEY3_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign KEY3_s1_master_qreq_vector = 1;

  //KEY3_s1_reset_n assignment, which is an e_assign
  assign KEY3_s1_reset_n = reset_n;

  assign KEY3_s1_chipselect = cpu_data_master_granted_KEY3_s1;
  //KEY3_s1_firsttransfer first transaction, which is an e_assign
  assign KEY3_s1_firsttransfer = KEY3_s1_begins_xfer ? KEY3_s1_unreg_firsttransfer : KEY3_s1_reg_firsttransfer;

  //KEY3_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign KEY3_s1_unreg_firsttransfer = ~(KEY3_s1_slavearbiterlockenable & KEY3_s1_any_continuerequest);

  //KEY3_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY3_s1_reg_firsttransfer <= 1'b1;
      else if (KEY3_s1_begins_xfer)
          KEY3_s1_reg_firsttransfer <= KEY3_s1_unreg_firsttransfer;
    end


  //KEY3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign KEY3_s1_beginbursttransfer_internal = KEY3_s1_begins_xfer;

  //~KEY3_s1_write_n assignment, which is an e_mux
  assign KEY3_s1_write_n = ~(cpu_data_master_granted_KEY3_s1 & cpu_data_master_write);

  assign shifted_address_to_KEY3_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //KEY3_s1_address mux, which is an e_mux
  assign KEY3_s1_address = shifted_address_to_KEY3_s1_from_cpu_data_master >> 2;

  //d1_KEY3_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_KEY3_s1_end_xfer <= 1;
      else 
        d1_KEY3_s1_end_xfer <= KEY3_s1_end_xfer;
    end


  //KEY3_s1_waits_for_read in a cycle, which is an e_mux
  assign KEY3_s1_waits_for_read = KEY3_s1_in_a_read_cycle & KEY3_s1_begins_xfer;

  //KEY3_s1_in_a_read_cycle assignment, which is an e_assign
  assign KEY3_s1_in_a_read_cycle = cpu_data_master_granted_KEY3_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = KEY3_s1_in_a_read_cycle;

  //KEY3_s1_waits_for_write in a cycle, which is an e_mux
  assign KEY3_s1_waits_for_write = KEY3_s1_in_a_write_cycle & 0;

  //KEY3_s1_in_a_write_cycle assignment, which is an e_assign
  assign KEY3_s1_in_a_write_cycle = cpu_data_master_granted_KEY3_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = KEY3_s1_in_a_write_cycle;

  assign wait_for_KEY3_s1_counter = 0;
  //assign KEY3_s1_irq_from_sa = KEY3_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY3_s1_irq_from_sa = KEY3_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //KEY3/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module KEY4_s1_arbitrator (
                            // inputs:
                             KEY4_s1_irq,
                             KEY4_s1_readdata,
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_read,
                             cpu_data_master_waitrequest,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,

                            // outputs:
                             KEY4_s1_address,
                             KEY4_s1_chipselect,
                             KEY4_s1_irq_from_sa,
                             KEY4_s1_readdata_from_sa,
                             KEY4_s1_reset_n,
                             KEY4_s1_write_n,
                             KEY4_s1_writedata,
                             cpu_data_master_granted_KEY4_s1,
                             cpu_data_master_qualified_request_KEY4_s1,
                             cpu_data_master_read_data_valid_KEY4_s1,
                             cpu_data_master_requests_KEY4_s1,
                             d1_KEY4_s1_end_xfer
                          )
;

  output  [  1: 0] KEY4_s1_address;
  output           KEY4_s1_chipselect;
  output           KEY4_s1_irq_from_sa;
  output  [ 31: 0] KEY4_s1_readdata_from_sa;
  output           KEY4_s1_reset_n;
  output           KEY4_s1_write_n;
  output  [ 31: 0] KEY4_s1_writedata;
  output           cpu_data_master_granted_KEY4_s1;
  output           cpu_data_master_qualified_request_KEY4_s1;
  output           cpu_data_master_read_data_valid_KEY4_s1;
  output           cpu_data_master_requests_KEY4_s1;
  output           d1_KEY4_s1_end_xfer;
  input            KEY4_s1_irq;
  input   [ 31: 0] KEY4_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] KEY4_s1_address;
  wire             KEY4_s1_allgrants;
  wire             KEY4_s1_allow_new_arb_cycle;
  wire             KEY4_s1_any_bursting_master_saved_grant;
  wire             KEY4_s1_any_continuerequest;
  wire             KEY4_s1_arb_counter_enable;
  reg     [  1: 0] KEY4_s1_arb_share_counter;
  wire    [  1: 0] KEY4_s1_arb_share_counter_next_value;
  wire    [  1: 0] KEY4_s1_arb_share_set_values;
  wire             KEY4_s1_beginbursttransfer_internal;
  wire             KEY4_s1_begins_xfer;
  wire             KEY4_s1_chipselect;
  wire             KEY4_s1_end_xfer;
  wire             KEY4_s1_firsttransfer;
  wire             KEY4_s1_grant_vector;
  wire             KEY4_s1_in_a_read_cycle;
  wire             KEY4_s1_in_a_write_cycle;
  wire             KEY4_s1_irq_from_sa;
  wire             KEY4_s1_master_qreq_vector;
  wire             KEY4_s1_non_bursting_master_requests;
  wire    [ 31: 0] KEY4_s1_readdata_from_sa;
  reg              KEY4_s1_reg_firsttransfer;
  wire             KEY4_s1_reset_n;
  reg              KEY4_s1_slavearbiterlockenable;
  wire             KEY4_s1_slavearbiterlockenable2;
  wire             KEY4_s1_unreg_firsttransfer;
  wire             KEY4_s1_waits_for_read;
  wire             KEY4_s1_waits_for_write;
  wire             KEY4_s1_write_n;
  wire    [ 31: 0] KEY4_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_KEY4_s1;
  wire             cpu_data_master_qualified_request_KEY4_s1;
  wire             cpu_data_master_read_data_valid_KEY4_s1;
  wire             cpu_data_master_requests_KEY4_s1;
  wire             cpu_data_master_saved_grant_KEY4_s1;
  reg              d1_KEY4_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_KEY4_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_KEY4_s1_from_cpu_data_master;
  wire             wait_for_KEY4_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~KEY4_s1_end_xfer;
    end


  assign KEY4_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_KEY4_s1));
  //assign KEY4_s1_readdata_from_sa = KEY4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY4_s1_readdata_from_sa = KEY4_s1_readdata;

  assign cpu_data_master_requests_KEY4_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1870) & (cpu_data_master_read | cpu_data_master_write);
  //KEY4_s1_arb_share_counter set values, which is an e_mux
  assign KEY4_s1_arb_share_set_values = 1;

  //KEY4_s1_non_bursting_master_requests mux, which is an e_mux
  assign KEY4_s1_non_bursting_master_requests = cpu_data_master_requests_KEY4_s1;

  //KEY4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign KEY4_s1_any_bursting_master_saved_grant = 0;

  //KEY4_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign KEY4_s1_arb_share_counter_next_value = KEY4_s1_firsttransfer ? (KEY4_s1_arb_share_set_values - 1) : |KEY4_s1_arb_share_counter ? (KEY4_s1_arb_share_counter - 1) : 0;

  //KEY4_s1_allgrants all slave grants, which is an e_mux
  assign KEY4_s1_allgrants = |KEY4_s1_grant_vector;

  //KEY4_s1_end_xfer assignment, which is an e_assign
  assign KEY4_s1_end_xfer = ~(KEY4_s1_waits_for_read | KEY4_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_KEY4_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_KEY4_s1 = KEY4_s1_end_xfer & (~KEY4_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //KEY4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign KEY4_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_KEY4_s1 & KEY4_s1_allgrants) | (end_xfer_arb_share_counter_term_KEY4_s1 & ~KEY4_s1_non_bursting_master_requests);

  //KEY4_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY4_s1_arb_share_counter <= 0;
      else if (KEY4_s1_arb_counter_enable)
          KEY4_s1_arb_share_counter <= KEY4_s1_arb_share_counter_next_value;
    end


  //KEY4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY4_s1_slavearbiterlockenable <= 0;
      else if ((|KEY4_s1_master_qreq_vector & end_xfer_arb_share_counter_term_KEY4_s1) | (end_xfer_arb_share_counter_term_KEY4_s1 & ~KEY4_s1_non_bursting_master_requests))
          KEY4_s1_slavearbiterlockenable <= |KEY4_s1_arb_share_counter_next_value;
    end


  //cpu/data_master KEY4/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = KEY4_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //KEY4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign KEY4_s1_slavearbiterlockenable2 = |KEY4_s1_arb_share_counter_next_value;

  //cpu/data_master KEY4/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = KEY4_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //KEY4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign KEY4_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_KEY4_s1 = cpu_data_master_requests_KEY4_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //KEY4_s1_writedata mux, which is an e_mux
  assign KEY4_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_KEY4_s1 = cpu_data_master_qualified_request_KEY4_s1;

  //cpu/data_master saved-grant KEY4/s1, which is an e_assign
  assign cpu_data_master_saved_grant_KEY4_s1 = cpu_data_master_requests_KEY4_s1;

  //allow new arb cycle for KEY4/s1, which is an e_assign
  assign KEY4_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign KEY4_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign KEY4_s1_master_qreq_vector = 1;

  //KEY4_s1_reset_n assignment, which is an e_assign
  assign KEY4_s1_reset_n = reset_n;

  assign KEY4_s1_chipselect = cpu_data_master_granted_KEY4_s1;
  //KEY4_s1_firsttransfer first transaction, which is an e_assign
  assign KEY4_s1_firsttransfer = KEY4_s1_begins_xfer ? KEY4_s1_unreg_firsttransfer : KEY4_s1_reg_firsttransfer;

  //KEY4_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign KEY4_s1_unreg_firsttransfer = ~(KEY4_s1_slavearbiterlockenable & KEY4_s1_any_continuerequest);

  //KEY4_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY4_s1_reg_firsttransfer <= 1'b1;
      else if (KEY4_s1_begins_xfer)
          KEY4_s1_reg_firsttransfer <= KEY4_s1_unreg_firsttransfer;
    end


  //KEY4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign KEY4_s1_beginbursttransfer_internal = KEY4_s1_begins_xfer;

  //~KEY4_s1_write_n assignment, which is an e_mux
  assign KEY4_s1_write_n = ~(cpu_data_master_granted_KEY4_s1 & cpu_data_master_write);

  assign shifted_address_to_KEY4_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //KEY4_s1_address mux, which is an e_mux
  assign KEY4_s1_address = shifted_address_to_KEY4_s1_from_cpu_data_master >> 2;

  //d1_KEY4_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_KEY4_s1_end_xfer <= 1;
      else 
        d1_KEY4_s1_end_xfer <= KEY4_s1_end_xfer;
    end


  //KEY4_s1_waits_for_read in a cycle, which is an e_mux
  assign KEY4_s1_waits_for_read = KEY4_s1_in_a_read_cycle & KEY4_s1_begins_xfer;

  //KEY4_s1_in_a_read_cycle assignment, which is an e_assign
  assign KEY4_s1_in_a_read_cycle = cpu_data_master_granted_KEY4_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = KEY4_s1_in_a_read_cycle;

  //KEY4_s1_waits_for_write in a cycle, which is an e_mux
  assign KEY4_s1_waits_for_write = KEY4_s1_in_a_write_cycle & 0;

  //KEY4_s1_in_a_write_cycle assignment, which is an e_assign
  assign KEY4_s1_in_a_write_cycle = cpu_data_master_granted_KEY4_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = KEY4_s1_in_a_write_cycle;

  assign wait_for_KEY4_s1_counter = 0;
  //assign KEY4_s1_irq_from_sa = KEY4_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY4_s1_irq_from_sa = KEY4_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //KEY4/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module buzzer_s1_arbitrator (
                              // inputs:
                               buzzer_s1_readdata,
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_read,
                               cpu_data_master_waitrequest,
                               cpu_data_master_write,
                               cpu_data_master_writedata,
                               reset_n,

                              // outputs:
                               buzzer_s1_address,
                               buzzer_s1_chipselect,
                               buzzer_s1_readdata_from_sa,
                               buzzer_s1_reset_n,
                               buzzer_s1_write_n,
                               buzzer_s1_writedata,
                               cpu_data_master_granted_buzzer_s1,
                               cpu_data_master_qualified_request_buzzer_s1,
                               cpu_data_master_read_data_valid_buzzer_s1,
                               cpu_data_master_requests_buzzer_s1,
                               d1_buzzer_s1_end_xfer
                            )
;

  output  [  1: 0] buzzer_s1_address;
  output           buzzer_s1_chipselect;
  output  [ 31: 0] buzzer_s1_readdata_from_sa;
  output           buzzer_s1_reset_n;
  output           buzzer_s1_write_n;
  output  [ 31: 0] buzzer_s1_writedata;
  output           cpu_data_master_granted_buzzer_s1;
  output           cpu_data_master_qualified_request_buzzer_s1;
  output           cpu_data_master_read_data_valid_buzzer_s1;
  output           cpu_data_master_requests_buzzer_s1;
  output           d1_buzzer_s1_end_xfer;
  input   [ 31: 0] buzzer_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] buzzer_s1_address;
  wire             buzzer_s1_allgrants;
  wire             buzzer_s1_allow_new_arb_cycle;
  wire             buzzer_s1_any_bursting_master_saved_grant;
  wire             buzzer_s1_any_continuerequest;
  wire             buzzer_s1_arb_counter_enable;
  reg     [  1: 0] buzzer_s1_arb_share_counter;
  wire    [  1: 0] buzzer_s1_arb_share_counter_next_value;
  wire    [  1: 0] buzzer_s1_arb_share_set_values;
  wire             buzzer_s1_beginbursttransfer_internal;
  wire             buzzer_s1_begins_xfer;
  wire             buzzer_s1_chipselect;
  wire             buzzer_s1_end_xfer;
  wire             buzzer_s1_firsttransfer;
  wire             buzzer_s1_grant_vector;
  wire             buzzer_s1_in_a_read_cycle;
  wire             buzzer_s1_in_a_write_cycle;
  wire             buzzer_s1_master_qreq_vector;
  wire             buzzer_s1_non_bursting_master_requests;
  wire    [ 31: 0] buzzer_s1_readdata_from_sa;
  reg              buzzer_s1_reg_firsttransfer;
  wire             buzzer_s1_reset_n;
  reg              buzzer_s1_slavearbiterlockenable;
  wire             buzzer_s1_slavearbiterlockenable2;
  wire             buzzer_s1_unreg_firsttransfer;
  wire             buzzer_s1_waits_for_read;
  wire             buzzer_s1_waits_for_write;
  wire             buzzer_s1_write_n;
  wire    [ 31: 0] buzzer_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_buzzer_s1;
  wire             cpu_data_master_qualified_request_buzzer_s1;
  wire             cpu_data_master_read_data_valid_buzzer_s1;
  wire             cpu_data_master_requests_buzzer_s1;
  wire             cpu_data_master_saved_grant_buzzer_s1;
  reg              d1_buzzer_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_buzzer_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_buzzer_s1_from_cpu_data_master;
  wire             wait_for_buzzer_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~buzzer_s1_end_xfer;
    end


  assign buzzer_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_buzzer_s1));
  //assign buzzer_s1_readdata_from_sa = buzzer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign buzzer_s1_readdata_from_sa = buzzer_s1_readdata;

  assign cpu_data_master_requests_buzzer_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18d0) & (cpu_data_master_read | cpu_data_master_write);
  //buzzer_s1_arb_share_counter set values, which is an e_mux
  assign buzzer_s1_arb_share_set_values = 1;

  //buzzer_s1_non_bursting_master_requests mux, which is an e_mux
  assign buzzer_s1_non_bursting_master_requests = cpu_data_master_requests_buzzer_s1;

  //buzzer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign buzzer_s1_any_bursting_master_saved_grant = 0;

  //buzzer_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign buzzer_s1_arb_share_counter_next_value = buzzer_s1_firsttransfer ? (buzzer_s1_arb_share_set_values - 1) : |buzzer_s1_arb_share_counter ? (buzzer_s1_arb_share_counter - 1) : 0;

  //buzzer_s1_allgrants all slave grants, which is an e_mux
  assign buzzer_s1_allgrants = |buzzer_s1_grant_vector;

  //buzzer_s1_end_xfer assignment, which is an e_assign
  assign buzzer_s1_end_xfer = ~(buzzer_s1_waits_for_read | buzzer_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_buzzer_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_buzzer_s1 = buzzer_s1_end_xfer & (~buzzer_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //buzzer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign buzzer_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_buzzer_s1 & buzzer_s1_allgrants) | (end_xfer_arb_share_counter_term_buzzer_s1 & ~buzzer_s1_non_bursting_master_requests);

  //buzzer_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          buzzer_s1_arb_share_counter <= 0;
      else if (buzzer_s1_arb_counter_enable)
          buzzer_s1_arb_share_counter <= buzzer_s1_arb_share_counter_next_value;
    end


  //buzzer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          buzzer_s1_slavearbiterlockenable <= 0;
      else if ((|buzzer_s1_master_qreq_vector & end_xfer_arb_share_counter_term_buzzer_s1) | (end_xfer_arb_share_counter_term_buzzer_s1 & ~buzzer_s1_non_bursting_master_requests))
          buzzer_s1_slavearbiterlockenable <= |buzzer_s1_arb_share_counter_next_value;
    end


  //cpu/data_master buzzer/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = buzzer_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //buzzer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign buzzer_s1_slavearbiterlockenable2 = |buzzer_s1_arb_share_counter_next_value;

  //cpu/data_master buzzer/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = buzzer_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //buzzer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign buzzer_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_buzzer_s1 = cpu_data_master_requests_buzzer_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //buzzer_s1_writedata mux, which is an e_mux
  assign buzzer_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_buzzer_s1 = cpu_data_master_qualified_request_buzzer_s1;

  //cpu/data_master saved-grant buzzer/s1, which is an e_assign
  assign cpu_data_master_saved_grant_buzzer_s1 = cpu_data_master_requests_buzzer_s1;

  //allow new arb cycle for buzzer/s1, which is an e_assign
  assign buzzer_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign buzzer_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign buzzer_s1_master_qreq_vector = 1;

  //buzzer_s1_reset_n assignment, which is an e_assign
  assign buzzer_s1_reset_n = reset_n;

  assign buzzer_s1_chipselect = cpu_data_master_granted_buzzer_s1;
  //buzzer_s1_firsttransfer first transaction, which is an e_assign
  assign buzzer_s1_firsttransfer = buzzer_s1_begins_xfer ? buzzer_s1_unreg_firsttransfer : buzzer_s1_reg_firsttransfer;

  //buzzer_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign buzzer_s1_unreg_firsttransfer = ~(buzzer_s1_slavearbiterlockenable & buzzer_s1_any_continuerequest);

  //buzzer_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          buzzer_s1_reg_firsttransfer <= 1'b1;
      else if (buzzer_s1_begins_xfer)
          buzzer_s1_reg_firsttransfer <= buzzer_s1_unreg_firsttransfer;
    end


  //buzzer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign buzzer_s1_beginbursttransfer_internal = buzzer_s1_begins_xfer;

  //~buzzer_s1_write_n assignment, which is an e_mux
  assign buzzer_s1_write_n = ~(cpu_data_master_granted_buzzer_s1 & cpu_data_master_write);

  assign shifted_address_to_buzzer_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //buzzer_s1_address mux, which is an e_mux
  assign buzzer_s1_address = shifted_address_to_buzzer_s1_from_cpu_data_master >> 2;

  //d1_buzzer_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_buzzer_s1_end_xfer <= 1;
      else 
        d1_buzzer_s1_end_xfer <= buzzer_s1_end_xfer;
    end


  //buzzer_s1_waits_for_read in a cycle, which is an e_mux
  assign buzzer_s1_waits_for_read = buzzer_s1_in_a_read_cycle & buzzer_s1_begins_xfer;

  //buzzer_s1_in_a_read_cycle assignment, which is an e_assign
  assign buzzer_s1_in_a_read_cycle = cpu_data_master_granted_buzzer_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = buzzer_s1_in_a_read_cycle;

  //buzzer_s1_waits_for_write in a cycle, which is an e_mux
  assign buzzer_s1_waits_for_write = buzzer_s1_in_a_write_cycle & 0;

  //buzzer_s1_in_a_write_cycle assignment, which is an e_assign
  assign buzzer_s1_in_a_write_cycle = cpu_data_master_granted_buzzer_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = buzzer_s1_in_a_write_cycle;

  assign wait_for_buzzer_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //buzzer/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_jtag_debug_module_arbitrator (
                                          // inputs:
                                           clk,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_debugaccess,
                                           cpu_data_master_read,
                                           cpu_data_master_waitrequest,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           cpu_instruction_master_address_to_slave,
                                           cpu_instruction_master_latency_counter,
                                           cpu_instruction_master_read,
                                           cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                           cpu_jtag_debug_module_readdata,
                                           cpu_jtag_debug_module_resetrequest,
                                           reset_n,

                                          // outputs:
                                           cpu_data_master_granted_cpu_jtag_debug_module,
                                           cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_data_master_requests_cpu_jtag_debug_module,
                                           cpu_instruction_master_granted_cpu_jtag_debug_module,
                                           cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_instruction_master_requests_cpu_jtag_debug_module,
                                           cpu_jtag_debug_module_address,
                                           cpu_jtag_debug_module_begintransfer,
                                           cpu_jtag_debug_module_byteenable,
                                           cpu_jtag_debug_module_chipselect,
                                           cpu_jtag_debug_module_debugaccess,
                                           cpu_jtag_debug_module_readdata_from_sa,
                                           cpu_jtag_debug_module_reset_n,
                                           cpu_jtag_debug_module_resetrequest_from_sa,
                                           cpu_jtag_debug_module_write,
                                           cpu_jtag_debug_module_writedata,
                                           d1_cpu_jtag_debug_module_end_xfer
                                        )
;

  output           cpu_data_master_granted_cpu_jtag_debug_module;
  output           cpu_data_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_data_master_requests_cpu_jtag_debug_module;
  output           cpu_instruction_master_granted_cpu_jtag_debug_module;
  output           cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_instruction_master_requests_cpu_jtag_debug_module;
  output  [  8: 0] cpu_jtag_debug_module_address;
  output           cpu_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_jtag_debug_module_byteenable;
  output           cpu_jtag_debug_module_chipselect;
  output           cpu_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  output           cpu_jtag_debug_module_reset_n;
  output           cpu_jtag_debug_module_resetrequest_from_sa;
  output           cpu_jtag_debug_module_write;
  output  [ 31: 0] cpu_jtag_debug_module_writedata;
  output           d1_cpu_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_debugaccess;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input   [ 31: 0] cpu_jtag_debug_module_readdata;
  input            cpu_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_saved_grant_cpu_jtag_debug_module;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_saved_grant_cpu_jtag_debug_module;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_allgrants;
  wire             cpu_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_jtag_debug_module_arb_addend;
  wire             cpu_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_jtag_debug_module_arb_winner;
  wire             cpu_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_jtag_debug_module_begins_xfer;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_jtag_debug_module_debugaccess;
  wire             cpu_jtag_debug_module_end_xfer;
  wire             cpu_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_jtag_debug_module_grant_vector;
  wire             cpu_jtag_debug_module_in_a_read_cycle;
  wire             cpu_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_jtag_debug_module_master_qreq_vector;
  wire             cpu_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  reg              cpu_jtag_debug_module_reg_firsttransfer;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_jtag_debug_module_waits_for_read;
  wire             cpu_jtag_debug_module_waits_for_write;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  reg              d1_cpu_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
  reg              last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master;
  wire             wait_for_cpu_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_jtag_debug_module_end_xfer;
    end


  assign cpu_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cpu_jtag_debug_module | cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  //assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata;

  assign cpu_data_master_requests_cpu_jtag_debug_module = ({cpu_data_master_address_to_slave[26 : 11] , 11'b0} == 27'h1000) & (cpu_data_master_read | cpu_data_master_write);
  //cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_jtag_debug_module_arb_share_set_values = 1;

  //cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_jtag_debug_module_non_bursting_master_requests = cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module |
    cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_jtag_debug_module_arb_share_counter_next_value = cpu_jtag_debug_module_firsttransfer ? (cpu_jtag_debug_module_arb_share_set_values - 1) : |cpu_jtag_debug_module_arb_share_counter ? (cpu_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_jtag_debug_module_allgrants = (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector);

  //cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_jtag_debug_module_end_xfer = ~(cpu_jtag_debug_module_waits_for_read | cpu_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_jtag_debug_module = cpu_jtag_debug_module_end_xfer & (~cpu_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & cpu_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests);

  //cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_jtag_debug_module_arb_counter_enable)
          cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests))
          cpu_jtag_debug_module_slavearbiterlockenable <= |cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_data_master_continuerequest;

  //cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_jtag_debug_module_slavearbiterlockenable2 = |cpu_jtag_debug_module_arb_share_counter_next_value;

  //cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= cpu_instruction_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module & cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_jtag_debug_module_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cpu_jtag_debug_module = cpu_data_master_requests_cpu_jtag_debug_module & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //cpu_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_jtag_debug_module_writedata = cpu_data_master_writedata;

  assign cpu_instruction_master_requests_cpu_jtag_debug_module = (({cpu_instruction_master_address_to_slave[26 : 11] , 11'b0} == 27'h1000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= cpu_data_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_data_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module & cpu_data_master_requests_cpu_jtag_debug_module;

  assign cpu_instruction_master_qualified_request_cpu_jtag_debug_module = cpu_instruction_master_requests_cpu_jtag_debug_module & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cpu_jtag_debug_module = cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cpu_jtag_debug_module;

  //cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[0];

  //cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[0] && cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[1] = cpu_data_master_qualified_request_cpu_jtag_debug_module;

  //cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[1];

  //cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[1] && cpu_data_master_requests_cpu_jtag_debug_module;

  //cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_double_vector = {cpu_jtag_debug_module_master_qreq_vector, cpu_jtag_debug_module_master_qreq_vector} & ({~cpu_jtag_debug_module_master_qreq_vector, ~cpu_jtag_debug_module_master_qreq_vector} + cpu_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_jtag_debug_module_arb_winner = (cpu_jtag_debug_module_allow_new_arb_cycle & | cpu_jtag_debug_module_grant_vector) ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_jtag_debug_module_allow_new_arb_cycle)
          cpu_jtag_debug_module_saved_chosen_master_vector <= |cpu_jtag_debug_module_grant_vector ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_jtag_debug_module_grant_vector = {(cpu_jtag_debug_module_chosen_master_double_vector[1] | cpu_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_jtag_debug_module_chosen_master_double_vector[0] | cpu_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_rot_left = (cpu_jtag_debug_module_arb_winner << 1) ? (cpu_jtag_debug_module_arb_winner << 1) : 1;

  //cpu/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_jtag_debug_module_grant_vector)
          cpu_jtag_debug_module_arb_addend <= cpu_jtag_debug_module_end_xfer? cpu_jtag_debug_module_chosen_master_rot_left : cpu_jtag_debug_module_grant_vector;
    end


  assign cpu_jtag_debug_module_begintransfer = cpu_jtag_debug_module_begins_xfer;
  //cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_jtag_debug_module_reset_n = reset_n;

  //assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest;

  assign cpu_jtag_debug_module_chipselect = cpu_data_master_granted_cpu_jtag_debug_module | cpu_instruction_master_granted_cpu_jtag_debug_module;
  //cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_firsttransfer = cpu_jtag_debug_module_begins_xfer ? cpu_jtag_debug_module_unreg_firsttransfer : cpu_jtag_debug_module_reg_firsttransfer;

  //cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_unreg_firsttransfer = ~(cpu_jtag_debug_module_slavearbiterlockenable & cpu_jtag_debug_module_any_continuerequest);

  //cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_jtag_debug_module_begins_xfer)
          cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_jtag_debug_module_beginbursttransfer_internal = cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_jtag_debug_module_arbitration_holdoff_internal = cpu_jtag_debug_module_begins_xfer & cpu_jtag_debug_module_firsttransfer;

  //cpu_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_jtag_debug_module_write = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master = cpu_data_master_address_to_slave;
  //cpu_jtag_debug_module_address mux, which is an e_mux
  assign cpu_jtag_debug_module_address = (cpu_data_master_granted_cpu_jtag_debug_module)? (shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master >> 2) :
    (shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master >> 2);

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end


  //cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_read = cpu_jtag_debug_module_in_a_read_cycle & cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_read_cycle = (cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read) | (cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_jtag_debug_module_in_a_read_cycle;

  //cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_write = cpu_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_write_cycle = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_jtag_debug_module_counter = 0;
  //cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_jtag_debug_module_byteenable = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_jtag_debug_module_debugaccess = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cpu_jtag_debug_module + cpu_instruction_master_granted_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cpu_jtag_debug_module + cpu_instruction_master_saved_grant_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_data_master_arbitrator (
                                    // inputs:
                                     KEY2_s1_irq_from_sa,
                                     KEY2_s1_readdata_from_sa,
                                     KEY3_s1_irq_from_sa,
                                     KEY3_s1_readdata_from_sa,
                                     KEY4_s1_irq_from_sa,
                                     KEY4_s1_readdata_from_sa,
                                     buzzer_s1_readdata_from_sa,
                                     clk,
                                     cpu_data_master_address,
                                     cpu_data_master_byteenable_sdram_s1,
                                     cpu_data_master_granted_KEY2_s1,
                                     cpu_data_master_granted_KEY3_s1,
                                     cpu_data_master_granted_KEY4_s1,
                                     cpu_data_master_granted_buzzer_s1,
                                     cpu_data_master_granted_cpu_jtag_debug_module,
                                     cpu_data_master_granted_dig_s1,
                                     cpu_data_master_granted_epcs_epcs_control_port,
                                     cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_granted_led_s1,
                                     cpu_data_master_granted_rtc_data_s1,
                                     cpu_data_master_granted_rtc_rst_n_s1,
                                     cpu_data_master_granted_rtc_sclk_s1,
                                     cpu_data_master_granted_scl_s1,
                                     cpu_data_master_granted_sda_s1,
                                     cpu_data_master_granted_sdram_s1,
                                     cpu_data_master_granted_sel_s1,
                                     cpu_data_master_granted_sysid_control_slave,
                                     cpu_data_master_granted_timer_s1,
                                     cpu_data_master_granted_uart_s1,
                                     cpu_data_master_qualified_request_KEY2_s1,
                                     cpu_data_master_qualified_request_KEY3_s1,
                                     cpu_data_master_qualified_request_KEY4_s1,
                                     cpu_data_master_qualified_request_buzzer_s1,
                                     cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                     cpu_data_master_qualified_request_dig_s1,
                                     cpu_data_master_qualified_request_epcs_epcs_control_port,
                                     cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_qualified_request_led_s1,
                                     cpu_data_master_qualified_request_rtc_data_s1,
                                     cpu_data_master_qualified_request_rtc_rst_n_s1,
                                     cpu_data_master_qualified_request_rtc_sclk_s1,
                                     cpu_data_master_qualified_request_scl_s1,
                                     cpu_data_master_qualified_request_sda_s1,
                                     cpu_data_master_qualified_request_sdram_s1,
                                     cpu_data_master_qualified_request_sel_s1,
                                     cpu_data_master_qualified_request_sysid_control_slave,
                                     cpu_data_master_qualified_request_timer_s1,
                                     cpu_data_master_qualified_request_uart_s1,
                                     cpu_data_master_read,
                                     cpu_data_master_read_data_valid_KEY2_s1,
                                     cpu_data_master_read_data_valid_KEY3_s1,
                                     cpu_data_master_read_data_valid_KEY4_s1,
                                     cpu_data_master_read_data_valid_buzzer_s1,
                                     cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                     cpu_data_master_read_data_valid_dig_s1,
                                     cpu_data_master_read_data_valid_epcs_epcs_control_port,
                                     cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_read_data_valid_led_s1,
                                     cpu_data_master_read_data_valid_rtc_data_s1,
                                     cpu_data_master_read_data_valid_rtc_rst_n_s1,
                                     cpu_data_master_read_data_valid_rtc_sclk_s1,
                                     cpu_data_master_read_data_valid_scl_s1,
                                     cpu_data_master_read_data_valid_sda_s1,
                                     cpu_data_master_read_data_valid_sdram_s1,
                                     cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                     cpu_data_master_read_data_valid_sel_s1,
                                     cpu_data_master_read_data_valid_sysid_control_slave,
                                     cpu_data_master_read_data_valid_timer_s1,
                                     cpu_data_master_read_data_valid_uart_s1,
                                     cpu_data_master_requests_KEY2_s1,
                                     cpu_data_master_requests_KEY3_s1,
                                     cpu_data_master_requests_KEY4_s1,
                                     cpu_data_master_requests_buzzer_s1,
                                     cpu_data_master_requests_cpu_jtag_debug_module,
                                     cpu_data_master_requests_dig_s1,
                                     cpu_data_master_requests_epcs_epcs_control_port,
                                     cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_requests_led_s1,
                                     cpu_data_master_requests_rtc_data_s1,
                                     cpu_data_master_requests_rtc_rst_n_s1,
                                     cpu_data_master_requests_rtc_sclk_s1,
                                     cpu_data_master_requests_scl_s1,
                                     cpu_data_master_requests_sda_s1,
                                     cpu_data_master_requests_sdram_s1,
                                     cpu_data_master_requests_sel_s1,
                                     cpu_data_master_requests_sysid_control_slave,
                                     cpu_data_master_requests_timer_s1,
                                     cpu_data_master_requests_uart_s1,
                                     cpu_data_master_write,
                                     cpu_data_master_writedata,
                                     cpu_jtag_debug_module_readdata_from_sa,
                                     d1_KEY2_s1_end_xfer,
                                     d1_KEY3_s1_end_xfer,
                                     d1_KEY4_s1_end_xfer,
                                     d1_buzzer_s1_end_xfer,
                                     d1_cpu_jtag_debug_module_end_xfer,
                                     d1_dig_s1_end_xfer,
                                     d1_epcs_epcs_control_port_end_xfer,
                                     d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                     d1_led_s1_end_xfer,
                                     d1_rtc_data_s1_end_xfer,
                                     d1_rtc_rst_n_s1_end_xfer,
                                     d1_rtc_sclk_s1_end_xfer,
                                     d1_scl_s1_end_xfer,
                                     d1_sda_s1_end_xfer,
                                     d1_sdram_s1_end_xfer,
                                     d1_sel_s1_end_xfer,
                                     d1_sysid_control_slave_end_xfer,
                                     d1_timer_s1_end_xfer,
                                     d1_uart_s1_end_xfer,
                                     dig_s1_readdata_from_sa,
                                     epcs_epcs_control_port_irq_from_sa,
                                     epcs_epcs_control_port_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                     led_s1_readdata_from_sa,
                                     reset_n,
                                     rtc_data_s1_readdata_from_sa,
                                     rtc_rst_n_s1_readdata_from_sa,
                                     rtc_sclk_s1_readdata_from_sa,
                                     scl_s1_readdata_from_sa,
                                     sda_s1_readdata_from_sa,
                                     sdram_s1_readdata_from_sa,
                                     sdram_s1_waitrequest_from_sa,
                                     sel_s1_readdata_from_sa,
                                     sysid_control_slave_readdata_from_sa,
                                     timer_s1_irq_from_sa,
                                     timer_s1_readdata_from_sa,
                                     uart_s1_irq_from_sa,
                                     uart_s1_readdata_from_sa,

                                    // outputs:
                                     cpu_data_master_address_to_slave,
                                     cpu_data_master_dbs_address,
                                     cpu_data_master_dbs_write_16,
                                     cpu_data_master_irq,
                                     cpu_data_master_no_byte_enables_and_last_term,
                                     cpu_data_master_readdata,
                                     cpu_data_master_waitrequest
                                  )
;

  output  [ 26: 0] cpu_data_master_address_to_slave;
  output  [  1: 0] cpu_data_master_dbs_address;
  output  [ 15: 0] cpu_data_master_dbs_write_16;
  output  [ 31: 0] cpu_data_master_irq;
  output           cpu_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_data_master_readdata;
  output           cpu_data_master_waitrequest;
  input            KEY2_s1_irq_from_sa;
  input   [ 31: 0] KEY2_s1_readdata_from_sa;
  input            KEY3_s1_irq_from_sa;
  input   [ 31: 0] KEY3_s1_readdata_from_sa;
  input            KEY4_s1_irq_from_sa;
  input   [ 31: 0] KEY4_s1_readdata_from_sa;
  input   [ 31: 0] buzzer_s1_readdata_from_sa;
  input            clk;
  input   [ 26: 0] cpu_data_master_address;
  input   [  1: 0] cpu_data_master_byteenable_sdram_s1;
  input            cpu_data_master_granted_KEY2_s1;
  input            cpu_data_master_granted_KEY3_s1;
  input            cpu_data_master_granted_KEY4_s1;
  input            cpu_data_master_granted_buzzer_s1;
  input            cpu_data_master_granted_cpu_jtag_debug_module;
  input            cpu_data_master_granted_dig_s1;
  input            cpu_data_master_granted_epcs_epcs_control_port;
  input            cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_granted_led_s1;
  input            cpu_data_master_granted_rtc_data_s1;
  input            cpu_data_master_granted_rtc_rst_n_s1;
  input            cpu_data_master_granted_rtc_sclk_s1;
  input            cpu_data_master_granted_scl_s1;
  input            cpu_data_master_granted_sda_s1;
  input            cpu_data_master_granted_sdram_s1;
  input            cpu_data_master_granted_sel_s1;
  input            cpu_data_master_granted_sysid_control_slave;
  input            cpu_data_master_granted_timer_s1;
  input            cpu_data_master_granted_uart_s1;
  input            cpu_data_master_qualified_request_KEY2_s1;
  input            cpu_data_master_qualified_request_KEY3_s1;
  input            cpu_data_master_qualified_request_KEY4_s1;
  input            cpu_data_master_qualified_request_buzzer_s1;
  input            cpu_data_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_data_master_qualified_request_dig_s1;
  input            cpu_data_master_qualified_request_epcs_epcs_control_port;
  input            cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_qualified_request_led_s1;
  input            cpu_data_master_qualified_request_rtc_data_s1;
  input            cpu_data_master_qualified_request_rtc_rst_n_s1;
  input            cpu_data_master_qualified_request_rtc_sclk_s1;
  input            cpu_data_master_qualified_request_scl_s1;
  input            cpu_data_master_qualified_request_sda_s1;
  input            cpu_data_master_qualified_request_sdram_s1;
  input            cpu_data_master_qualified_request_sel_s1;
  input            cpu_data_master_qualified_request_sysid_control_slave;
  input            cpu_data_master_qualified_request_timer_s1;
  input            cpu_data_master_qualified_request_uart_s1;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_KEY2_s1;
  input            cpu_data_master_read_data_valid_KEY3_s1;
  input            cpu_data_master_read_data_valid_KEY4_s1;
  input            cpu_data_master_read_data_valid_buzzer_s1;
  input            cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_data_master_read_data_valid_dig_s1;
  input            cpu_data_master_read_data_valid_epcs_epcs_control_port;
  input            cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_read_data_valid_led_s1;
  input            cpu_data_master_read_data_valid_rtc_data_s1;
  input            cpu_data_master_read_data_valid_rtc_rst_n_s1;
  input            cpu_data_master_read_data_valid_rtc_sclk_s1;
  input            cpu_data_master_read_data_valid_scl_s1;
  input            cpu_data_master_read_data_valid_sda_s1;
  input            cpu_data_master_read_data_valid_sdram_s1;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_read_data_valid_sel_s1;
  input            cpu_data_master_read_data_valid_sysid_control_slave;
  input            cpu_data_master_read_data_valid_timer_s1;
  input            cpu_data_master_read_data_valid_uart_s1;
  input            cpu_data_master_requests_KEY2_s1;
  input            cpu_data_master_requests_KEY3_s1;
  input            cpu_data_master_requests_KEY4_s1;
  input            cpu_data_master_requests_buzzer_s1;
  input            cpu_data_master_requests_cpu_jtag_debug_module;
  input            cpu_data_master_requests_dig_s1;
  input            cpu_data_master_requests_epcs_epcs_control_port;
  input            cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_requests_led_s1;
  input            cpu_data_master_requests_rtc_data_s1;
  input            cpu_data_master_requests_rtc_rst_n_s1;
  input            cpu_data_master_requests_rtc_sclk_s1;
  input            cpu_data_master_requests_scl_s1;
  input            cpu_data_master_requests_sda_s1;
  input            cpu_data_master_requests_sdram_s1;
  input            cpu_data_master_requests_sel_s1;
  input            cpu_data_master_requests_sysid_control_slave;
  input            cpu_data_master_requests_timer_s1;
  input            cpu_data_master_requests_uart_s1;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_KEY2_s1_end_xfer;
  input            d1_KEY3_s1_end_xfer;
  input            d1_KEY4_s1_end_xfer;
  input            d1_buzzer_s1_end_xfer;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_dig_s1_end_xfer;
  input            d1_epcs_epcs_control_port_end_xfer;
  input            d1_jtag_uart_avalon_jtag_slave_end_xfer;
  input            d1_led_s1_end_xfer;
  input            d1_rtc_data_s1_end_xfer;
  input            d1_rtc_rst_n_s1_end_xfer;
  input            d1_rtc_sclk_s1_end_xfer;
  input            d1_scl_s1_end_xfer;
  input            d1_sda_s1_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input            d1_sel_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_s1_end_xfer;
  input            d1_uart_s1_end_xfer;
  input   [ 31: 0] dig_s1_readdata_from_sa;
  input            epcs_epcs_control_port_irq_from_sa;
  input   [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] led_s1_readdata_from_sa;
  input            reset_n;
  input   [ 31: 0] rtc_data_s1_readdata_from_sa;
  input   [ 31: 0] rtc_rst_n_s1_readdata_from_sa;
  input   [ 31: 0] rtc_sclk_s1_readdata_from_sa;
  input   [ 31: 0] scl_s1_readdata_from_sa;
  input   [ 31: 0] sda_s1_readdata_from_sa;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;
  input   [ 31: 0] sel_s1_readdata_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            timer_s1_irq_from_sa;
  input   [ 15: 0] timer_s1_readdata_from_sa;
  input            uart_s1_irq_from_sa;
  input   [ 15: 0] uart_s1_readdata_from_sa;

  wire    [ 26: 0] cpu_data_master_address_to_slave;
  reg     [  1: 0] cpu_data_master_dbs_address;
  wire    [  1: 0] cpu_data_master_dbs_increment;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_data_master_irq;
  reg              cpu_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_run;
  reg              cpu_data_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [ 31: 0] p1_registered_cpu_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  reg     [ 31: 0] registered_cpu_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_data_master_qualified_request_KEY2_s1 | ~cpu_data_master_requests_KEY2_s1) & ((~cpu_data_master_qualified_request_KEY2_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_KEY2_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_KEY3_s1 | ~cpu_data_master_requests_KEY3_s1) & ((~cpu_data_master_qualified_request_KEY3_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_KEY3_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_KEY4_s1 | ~cpu_data_master_requests_KEY4_s1) & ((~cpu_data_master_qualified_request_KEY4_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_KEY4_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_buzzer_s1 | ~cpu_data_master_requests_buzzer_s1) & ((~cpu_data_master_qualified_request_buzzer_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_buzzer_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_requests_cpu_jtag_debug_module) & (cpu_data_master_granted_cpu_jtag_debug_module | ~cpu_data_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_data_master_run = r_0 & r_1 & r_2 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_dig_s1 | ~cpu_data_master_requests_dig_s1) & ((~cpu_data_master_qualified_request_dig_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_dig_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_epcs_epcs_control_port | ~cpu_data_master_requests_epcs_epcs_control_port) & (cpu_data_master_granted_epcs_epcs_control_port | ~cpu_data_master_qualified_request_epcs_epcs_control_port) & ((~cpu_data_master_qualified_request_epcs_epcs_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_epcs_epcs_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~cpu_data_master_requests_jtag_uart_avalon_jtag_slave) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_led_s1 | ~cpu_data_master_requests_led_s1) & ((~cpu_data_master_qualified_request_led_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_rtc_data_s1 | ~cpu_data_master_requests_rtc_data_s1);

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = ((~cpu_data_master_qualified_request_rtc_data_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_rtc_data_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_rtc_rst_n_s1 | ~cpu_data_master_requests_rtc_rst_n_s1) & ((~cpu_data_master_qualified_request_rtc_rst_n_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_rtc_rst_n_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_rtc_sclk_s1 | ~cpu_data_master_requests_rtc_sclk_s1) & ((~cpu_data_master_qualified_request_rtc_sclk_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_rtc_sclk_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_scl_s1 | ~cpu_data_master_requests_scl_s1) & ((~cpu_data_master_qualified_request_scl_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_scl_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sda_s1 | ~cpu_data_master_requests_sda_s1) & ((~cpu_data_master_qualified_request_sda_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sda_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sdram_s1 | (cpu_data_master_read_data_valid_sdram_s1 & cpu_data_master_dbs_address[1]) | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_s1);

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = (cpu_data_master_granted_sdram_s1 | ~cpu_data_master_qualified_request_sdram_s1) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_read | (cpu_data_master_read_data_valid_sdram_s1 & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_write | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sel_s1 | ~cpu_data_master_requests_sel_s1) & ((~cpu_data_master_qualified_request_sel_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sel_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_requests_timer_s1) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write))));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_data_master_address_to_slave = {cpu_data_master_address[26],
    1'b0,
    cpu_data_master_address[24 : 0]};

  //cpu/data_master readdata mux, which is an e_mux
  assign cpu_data_master_readdata = ({32 {~cpu_data_master_requests_KEY2_s1}} | KEY2_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_KEY3_s1}} | KEY3_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_KEY4_s1}} | KEY4_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_buzzer_s1}} | buzzer_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_cpu_jtag_debug_module}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_dig_s1}} | dig_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_epcs_epcs_control_port}} | epcs_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_jtag_uart_avalon_jtag_slave}} | registered_cpu_data_master_readdata) &
    ({32 {~cpu_data_master_requests_led_s1}} | led_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_rtc_data_s1}} | rtc_data_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_rtc_rst_n_s1}} | rtc_rst_n_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_rtc_sclk_s1}} | rtc_sclk_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_scl_s1}} | scl_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sda_s1}} | sda_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sdram_s1}} | registered_cpu_data_master_readdata) &
    ({32 {~cpu_data_master_requests_sel_s1}} | sel_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_timer_s1}} | timer_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_uart_s1}} | uart_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_waitrequest <= ~0;
      else 
        cpu_data_master_waitrequest <= ~((~(cpu_data_master_read | cpu_data_master_write))? 0: (cpu_data_master_run & cpu_data_master_waitrequest));
    end


  //irq assign, which is an e_assign
  assign cpu_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    timer_s1_irq_from_sa,
    1'b0,
    1'b0,
    1'b0,
    KEY4_s1_irq_from_sa,
    KEY3_s1_irq_from_sa,
    KEY2_s1_irq_from_sa,
    uart_s1_irq_from_sa,
    jtag_uart_avalon_jtag_slave_irq_from_sa,
    epcs_epcs_control_port_irq_from_sa};

  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_data_master_readdata <= 0;
      else 
        registered_cpu_data_master_readdata <= p1_registered_cpu_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_data_master_readdata = ({32 {~cpu_data_master_requests_jtag_uart_avalon_jtag_slave}} | jtag_uart_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_data_master_dbs_address == 2'b10) & cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1;

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~cpu_data_master_no_byte_enables_and_last_term) & cpu_data_master_requests_sdram_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1)) |
    cpu_data_master_read_data_valid_sdram_s1 |
    (cpu_data_master_granted_sdram_s1 & cpu_data_master_write & 1 & 1 & ~sdram_s1_waitrequest_from_sa);

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_data_master_dbs_write_16 = (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    cpu_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_data_master_dbs_increment = (cpu_data_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_data_master_dbs_address + cpu_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_data_master_requests_sdram_s1 & ~cpu_data_master_waitrequest));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_data_master_dbs_address <= next_dbs_address;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_instruction_master_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_instruction_master_address,
                                            cpu_instruction_master_granted_cpu_jtag_debug_module,
                                            cpu_instruction_master_granted_epcs_epcs_control_port,
                                            cpu_instruction_master_granted_sdram_s1,
                                            cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                            cpu_instruction_master_qualified_request_epcs_epcs_control_port,
                                            cpu_instruction_master_qualified_request_sdram_s1,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                            cpu_instruction_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_instruction_master_read_data_valid_sdram_s1,
                                            cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                            cpu_instruction_master_requests_cpu_jtag_debug_module,
                                            cpu_instruction_master_requests_epcs_epcs_control_port,
                                            cpu_instruction_master_requests_sdram_s1,
                                            cpu_jtag_debug_module_readdata_from_sa,
                                            d1_cpu_jtag_debug_module_end_xfer,
                                            d1_epcs_epcs_control_port_end_xfer,
                                            d1_sdram_s1_end_xfer,
                                            epcs_epcs_control_port_readdata_from_sa,
                                            reset_n,
                                            sdram_s1_readdata_from_sa,
                                            sdram_s1_waitrequest_from_sa,

                                           // outputs:
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_dbs_address,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_readdata,
                                            cpu_instruction_master_readdatavalid,
                                            cpu_instruction_master_waitrequest
                                         )
;

  output  [ 26: 0] cpu_instruction_master_address_to_slave;
  output  [  1: 0] cpu_instruction_master_dbs_address;
  output           cpu_instruction_master_latency_counter;
  output  [ 31: 0] cpu_instruction_master_readdata;
  output           cpu_instruction_master_readdatavalid;
  output           cpu_instruction_master_waitrequest;
  input            clk;
  input   [ 26: 0] cpu_instruction_master_address;
  input            cpu_instruction_master_granted_cpu_jtag_debug_module;
  input            cpu_instruction_master_granted_epcs_epcs_control_port;
  input            cpu_instruction_master_granted_sdram_s1;
  input            cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  input            cpu_instruction_master_qualified_request_sdram_s1;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  input            cpu_instruction_master_read_data_valid_sdram_s1;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_instruction_master_requests_cpu_jtag_debug_module;
  input            cpu_instruction_master_requests_epcs_epcs_control_port;
  input            cpu_instruction_master_requests_sdram_s1;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_epcs_epcs_control_port_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input   [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 26: 0] cpu_instruction_master_address_last_time;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_instruction_master_dbs_address;
  wire    [  1: 0] cpu_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_instruction_master_is_granted_some_slave;
  reg              cpu_instruction_master_latency_counter;
  wire    [  1: 0] cpu_instruction_master_next_dbs_rdv_counter;
  reg              cpu_instruction_master_read_but_no_slave_selected;
  reg              cpu_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_run;
  wire             cpu_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_3;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_requests_cpu_jtag_debug_module) & (cpu_instruction_master_granted_cpu_jtag_debug_module | ~cpu_instruction_master_qualified_request_cpu_jtag_debug_module);

  //cascaded wait assignment, which is an e_assign
  assign cpu_instruction_master_run = r_0 & r_1 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_instruction_master_read))) & 1 & (cpu_instruction_master_qualified_request_epcs_epcs_control_port | ~cpu_instruction_master_requests_epcs_epcs_control_port) & (cpu_instruction_master_granted_epcs_epcs_control_port | ~cpu_instruction_master_qualified_request_epcs_epcs_control_port) & ((~cpu_instruction_master_qualified_request_epcs_epcs_control_port | ~(cpu_instruction_master_read) | (1 & ~d1_epcs_epcs_control_port_end_xfer & (cpu_instruction_master_read))));

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & (cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_requests_sdram_s1) & (cpu_instruction_master_granted_sdram_s1 | ~cpu_instruction_master_qualified_request_sdram_s1) & ((~cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_read | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_instruction_master_address_to_slave = {cpu_instruction_master_address[26],
    1'b0,
    cpu_instruction_master_address[24 : 0]};

  //cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_instruction_master_read_but_no_slave_selected <= cpu_instruction_master_read & cpu_instruction_master_run & ~cpu_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_instruction_master_is_granted_some_slave = cpu_instruction_master_granted_cpu_jtag_debug_module |
    cpu_instruction_master_granted_epcs_epcs_control_port |
    cpu_instruction_master_granted_sdram_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_instruction_master_readdatavalid = cpu_instruction_master_read_data_valid_sdram_s1 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_instruction_master_readdatavalid = cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_cpu_jtag_debug_module |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_epcs_epcs_control_port |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid;

  //cpu/instruction_master readdata mux, which is an e_mux
  assign cpu_instruction_master_readdata = ({32 {~(cpu_instruction_master_qualified_request_cpu_jtag_debug_module & cpu_instruction_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_instruction_master_qualified_request_epcs_epcs_control_port & cpu_instruction_master_read)}} | epcs_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_instruction_master_waitrequest = ~cpu_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_latency_counter <= 0;
      else 
        cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_instruction_master_latency_counter = ((cpu_instruction_master_run & cpu_instruction_master_read))? latency_load_value :
    (cpu_instruction_master_latency_counter)? cpu_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_instruction_master_dbs_increment = (cpu_instruction_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_instruction_master_dbs_address + cpu_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_instruction_master_next_dbs_rdv_counter = cpu_instruction_master_dbs_rdv_counter + cpu_instruction_master_dbs_rdv_counter_inc;

  //cpu_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_instruction_master_read_data_valid_sdram_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_instruction_master_dbs_rdv_counter[1] & ~cpu_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_s1_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_address_last_time <= 0;
      else 
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
    end


  //cpu/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_instruction_master_waitrequest & (cpu_instruction_master_read);
    end


  //cpu_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_address != cpu_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_last_time <= 0;
      else 
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
    end


  //cpu_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_read != cpu_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module dig_s1_arbitrator (
                           // inputs:
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_read,
                            cpu_data_master_waitrequest,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            dig_s1_readdata,
                            reset_n,

                           // outputs:
                            cpu_data_master_granted_dig_s1,
                            cpu_data_master_qualified_request_dig_s1,
                            cpu_data_master_read_data_valid_dig_s1,
                            cpu_data_master_requests_dig_s1,
                            d1_dig_s1_end_xfer,
                            dig_s1_address,
                            dig_s1_chipselect,
                            dig_s1_readdata_from_sa,
                            dig_s1_reset_n,
                            dig_s1_write_n,
                            dig_s1_writedata
                         )
;

  output           cpu_data_master_granted_dig_s1;
  output           cpu_data_master_qualified_request_dig_s1;
  output           cpu_data_master_read_data_valid_dig_s1;
  output           cpu_data_master_requests_dig_s1;
  output           d1_dig_s1_end_xfer;
  output  [  1: 0] dig_s1_address;
  output           dig_s1_chipselect;
  output  [ 31: 0] dig_s1_readdata_from_sa;
  output           dig_s1_reset_n;
  output           dig_s1_write_n;
  output  [ 31: 0] dig_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] dig_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_dig_s1;
  wire             cpu_data_master_qualified_request_dig_s1;
  wire             cpu_data_master_read_data_valid_dig_s1;
  wire             cpu_data_master_requests_dig_s1;
  wire             cpu_data_master_saved_grant_dig_s1;
  reg              d1_dig_s1_end_xfer;
  reg              d1_reasons_to_wait;
  wire    [  1: 0] dig_s1_address;
  wire             dig_s1_allgrants;
  wire             dig_s1_allow_new_arb_cycle;
  wire             dig_s1_any_bursting_master_saved_grant;
  wire             dig_s1_any_continuerequest;
  wire             dig_s1_arb_counter_enable;
  reg     [  1: 0] dig_s1_arb_share_counter;
  wire    [  1: 0] dig_s1_arb_share_counter_next_value;
  wire    [  1: 0] dig_s1_arb_share_set_values;
  wire             dig_s1_beginbursttransfer_internal;
  wire             dig_s1_begins_xfer;
  wire             dig_s1_chipselect;
  wire             dig_s1_end_xfer;
  wire             dig_s1_firsttransfer;
  wire             dig_s1_grant_vector;
  wire             dig_s1_in_a_read_cycle;
  wire             dig_s1_in_a_write_cycle;
  wire             dig_s1_master_qreq_vector;
  wire             dig_s1_non_bursting_master_requests;
  wire    [ 31: 0] dig_s1_readdata_from_sa;
  reg              dig_s1_reg_firsttransfer;
  wire             dig_s1_reset_n;
  reg              dig_s1_slavearbiterlockenable;
  wire             dig_s1_slavearbiterlockenable2;
  wire             dig_s1_unreg_firsttransfer;
  wire             dig_s1_waits_for_read;
  wire             dig_s1_waits_for_write;
  wire             dig_s1_write_n;
  wire    [ 31: 0] dig_s1_writedata;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_dig_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_dig_s1_from_cpu_data_master;
  wire             wait_for_dig_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~dig_s1_end_xfer;
    end


  assign dig_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_dig_s1));
  //assign dig_s1_readdata_from_sa = dig_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign dig_s1_readdata_from_sa = dig_s1_readdata;

  assign cpu_data_master_requests_dig_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18e0) & (cpu_data_master_read | cpu_data_master_write);
  //dig_s1_arb_share_counter set values, which is an e_mux
  assign dig_s1_arb_share_set_values = 1;

  //dig_s1_non_bursting_master_requests mux, which is an e_mux
  assign dig_s1_non_bursting_master_requests = cpu_data_master_requests_dig_s1;

  //dig_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign dig_s1_any_bursting_master_saved_grant = 0;

  //dig_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign dig_s1_arb_share_counter_next_value = dig_s1_firsttransfer ? (dig_s1_arb_share_set_values - 1) : |dig_s1_arb_share_counter ? (dig_s1_arb_share_counter - 1) : 0;

  //dig_s1_allgrants all slave grants, which is an e_mux
  assign dig_s1_allgrants = |dig_s1_grant_vector;

  //dig_s1_end_xfer assignment, which is an e_assign
  assign dig_s1_end_xfer = ~(dig_s1_waits_for_read | dig_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_dig_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_dig_s1 = dig_s1_end_xfer & (~dig_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //dig_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign dig_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_dig_s1 & dig_s1_allgrants) | (end_xfer_arb_share_counter_term_dig_s1 & ~dig_s1_non_bursting_master_requests);

  //dig_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dig_s1_arb_share_counter <= 0;
      else if (dig_s1_arb_counter_enable)
          dig_s1_arb_share_counter <= dig_s1_arb_share_counter_next_value;
    end


  //dig_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dig_s1_slavearbiterlockenable <= 0;
      else if ((|dig_s1_master_qreq_vector & end_xfer_arb_share_counter_term_dig_s1) | (end_xfer_arb_share_counter_term_dig_s1 & ~dig_s1_non_bursting_master_requests))
          dig_s1_slavearbiterlockenable <= |dig_s1_arb_share_counter_next_value;
    end


  //cpu/data_master dig/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = dig_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //dig_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign dig_s1_slavearbiterlockenable2 = |dig_s1_arb_share_counter_next_value;

  //cpu/data_master dig/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = dig_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //dig_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign dig_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_dig_s1 = cpu_data_master_requests_dig_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //dig_s1_writedata mux, which is an e_mux
  assign dig_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_dig_s1 = cpu_data_master_qualified_request_dig_s1;

  //cpu/data_master saved-grant dig/s1, which is an e_assign
  assign cpu_data_master_saved_grant_dig_s1 = cpu_data_master_requests_dig_s1;

  //allow new arb cycle for dig/s1, which is an e_assign
  assign dig_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign dig_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign dig_s1_master_qreq_vector = 1;

  //dig_s1_reset_n assignment, which is an e_assign
  assign dig_s1_reset_n = reset_n;

  assign dig_s1_chipselect = cpu_data_master_granted_dig_s1;
  //dig_s1_firsttransfer first transaction, which is an e_assign
  assign dig_s1_firsttransfer = dig_s1_begins_xfer ? dig_s1_unreg_firsttransfer : dig_s1_reg_firsttransfer;

  //dig_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign dig_s1_unreg_firsttransfer = ~(dig_s1_slavearbiterlockenable & dig_s1_any_continuerequest);

  //dig_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dig_s1_reg_firsttransfer <= 1'b1;
      else if (dig_s1_begins_xfer)
          dig_s1_reg_firsttransfer <= dig_s1_unreg_firsttransfer;
    end


  //dig_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign dig_s1_beginbursttransfer_internal = dig_s1_begins_xfer;

  //~dig_s1_write_n assignment, which is an e_mux
  assign dig_s1_write_n = ~(cpu_data_master_granted_dig_s1 & cpu_data_master_write);

  assign shifted_address_to_dig_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //dig_s1_address mux, which is an e_mux
  assign dig_s1_address = shifted_address_to_dig_s1_from_cpu_data_master >> 2;

  //d1_dig_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_dig_s1_end_xfer <= 1;
      else 
        d1_dig_s1_end_xfer <= dig_s1_end_xfer;
    end


  //dig_s1_waits_for_read in a cycle, which is an e_mux
  assign dig_s1_waits_for_read = dig_s1_in_a_read_cycle & dig_s1_begins_xfer;

  //dig_s1_in_a_read_cycle assignment, which is an e_assign
  assign dig_s1_in_a_read_cycle = cpu_data_master_granted_dig_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = dig_s1_in_a_read_cycle;

  //dig_s1_waits_for_write in a cycle, which is an e_mux
  assign dig_s1_waits_for_write = dig_s1_in_a_write_cycle & 0;

  //dig_s1_in_a_write_cycle assignment, which is an e_assign
  assign dig_s1_in_a_write_cycle = cpu_data_master_granted_dig_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = dig_s1_in_a_write_cycle;

  assign wait_for_dig_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //dig/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module epcs_epcs_control_port_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_data_master_address_to_slave,
                                            cpu_data_master_read,
                                            cpu_data_master_write,
                                            cpu_data_master_writedata,
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                            epcs_epcs_control_port_dataavailable,
                                            epcs_epcs_control_port_endofpacket,
                                            epcs_epcs_control_port_irq,
                                            epcs_epcs_control_port_readdata,
                                            epcs_epcs_control_port_readyfordata,
                                            reset_n,

                                           // outputs:
                                            cpu_data_master_granted_epcs_epcs_control_port,
                                            cpu_data_master_qualified_request_epcs_epcs_control_port,
                                            cpu_data_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_data_master_requests_epcs_epcs_control_port,
                                            cpu_instruction_master_granted_epcs_epcs_control_port,
                                            cpu_instruction_master_qualified_request_epcs_epcs_control_port,
                                            cpu_instruction_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_instruction_master_requests_epcs_epcs_control_port,
                                            d1_epcs_epcs_control_port_end_xfer,
                                            epcs_epcs_control_port_address,
                                            epcs_epcs_control_port_chipselect,
                                            epcs_epcs_control_port_dataavailable_from_sa,
                                            epcs_epcs_control_port_endofpacket_from_sa,
                                            epcs_epcs_control_port_irq_from_sa,
                                            epcs_epcs_control_port_read_n,
                                            epcs_epcs_control_port_readdata_from_sa,
                                            epcs_epcs_control_port_readyfordata_from_sa,
                                            epcs_epcs_control_port_reset_n,
                                            epcs_epcs_control_port_write_n,
                                            epcs_epcs_control_port_writedata
                                         )
;

  output           cpu_data_master_granted_epcs_epcs_control_port;
  output           cpu_data_master_qualified_request_epcs_epcs_control_port;
  output           cpu_data_master_read_data_valid_epcs_epcs_control_port;
  output           cpu_data_master_requests_epcs_epcs_control_port;
  output           cpu_instruction_master_granted_epcs_epcs_control_port;
  output           cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  output           cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  output           cpu_instruction_master_requests_epcs_epcs_control_port;
  output           d1_epcs_epcs_control_port_end_xfer;
  output  [  8: 0] epcs_epcs_control_port_address;
  output           epcs_epcs_control_port_chipselect;
  output           epcs_epcs_control_port_dataavailable_from_sa;
  output           epcs_epcs_control_port_endofpacket_from_sa;
  output           epcs_epcs_control_port_irq_from_sa;
  output           epcs_epcs_control_port_read_n;
  output  [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  output           epcs_epcs_control_port_readyfordata_from_sa;
  output           epcs_epcs_control_port_reset_n;
  output           epcs_epcs_control_port_write_n;
  output  [ 31: 0] epcs_epcs_control_port_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input            epcs_epcs_control_port_dataavailable;
  input            epcs_epcs_control_port_endofpacket;
  input            epcs_epcs_control_port_irq;
  input   [ 31: 0] epcs_epcs_control_port_readdata;
  input            epcs_epcs_control_port_readyfordata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_epcs_epcs_control_port;
  wire             cpu_data_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_data_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_data_master_requests_epcs_epcs_control_port;
  wire             cpu_data_master_saved_grant_epcs_epcs_control_port;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_epcs_epcs_control_port;
  wire             cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_instruction_master_requests_epcs_epcs_control_port;
  wire             cpu_instruction_master_saved_grant_epcs_epcs_control_port;
  reg              d1_epcs_epcs_control_port_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_epcs_epcs_control_port;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_allgrants;
  wire             epcs_epcs_control_port_allow_new_arb_cycle;
  wire             epcs_epcs_control_port_any_bursting_master_saved_grant;
  wire             epcs_epcs_control_port_any_continuerequest;
  reg     [  1: 0] epcs_epcs_control_port_arb_addend;
  wire             epcs_epcs_control_port_arb_counter_enable;
  reg     [  1: 0] epcs_epcs_control_port_arb_share_counter;
  wire    [  1: 0] epcs_epcs_control_port_arb_share_counter_next_value;
  wire    [  1: 0] epcs_epcs_control_port_arb_share_set_values;
  wire    [  1: 0] epcs_epcs_control_port_arb_winner;
  wire             epcs_epcs_control_port_arbitration_holdoff_internal;
  wire             epcs_epcs_control_port_beginbursttransfer_internal;
  wire             epcs_epcs_control_port_begins_xfer;
  wire             epcs_epcs_control_port_chipselect;
  wire    [  3: 0] epcs_epcs_control_port_chosen_master_double_vector;
  wire    [  1: 0] epcs_epcs_control_port_chosen_master_rot_left;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_end_xfer;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_firsttransfer;
  wire    [  1: 0] epcs_epcs_control_port_grant_vector;
  wire             epcs_epcs_control_port_in_a_read_cycle;
  wire             epcs_epcs_control_port_in_a_write_cycle;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire    [  1: 0] epcs_epcs_control_port_master_qreq_vector;
  wire             epcs_epcs_control_port_non_bursting_master_requests;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  reg              epcs_epcs_control_port_reg_firsttransfer;
  wire             epcs_epcs_control_port_reset_n;
  reg     [  1: 0] epcs_epcs_control_port_saved_chosen_master_vector;
  reg              epcs_epcs_control_port_slavearbiterlockenable;
  wire             epcs_epcs_control_port_slavearbiterlockenable2;
  wire             epcs_epcs_control_port_unreg_firsttransfer;
  wire             epcs_epcs_control_port_waits_for_read;
  wire             epcs_epcs_control_port_waits_for_write;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port;
  reg              last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port;
  wire    [ 26: 0] shifted_address_to_epcs_epcs_control_port_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master;
  wire             wait_for_epcs_epcs_control_port_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~epcs_epcs_control_port_end_xfer;
    end


  assign epcs_epcs_control_port_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_epcs_epcs_control_port | cpu_instruction_master_qualified_request_epcs_epcs_control_port));
  //assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata;

  assign cpu_data_master_requests_epcs_epcs_control_port = ({cpu_data_master_address_to_slave[26 : 11] , 11'b0} == 27'h0) & (cpu_data_master_read | cpu_data_master_write);
  //assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable;

  //assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata;

  //epcs_epcs_control_port_arb_share_counter set values, which is an e_mux
  assign epcs_epcs_control_port_arb_share_set_values = 1;

  //epcs_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  assign epcs_epcs_control_port_non_bursting_master_requests = cpu_data_master_requests_epcs_epcs_control_port |
    cpu_instruction_master_requests_epcs_epcs_control_port |
    cpu_data_master_requests_epcs_epcs_control_port |
    cpu_instruction_master_requests_epcs_epcs_control_port;

  //epcs_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  assign epcs_epcs_control_port_any_bursting_master_saved_grant = 0;

  //epcs_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  assign epcs_epcs_control_port_arb_share_counter_next_value = epcs_epcs_control_port_firsttransfer ? (epcs_epcs_control_port_arb_share_set_values - 1) : |epcs_epcs_control_port_arb_share_counter ? (epcs_epcs_control_port_arb_share_counter - 1) : 0;

  //epcs_epcs_control_port_allgrants all slave grants, which is an e_mux
  assign epcs_epcs_control_port_allgrants = (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector);

  //epcs_epcs_control_port_end_xfer assignment, which is an e_assign
  assign epcs_epcs_control_port_end_xfer = ~(epcs_epcs_control_port_waits_for_read | epcs_epcs_control_port_waits_for_write);

  //end_xfer_arb_share_counter_term_epcs_epcs_control_port arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_epcs_epcs_control_port = epcs_epcs_control_port_end_xfer & (~epcs_epcs_control_port_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //epcs_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  assign epcs_epcs_control_port_arb_counter_enable = (end_xfer_arb_share_counter_term_epcs_epcs_control_port & epcs_epcs_control_port_allgrants) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests);

  //epcs_epcs_control_port_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_arb_share_counter <= 0;
      else if (epcs_epcs_control_port_arb_counter_enable)
          epcs_epcs_control_port_arb_share_counter <= epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //epcs_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_slavearbiterlockenable <= 0;
      else if ((|epcs_epcs_control_port_master_qreq_vector & end_xfer_arb_share_counter_term_epcs_epcs_control_port) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests))
          epcs_epcs_control_port_slavearbiterlockenable <= |epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //cpu/data_master epcs/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = epcs_epcs_control_port_slavearbiterlockenable & cpu_data_master_continuerequest;

  //epcs_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign epcs_epcs_control_port_slavearbiterlockenable2 = |epcs_epcs_control_port_arb_share_counter_next_value;

  //cpu/data_master epcs/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = epcs_epcs_control_port_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master epcs/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = epcs_epcs_control_port_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master epcs/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = epcs_epcs_control_port_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted epcs/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port <= cpu_instruction_master_saved_grant_epcs_epcs_control_port ? 1 : (epcs_epcs_control_port_arbitration_holdoff_internal | ~cpu_instruction_master_requests_epcs_epcs_control_port) ? 0 : last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port & cpu_instruction_master_requests_epcs_epcs_control_port;

  //epcs_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  assign epcs_epcs_control_port_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_epcs_epcs_control_port = cpu_data_master_requests_epcs_epcs_control_port & ~(cpu_instruction_master_arbiterlock);
  //epcs_epcs_control_port_writedata mux, which is an e_mux
  assign epcs_epcs_control_port_writedata = cpu_data_master_writedata;

  //assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket;

  assign cpu_instruction_master_requests_epcs_epcs_control_port = (({cpu_instruction_master_address_to_slave[26 : 11] , 11'b0} == 27'h0) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted epcs/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port <= cpu_data_master_saved_grant_epcs_epcs_control_port ? 1 : (epcs_epcs_control_port_arbitration_holdoff_internal | ~cpu_data_master_requests_epcs_epcs_control_port) ? 0 : last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port & cpu_data_master_requests_epcs_epcs_control_port;

  assign cpu_instruction_master_qualified_request_epcs_epcs_control_port = cpu_instruction_master_requests_epcs_epcs_control_port & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_epcs_epcs_control_port, which is an e_mux
  assign cpu_instruction_master_read_data_valid_epcs_epcs_control_port = cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read & ~epcs_epcs_control_port_waits_for_read;

  //allow new arb cycle for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_master_qreq_vector[0] = cpu_instruction_master_qualified_request_epcs_epcs_control_port;

  //cpu/instruction_master grant epcs/epcs_control_port, which is an e_assign
  assign cpu_instruction_master_granted_epcs_epcs_control_port = epcs_epcs_control_port_grant_vector[0];

  //cpu/instruction_master saved-grant epcs/epcs_control_port, which is an e_assign
  assign cpu_instruction_master_saved_grant_epcs_epcs_control_port = epcs_epcs_control_port_arb_winner[0] && cpu_instruction_master_requests_epcs_epcs_control_port;

  //cpu/data_master assignment into master qualified-requests vector for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_master_qreq_vector[1] = cpu_data_master_qualified_request_epcs_epcs_control_port;

  //cpu/data_master grant epcs/epcs_control_port, which is an e_assign
  assign cpu_data_master_granted_epcs_epcs_control_port = epcs_epcs_control_port_grant_vector[1];

  //cpu/data_master saved-grant epcs/epcs_control_port, which is an e_assign
  assign cpu_data_master_saved_grant_epcs_epcs_control_port = epcs_epcs_control_port_arb_winner[1] && cpu_data_master_requests_epcs_epcs_control_port;

  //epcs/epcs_control_port chosen-master double-vector, which is an e_assign
  assign epcs_epcs_control_port_chosen_master_double_vector = {epcs_epcs_control_port_master_qreq_vector, epcs_epcs_control_port_master_qreq_vector} & ({~epcs_epcs_control_port_master_qreq_vector, ~epcs_epcs_control_port_master_qreq_vector} + epcs_epcs_control_port_arb_addend);

  //stable onehot encoding of arb winner
  assign epcs_epcs_control_port_arb_winner = (epcs_epcs_control_port_allow_new_arb_cycle & | epcs_epcs_control_port_grant_vector) ? epcs_epcs_control_port_grant_vector : epcs_epcs_control_port_saved_chosen_master_vector;

  //saved epcs_epcs_control_port_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_saved_chosen_master_vector <= 0;
      else if (epcs_epcs_control_port_allow_new_arb_cycle)
          epcs_epcs_control_port_saved_chosen_master_vector <= |epcs_epcs_control_port_grant_vector ? epcs_epcs_control_port_grant_vector : epcs_epcs_control_port_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign epcs_epcs_control_port_grant_vector = {(epcs_epcs_control_port_chosen_master_double_vector[1] | epcs_epcs_control_port_chosen_master_double_vector[3]),
    (epcs_epcs_control_port_chosen_master_double_vector[0] | epcs_epcs_control_port_chosen_master_double_vector[2])};

  //epcs/epcs_control_port chosen master rotated left, which is an e_assign
  assign epcs_epcs_control_port_chosen_master_rot_left = (epcs_epcs_control_port_arb_winner << 1) ? (epcs_epcs_control_port_arb_winner << 1) : 1;

  //epcs/epcs_control_port's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_arb_addend <= 1;
      else if (|epcs_epcs_control_port_grant_vector)
          epcs_epcs_control_port_arb_addend <= epcs_epcs_control_port_end_xfer? epcs_epcs_control_port_chosen_master_rot_left : epcs_epcs_control_port_grant_vector;
    end


  //epcs_epcs_control_port_reset_n assignment, which is an e_assign
  assign epcs_epcs_control_port_reset_n = reset_n;

  assign epcs_epcs_control_port_chipselect = cpu_data_master_granted_epcs_epcs_control_port | cpu_instruction_master_granted_epcs_epcs_control_port;
  //epcs_epcs_control_port_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_firsttransfer = epcs_epcs_control_port_begins_xfer ? epcs_epcs_control_port_unreg_firsttransfer : epcs_epcs_control_port_reg_firsttransfer;

  //epcs_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_unreg_firsttransfer = ~(epcs_epcs_control_port_slavearbiterlockenable & epcs_epcs_control_port_any_continuerequest);

  //epcs_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_reg_firsttransfer <= 1'b1;
      else if (epcs_epcs_control_port_begins_xfer)
          epcs_epcs_control_port_reg_firsttransfer <= epcs_epcs_control_port_unreg_firsttransfer;
    end


  //epcs_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign epcs_epcs_control_port_beginbursttransfer_internal = epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign epcs_epcs_control_port_arbitration_holdoff_internal = epcs_epcs_control_port_begins_xfer & epcs_epcs_control_port_firsttransfer;

  //~epcs_epcs_control_port_read_n assignment, which is an e_mux
  assign epcs_epcs_control_port_read_n = ~((cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_read) | (cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read));

  //~epcs_epcs_control_port_write_n assignment, which is an e_mux
  assign epcs_epcs_control_port_write_n = ~(cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_write);

  assign shifted_address_to_epcs_epcs_control_port_from_cpu_data_master = cpu_data_master_address_to_slave;
  //epcs_epcs_control_port_address mux, which is an e_mux
  assign epcs_epcs_control_port_address = (cpu_data_master_granted_epcs_epcs_control_port)? (shifted_address_to_epcs_epcs_control_port_from_cpu_data_master >> 2) :
    (shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master >> 2);

  assign shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_epcs_epcs_control_port_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_epcs_epcs_control_port_end_xfer <= 1;
      else 
        d1_epcs_epcs_control_port_end_xfer <= epcs_epcs_control_port_end_xfer;
    end


  //epcs_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_read = epcs_epcs_control_port_in_a_read_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_read_cycle = (cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_read) | (cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = epcs_epcs_control_port_in_a_read_cycle;

  //epcs_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_write = epcs_epcs_control_port_in_a_write_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_write_cycle = cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = epcs_epcs_control_port_in_a_write_cycle;

  assign wait_for_epcs_epcs_control_port_counter = 0;
  //assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //epcs/epcs_control_port enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_epcs_epcs_control_port + cpu_instruction_master_granted_epcs_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_epcs_epcs_control_port + cpu_instruction_master_saved_grant_epcs_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_avalon_jtag_slave_arbitrator (
                                                // inputs:
                                                 clk,
                                                 cpu_data_master_address_to_slave,
                                                 cpu_data_master_read,
                                                 cpu_data_master_waitrequest,
                                                 cpu_data_master_write,
                                                 cpu_data_master_writedata,
                                                 jtag_uart_avalon_jtag_slave_dataavailable,
                                                 jtag_uart_avalon_jtag_slave_irq,
                                                 jtag_uart_avalon_jtag_slave_readdata,
                                                 jtag_uart_avalon_jtag_slave_readyfordata,
                                                 jtag_uart_avalon_jtag_slave_waitrequest,
                                                 reset_n,

                                                // outputs:
                                                 cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                                 d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                                 jtag_uart_avalon_jtag_slave_address,
                                                 jtag_uart_avalon_jtag_slave_chipselect,
                                                 jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
                                                 jtag_uart_avalon_jtag_slave_irq_from_sa,
                                                 jtag_uart_avalon_jtag_slave_read_n,
                                                 jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_reset_n,
                                                 jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                                 jtag_uart_avalon_jtag_slave_write_n,
                                                 jtag_uart_avalon_jtag_slave_writedata
                                              )
;

  output           cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  output           d1_jtag_uart_avalon_jtag_slave_end_xfer;
  output           jtag_uart_avalon_jtag_slave_address;
  output           jtag_uart_avalon_jtag_slave_chipselect;
  output           jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_avalon_jtag_slave_reset_n;
  output           jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            jtag_uart_avalon_jtag_slave_dataavailable;
  input            jtag_uart_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  input            jtag_uart_avalon_jtag_slave_readyfordata;
  input            jtag_uart_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave;
  reg              d1_jtag_uart_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_allgrants;
  wire             jtag_uart_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  reg              jtag_uart_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [ 26: 0] shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master;
  wire             wait_for_jtag_uart_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave));
  //assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata;

  assign cpu_data_master_requests_jtag_uart_avalon_jtag_slave = ({cpu_data_master_address_to_slave[26 : 3] , 3'b0} == 27'h1908) & (cpu_data_master_read | cpu_data_master_write);
  //assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest;

  //jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_non_bursting_master_requests = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_avalon_jtag_slave_firsttransfer ? (jtag_uart_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_avalon_jtag_slave_arb_share_counter ? (jtag_uart_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_allgrants = |jtag_uart_avalon_jtag_slave_grant_vector;

  //jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_end_xfer = ~(jtag_uart_avalon_jtag_slave_waits_for_read | jtag_uart_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave = jtag_uart_avalon_jtag_slave_end_xfer & (~jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & jtag_uart_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = jtag_uart_avalon_jtag_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave & ~((cpu_data_master_read & (~cpu_data_master_waitrequest)) | ((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_jtag_uart_avalon_jtag_slave = cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;

  //cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  assign cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_avalon_jtag_slave_chipselect = cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  //jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_firsttransfer = jtag_uart_avalon_jtag_slave_begins_xfer ? jtag_uart_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_avalon_jtag_slave_begins_xfer)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_read_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read);

  //~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_write_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write);

  assign shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_address = shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master >> 2;

  //d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_read = jtag_uart_avalon_jtag_slave_in_a_read_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_read_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_write = jtag_uart_avalon_jtag_slave_in_a_write_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_write_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module led_s1_arbitrator (
                           // inputs:
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_read,
                            cpu_data_master_waitrequest,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            led_s1_readdata,
                            reset_n,

                           // outputs:
                            cpu_data_master_granted_led_s1,
                            cpu_data_master_qualified_request_led_s1,
                            cpu_data_master_read_data_valid_led_s1,
                            cpu_data_master_requests_led_s1,
                            d1_led_s1_end_xfer,
                            led_s1_address,
                            led_s1_chipselect,
                            led_s1_readdata_from_sa,
                            led_s1_reset_n,
                            led_s1_write_n,
                            led_s1_writedata
                         )
;

  output           cpu_data_master_granted_led_s1;
  output           cpu_data_master_qualified_request_led_s1;
  output           cpu_data_master_read_data_valid_led_s1;
  output           cpu_data_master_requests_led_s1;
  output           d1_led_s1_end_xfer;
  output  [  1: 0] led_s1_address;
  output           led_s1_chipselect;
  output  [ 31: 0] led_s1_readdata_from_sa;
  output           led_s1_reset_n;
  output           led_s1_write_n;
  output  [ 31: 0] led_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] led_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_led_s1;
  wire             cpu_data_master_qualified_request_led_s1;
  wire             cpu_data_master_read_data_valid_led_s1;
  wire             cpu_data_master_requests_led_s1;
  wire             cpu_data_master_saved_grant_led_s1;
  reg              d1_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] led_s1_address;
  wire             led_s1_allgrants;
  wire             led_s1_allow_new_arb_cycle;
  wire             led_s1_any_bursting_master_saved_grant;
  wire             led_s1_any_continuerequest;
  wire             led_s1_arb_counter_enable;
  reg     [  1: 0] led_s1_arb_share_counter;
  wire    [  1: 0] led_s1_arb_share_counter_next_value;
  wire    [  1: 0] led_s1_arb_share_set_values;
  wire             led_s1_beginbursttransfer_internal;
  wire             led_s1_begins_xfer;
  wire             led_s1_chipselect;
  wire             led_s1_end_xfer;
  wire             led_s1_firsttransfer;
  wire             led_s1_grant_vector;
  wire             led_s1_in_a_read_cycle;
  wire             led_s1_in_a_write_cycle;
  wire             led_s1_master_qreq_vector;
  wire             led_s1_non_bursting_master_requests;
  wire    [ 31: 0] led_s1_readdata_from_sa;
  reg              led_s1_reg_firsttransfer;
  wire             led_s1_reset_n;
  reg              led_s1_slavearbiterlockenable;
  wire             led_s1_slavearbiterlockenable2;
  wire             led_s1_unreg_firsttransfer;
  wire             led_s1_waits_for_read;
  wire             led_s1_waits_for_write;
  wire             led_s1_write_n;
  wire    [ 31: 0] led_s1_writedata;
  wire    [ 26: 0] shifted_address_to_led_s1_from_cpu_data_master;
  wire             wait_for_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~led_s1_end_xfer;
    end


  assign led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_led_s1));
  //assign led_s1_readdata_from_sa = led_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign led_s1_readdata_from_sa = led_s1_readdata;

  assign cpu_data_master_requests_led_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1840) & (cpu_data_master_read | cpu_data_master_write);
  //led_s1_arb_share_counter set values, which is an e_mux
  assign led_s1_arb_share_set_values = 1;

  //led_s1_non_bursting_master_requests mux, which is an e_mux
  assign led_s1_non_bursting_master_requests = cpu_data_master_requests_led_s1;

  //led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign led_s1_any_bursting_master_saved_grant = 0;

  //led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign led_s1_arb_share_counter_next_value = led_s1_firsttransfer ? (led_s1_arb_share_set_values - 1) : |led_s1_arb_share_counter ? (led_s1_arb_share_counter - 1) : 0;

  //led_s1_allgrants all slave grants, which is an e_mux
  assign led_s1_allgrants = |led_s1_grant_vector;

  //led_s1_end_xfer assignment, which is an e_assign
  assign led_s1_end_xfer = ~(led_s1_waits_for_read | led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_led_s1 = led_s1_end_xfer & (~led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_led_s1 & led_s1_allgrants) | (end_xfer_arb_share_counter_term_led_s1 & ~led_s1_non_bursting_master_requests);

  //led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_arb_share_counter <= 0;
      else if (led_s1_arb_counter_enable)
          led_s1_arb_share_counter <= led_s1_arb_share_counter_next_value;
    end


  //led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_slavearbiterlockenable <= 0;
      else if ((|led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_led_s1) | (end_xfer_arb_share_counter_term_led_s1 & ~led_s1_non_bursting_master_requests))
          led_s1_slavearbiterlockenable <= |led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign led_s1_slavearbiterlockenable2 = |led_s1_arb_share_counter_next_value;

  //cpu/data_master led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_led_s1 = cpu_data_master_requests_led_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //led_s1_writedata mux, which is an e_mux
  assign led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_led_s1 = cpu_data_master_qualified_request_led_s1;

  //cpu/data_master saved-grant led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_led_s1 = cpu_data_master_requests_led_s1;

  //allow new arb cycle for led/s1, which is an e_assign
  assign led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign led_s1_master_qreq_vector = 1;

  //led_s1_reset_n assignment, which is an e_assign
  assign led_s1_reset_n = reset_n;

  assign led_s1_chipselect = cpu_data_master_granted_led_s1;
  //led_s1_firsttransfer first transaction, which is an e_assign
  assign led_s1_firsttransfer = led_s1_begins_xfer ? led_s1_unreg_firsttransfer : led_s1_reg_firsttransfer;

  //led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign led_s1_unreg_firsttransfer = ~(led_s1_slavearbiterlockenable & led_s1_any_continuerequest);

  //led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_s1_reg_firsttransfer <= 1'b1;
      else if (led_s1_begins_xfer)
          led_s1_reg_firsttransfer <= led_s1_unreg_firsttransfer;
    end


  //led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign led_s1_beginbursttransfer_internal = led_s1_begins_xfer;

  //~led_s1_write_n assignment, which is an e_mux
  assign led_s1_write_n = ~(cpu_data_master_granted_led_s1 & cpu_data_master_write);

  assign shifted_address_to_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //led_s1_address mux, which is an e_mux
  assign led_s1_address = shifted_address_to_led_s1_from_cpu_data_master >> 2;

  //d1_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_led_s1_end_xfer <= 1;
      else 
        d1_led_s1_end_xfer <= led_s1_end_xfer;
    end


  //led_s1_waits_for_read in a cycle, which is an e_mux
  assign led_s1_waits_for_read = led_s1_in_a_read_cycle & led_s1_begins_xfer;

  //led_s1_in_a_read_cycle assignment, which is an e_assign
  assign led_s1_in_a_read_cycle = cpu_data_master_granted_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = led_s1_in_a_read_cycle;

  //led_s1_waits_for_write in a cycle, which is an e_mux
  assign led_s1_waits_for_write = led_s1_in_a_write_cycle & 0;

  //led_s1_in_a_write_cycle assignment, which is an e_assign
  assign led_s1_in_a_write_cycle = cpu_data_master_granted_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = led_s1_in_a_write_cycle;

  assign wait_for_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rtc_data_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_read,
                                 cpu_data_master_waitrequest,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 reset_n,
                                 rtc_data_s1_readdata,

                                // outputs:
                                 cpu_data_master_granted_rtc_data_s1,
                                 cpu_data_master_qualified_request_rtc_data_s1,
                                 cpu_data_master_read_data_valid_rtc_data_s1,
                                 cpu_data_master_requests_rtc_data_s1,
                                 d1_rtc_data_s1_end_xfer,
                                 rtc_data_s1_address,
                                 rtc_data_s1_chipselect,
                                 rtc_data_s1_readdata_from_sa,
                                 rtc_data_s1_reset_n,
                                 rtc_data_s1_write_n,
                                 rtc_data_s1_writedata
                              )
;

  output           cpu_data_master_granted_rtc_data_s1;
  output           cpu_data_master_qualified_request_rtc_data_s1;
  output           cpu_data_master_read_data_valid_rtc_data_s1;
  output           cpu_data_master_requests_rtc_data_s1;
  output           d1_rtc_data_s1_end_xfer;
  output  [  1: 0] rtc_data_s1_address;
  output           rtc_data_s1_chipselect;
  output  [ 31: 0] rtc_data_s1_readdata_from_sa;
  output           rtc_data_s1_reset_n;
  output           rtc_data_s1_write_n;
  output  [ 31: 0] rtc_data_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] rtc_data_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_rtc_data_s1;
  wire             cpu_data_master_qualified_request_rtc_data_s1;
  wire             cpu_data_master_read_data_valid_rtc_data_s1;
  wire             cpu_data_master_requests_rtc_data_s1;
  wire             cpu_data_master_saved_grant_rtc_data_s1;
  reg              d1_reasons_to_wait;
  reg              d1_rtc_data_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_rtc_data_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] rtc_data_s1_address;
  wire             rtc_data_s1_allgrants;
  wire             rtc_data_s1_allow_new_arb_cycle;
  wire             rtc_data_s1_any_bursting_master_saved_grant;
  wire             rtc_data_s1_any_continuerequest;
  wire             rtc_data_s1_arb_counter_enable;
  reg     [  1: 0] rtc_data_s1_arb_share_counter;
  wire    [  1: 0] rtc_data_s1_arb_share_counter_next_value;
  wire    [  1: 0] rtc_data_s1_arb_share_set_values;
  wire             rtc_data_s1_beginbursttransfer_internal;
  wire             rtc_data_s1_begins_xfer;
  wire             rtc_data_s1_chipselect;
  wire             rtc_data_s1_end_xfer;
  wire             rtc_data_s1_firsttransfer;
  wire             rtc_data_s1_grant_vector;
  wire             rtc_data_s1_in_a_read_cycle;
  wire             rtc_data_s1_in_a_write_cycle;
  wire             rtc_data_s1_master_qreq_vector;
  wire             rtc_data_s1_non_bursting_master_requests;
  wire    [ 31: 0] rtc_data_s1_readdata_from_sa;
  reg              rtc_data_s1_reg_firsttransfer;
  wire             rtc_data_s1_reset_n;
  reg              rtc_data_s1_slavearbiterlockenable;
  wire             rtc_data_s1_slavearbiterlockenable2;
  wire             rtc_data_s1_unreg_firsttransfer;
  wire             rtc_data_s1_waits_for_read;
  wire             rtc_data_s1_waits_for_write;
  wire             rtc_data_s1_write_n;
  wire    [ 31: 0] rtc_data_s1_writedata;
  wire    [ 26: 0] shifted_address_to_rtc_data_s1_from_cpu_data_master;
  wire             wait_for_rtc_data_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~rtc_data_s1_end_xfer;
    end


  assign rtc_data_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_rtc_data_s1));
  //assign rtc_data_s1_readdata_from_sa = rtc_data_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign rtc_data_s1_readdata_from_sa = rtc_data_s1_readdata;

  assign cpu_data_master_requests_rtc_data_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18c0) & (cpu_data_master_read | cpu_data_master_write);
  //rtc_data_s1_arb_share_counter set values, which is an e_mux
  assign rtc_data_s1_arb_share_set_values = 1;

  //rtc_data_s1_non_bursting_master_requests mux, which is an e_mux
  assign rtc_data_s1_non_bursting_master_requests = cpu_data_master_requests_rtc_data_s1;

  //rtc_data_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign rtc_data_s1_any_bursting_master_saved_grant = 0;

  //rtc_data_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign rtc_data_s1_arb_share_counter_next_value = rtc_data_s1_firsttransfer ? (rtc_data_s1_arb_share_set_values - 1) : |rtc_data_s1_arb_share_counter ? (rtc_data_s1_arb_share_counter - 1) : 0;

  //rtc_data_s1_allgrants all slave grants, which is an e_mux
  assign rtc_data_s1_allgrants = |rtc_data_s1_grant_vector;

  //rtc_data_s1_end_xfer assignment, which is an e_assign
  assign rtc_data_s1_end_xfer = ~(rtc_data_s1_waits_for_read | rtc_data_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_rtc_data_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_rtc_data_s1 = rtc_data_s1_end_xfer & (~rtc_data_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //rtc_data_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign rtc_data_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_rtc_data_s1 & rtc_data_s1_allgrants) | (end_xfer_arb_share_counter_term_rtc_data_s1 & ~rtc_data_s1_non_bursting_master_requests);

  //rtc_data_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_data_s1_arb_share_counter <= 0;
      else if (rtc_data_s1_arb_counter_enable)
          rtc_data_s1_arb_share_counter <= rtc_data_s1_arb_share_counter_next_value;
    end


  //rtc_data_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_data_s1_slavearbiterlockenable <= 0;
      else if ((|rtc_data_s1_master_qreq_vector & end_xfer_arb_share_counter_term_rtc_data_s1) | (end_xfer_arb_share_counter_term_rtc_data_s1 & ~rtc_data_s1_non_bursting_master_requests))
          rtc_data_s1_slavearbiterlockenable <= |rtc_data_s1_arb_share_counter_next_value;
    end


  //cpu/data_master rtc_data/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = rtc_data_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //rtc_data_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign rtc_data_s1_slavearbiterlockenable2 = |rtc_data_s1_arb_share_counter_next_value;

  //cpu/data_master rtc_data/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = rtc_data_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //rtc_data_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign rtc_data_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_rtc_data_s1 = cpu_data_master_requests_rtc_data_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //rtc_data_s1_writedata mux, which is an e_mux
  assign rtc_data_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_rtc_data_s1 = cpu_data_master_qualified_request_rtc_data_s1;

  //cpu/data_master saved-grant rtc_data/s1, which is an e_assign
  assign cpu_data_master_saved_grant_rtc_data_s1 = cpu_data_master_requests_rtc_data_s1;

  //allow new arb cycle for rtc_data/s1, which is an e_assign
  assign rtc_data_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign rtc_data_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign rtc_data_s1_master_qreq_vector = 1;

  //rtc_data_s1_reset_n assignment, which is an e_assign
  assign rtc_data_s1_reset_n = reset_n;

  assign rtc_data_s1_chipselect = cpu_data_master_granted_rtc_data_s1;
  //rtc_data_s1_firsttransfer first transaction, which is an e_assign
  assign rtc_data_s1_firsttransfer = rtc_data_s1_begins_xfer ? rtc_data_s1_unreg_firsttransfer : rtc_data_s1_reg_firsttransfer;

  //rtc_data_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign rtc_data_s1_unreg_firsttransfer = ~(rtc_data_s1_slavearbiterlockenable & rtc_data_s1_any_continuerequest);

  //rtc_data_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_data_s1_reg_firsttransfer <= 1'b1;
      else if (rtc_data_s1_begins_xfer)
          rtc_data_s1_reg_firsttransfer <= rtc_data_s1_unreg_firsttransfer;
    end


  //rtc_data_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign rtc_data_s1_beginbursttransfer_internal = rtc_data_s1_begins_xfer;

  //~rtc_data_s1_write_n assignment, which is an e_mux
  assign rtc_data_s1_write_n = ~(cpu_data_master_granted_rtc_data_s1 & cpu_data_master_write);

  assign shifted_address_to_rtc_data_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //rtc_data_s1_address mux, which is an e_mux
  assign rtc_data_s1_address = shifted_address_to_rtc_data_s1_from_cpu_data_master >> 2;

  //d1_rtc_data_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_rtc_data_s1_end_xfer <= 1;
      else 
        d1_rtc_data_s1_end_xfer <= rtc_data_s1_end_xfer;
    end


  //rtc_data_s1_waits_for_read in a cycle, which is an e_mux
  assign rtc_data_s1_waits_for_read = rtc_data_s1_in_a_read_cycle & rtc_data_s1_begins_xfer;

  //rtc_data_s1_in_a_read_cycle assignment, which is an e_assign
  assign rtc_data_s1_in_a_read_cycle = cpu_data_master_granted_rtc_data_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = rtc_data_s1_in_a_read_cycle;

  //rtc_data_s1_waits_for_write in a cycle, which is an e_mux
  assign rtc_data_s1_waits_for_write = rtc_data_s1_in_a_write_cycle & 0;

  //rtc_data_s1_in_a_write_cycle assignment, which is an e_assign
  assign rtc_data_s1_in_a_write_cycle = cpu_data_master_granted_rtc_data_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = rtc_data_s1_in_a_write_cycle;

  assign wait_for_rtc_data_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //rtc_data/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rtc_rst_n_s1_arbitrator (
                                 // inputs:
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_waitrequest,
                                  cpu_data_master_write,
                                  cpu_data_master_writedata,
                                  reset_n,
                                  rtc_rst_n_s1_readdata,

                                 // outputs:
                                  cpu_data_master_granted_rtc_rst_n_s1,
                                  cpu_data_master_qualified_request_rtc_rst_n_s1,
                                  cpu_data_master_read_data_valid_rtc_rst_n_s1,
                                  cpu_data_master_requests_rtc_rst_n_s1,
                                  d1_rtc_rst_n_s1_end_xfer,
                                  rtc_rst_n_s1_address,
                                  rtc_rst_n_s1_chipselect,
                                  rtc_rst_n_s1_readdata_from_sa,
                                  rtc_rst_n_s1_reset_n,
                                  rtc_rst_n_s1_write_n,
                                  rtc_rst_n_s1_writedata
                               )
;

  output           cpu_data_master_granted_rtc_rst_n_s1;
  output           cpu_data_master_qualified_request_rtc_rst_n_s1;
  output           cpu_data_master_read_data_valid_rtc_rst_n_s1;
  output           cpu_data_master_requests_rtc_rst_n_s1;
  output           d1_rtc_rst_n_s1_end_xfer;
  output  [  1: 0] rtc_rst_n_s1_address;
  output           rtc_rst_n_s1_chipselect;
  output  [ 31: 0] rtc_rst_n_s1_readdata_from_sa;
  output           rtc_rst_n_s1_reset_n;
  output           rtc_rst_n_s1_write_n;
  output  [ 31: 0] rtc_rst_n_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] rtc_rst_n_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_rtc_rst_n_s1;
  wire             cpu_data_master_qualified_request_rtc_rst_n_s1;
  wire             cpu_data_master_read_data_valid_rtc_rst_n_s1;
  wire             cpu_data_master_requests_rtc_rst_n_s1;
  wire             cpu_data_master_saved_grant_rtc_rst_n_s1;
  reg              d1_reasons_to_wait;
  reg              d1_rtc_rst_n_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_rtc_rst_n_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] rtc_rst_n_s1_address;
  wire             rtc_rst_n_s1_allgrants;
  wire             rtc_rst_n_s1_allow_new_arb_cycle;
  wire             rtc_rst_n_s1_any_bursting_master_saved_grant;
  wire             rtc_rst_n_s1_any_continuerequest;
  wire             rtc_rst_n_s1_arb_counter_enable;
  reg     [  1: 0] rtc_rst_n_s1_arb_share_counter;
  wire    [  1: 0] rtc_rst_n_s1_arb_share_counter_next_value;
  wire    [  1: 0] rtc_rst_n_s1_arb_share_set_values;
  wire             rtc_rst_n_s1_beginbursttransfer_internal;
  wire             rtc_rst_n_s1_begins_xfer;
  wire             rtc_rst_n_s1_chipselect;
  wire             rtc_rst_n_s1_end_xfer;
  wire             rtc_rst_n_s1_firsttransfer;
  wire             rtc_rst_n_s1_grant_vector;
  wire             rtc_rst_n_s1_in_a_read_cycle;
  wire             rtc_rst_n_s1_in_a_write_cycle;
  wire             rtc_rst_n_s1_master_qreq_vector;
  wire             rtc_rst_n_s1_non_bursting_master_requests;
  wire    [ 31: 0] rtc_rst_n_s1_readdata_from_sa;
  reg              rtc_rst_n_s1_reg_firsttransfer;
  wire             rtc_rst_n_s1_reset_n;
  reg              rtc_rst_n_s1_slavearbiterlockenable;
  wire             rtc_rst_n_s1_slavearbiterlockenable2;
  wire             rtc_rst_n_s1_unreg_firsttransfer;
  wire             rtc_rst_n_s1_waits_for_read;
  wire             rtc_rst_n_s1_waits_for_write;
  wire             rtc_rst_n_s1_write_n;
  wire    [ 31: 0] rtc_rst_n_s1_writedata;
  wire    [ 26: 0] shifted_address_to_rtc_rst_n_s1_from_cpu_data_master;
  wire             wait_for_rtc_rst_n_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~rtc_rst_n_s1_end_xfer;
    end


  assign rtc_rst_n_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_rtc_rst_n_s1));
  //assign rtc_rst_n_s1_readdata_from_sa = rtc_rst_n_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign rtc_rst_n_s1_readdata_from_sa = rtc_rst_n_s1_readdata;

  assign cpu_data_master_requests_rtc_rst_n_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18b0) & (cpu_data_master_read | cpu_data_master_write);
  //rtc_rst_n_s1_arb_share_counter set values, which is an e_mux
  assign rtc_rst_n_s1_arb_share_set_values = 1;

  //rtc_rst_n_s1_non_bursting_master_requests mux, which is an e_mux
  assign rtc_rst_n_s1_non_bursting_master_requests = cpu_data_master_requests_rtc_rst_n_s1;

  //rtc_rst_n_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign rtc_rst_n_s1_any_bursting_master_saved_grant = 0;

  //rtc_rst_n_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign rtc_rst_n_s1_arb_share_counter_next_value = rtc_rst_n_s1_firsttransfer ? (rtc_rst_n_s1_arb_share_set_values - 1) : |rtc_rst_n_s1_arb_share_counter ? (rtc_rst_n_s1_arb_share_counter - 1) : 0;

  //rtc_rst_n_s1_allgrants all slave grants, which is an e_mux
  assign rtc_rst_n_s1_allgrants = |rtc_rst_n_s1_grant_vector;

  //rtc_rst_n_s1_end_xfer assignment, which is an e_assign
  assign rtc_rst_n_s1_end_xfer = ~(rtc_rst_n_s1_waits_for_read | rtc_rst_n_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_rtc_rst_n_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_rtc_rst_n_s1 = rtc_rst_n_s1_end_xfer & (~rtc_rst_n_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //rtc_rst_n_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign rtc_rst_n_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_rtc_rst_n_s1 & rtc_rst_n_s1_allgrants) | (end_xfer_arb_share_counter_term_rtc_rst_n_s1 & ~rtc_rst_n_s1_non_bursting_master_requests);

  //rtc_rst_n_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_rst_n_s1_arb_share_counter <= 0;
      else if (rtc_rst_n_s1_arb_counter_enable)
          rtc_rst_n_s1_arb_share_counter <= rtc_rst_n_s1_arb_share_counter_next_value;
    end


  //rtc_rst_n_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_rst_n_s1_slavearbiterlockenable <= 0;
      else if ((|rtc_rst_n_s1_master_qreq_vector & end_xfer_arb_share_counter_term_rtc_rst_n_s1) | (end_xfer_arb_share_counter_term_rtc_rst_n_s1 & ~rtc_rst_n_s1_non_bursting_master_requests))
          rtc_rst_n_s1_slavearbiterlockenable <= |rtc_rst_n_s1_arb_share_counter_next_value;
    end


  //cpu/data_master rtc_rst_n/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = rtc_rst_n_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //rtc_rst_n_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign rtc_rst_n_s1_slavearbiterlockenable2 = |rtc_rst_n_s1_arb_share_counter_next_value;

  //cpu/data_master rtc_rst_n/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = rtc_rst_n_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //rtc_rst_n_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign rtc_rst_n_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_rtc_rst_n_s1 = cpu_data_master_requests_rtc_rst_n_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //rtc_rst_n_s1_writedata mux, which is an e_mux
  assign rtc_rst_n_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_rtc_rst_n_s1 = cpu_data_master_qualified_request_rtc_rst_n_s1;

  //cpu/data_master saved-grant rtc_rst_n/s1, which is an e_assign
  assign cpu_data_master_saved_grant_rtc_rst_n_s1 = cpu_data_master_requests_rtc_rst_n_s1;

  //allow new arb cycle for rtc_rst_n/s1, which is an e_assign
  assign rtc_rst_n_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign rtc_rst_n_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign rtc_rst_n_s1_master_qreq_vector = 1;

  //rtc_rst_n_s1_reset_n assignment, which is an e_assign
  assign rtc_rst_n_s1_reset_n = reset_n;

  assign rtc_rst_n_s1_chipselect = cpu_data_master_granted_rtc_rst_n_s1;
  //rtc_rst_n_s1_firsttransfer first transaction, which is an e_assign
  assign rtc_rst_n_s1_firsttransfer = rtc_rst_n_s1_begins_xfer ? rtc_rst_n_s1_unreg_firsttransfer : rtc_rst_n_s1_reg_firsttransfer;

  //rtc_rst_n_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign rtc_rst_n_s1_unreg_firsttransfer = ~(rtc_rst_n_s1_slavearbiterlockenable & rtc_rst_n_s1_any_continuerequest);

  //rtc_rst_n_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_rst_n_s1_reg_firsttransfer <= 1'b1;
      else if (rtc_rst_n_s1_begins_xfer)
          rtc_rst_n_s1_reg_firsttransfer <= rtc_rst_n_s1_unreg_firsttransfer;
    end


  //rtc_rst_n_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign rtc_rst_n_s1_beginbursttransfer_internal = rtc_rst_n_s1_begins_xfer;

  //~rtc_rst_n_s1_write_n assignment, which is an e_mux
  assign rtc_rst_n_s1_write_n = ~(cpu_data_master_granted_rtc_rst_n_s1 & cpu_data_master_write);

  assign shifted_address_to_rtc_rst_n_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //rtc_rst_n_s1_address mux, which is an e_mux
  assign rtc_rst_n_s1_address = shifted_address_to_rtc_rst_n_s1_from_cpu_data_master >> 2;

  //d1_rtc_rst_n_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_rtc_rst_n_s1_end_xfer <= 1;
      else 
        d1_rtc_rst_n_s1_end_xfer <= rtc_rst_n_s1_end_xfer;
    end


  //rtc_rst_n_s1_waits_for_read in a cycle, which is an e_mux
  assign rtc_rst_n_s1_waits_for_read = rtc_rst_n_s1_in_a_read_cycle & rtc_rst_n_s1_begins_xfer;

  //rtc_rst_n_s1_in_a_read_cycle assignment, which is an e_assign
  assign rtc_rst_n_s1_in_a_read_cycle = cpu_data_master_granted_rtc_rst_n_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = rtc_rst_n_s1_in_a_read_cycle;

  //rtc_rst_n_s1_waits_for_write in a cycle, which is an e_mux
  assign rtc_rst_n_s1_waits_for_write = rtc_rst_n_s1_in_a_write_cycle & 0;

  //rtc_rst_n_s1_in_a_write_cycle assignment, which is an e_assign
  assign rtc_rst_n_s1_in_a_write_cycle = cpu_data_master_granted_rtc_rst_n_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = rtc_rst_n_s1_in_a_write_cycle;

  assign wait_for_rtc_rst_n_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //rtc_rst_n/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rtc_sclk_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_read,
                                 cpu_data_master_waitrequest,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 reset_n,
                                 rtc_sclk_s1_readdata,

                                // outputs:
                                 cpu_data_master_granted_rtc_sclk_s1,
                                 cpu_data_master_qualified_request_rtc_sclk_s1,
                                 cpu_data_master_read_data_valid_rtc_sclk_s1,
                                 cpu_data_master_requests_rtc_sclk_s1,
                                 d1_rtc_sclk_s1_end_xfer,
                                 rtc_sclk_s1_address,
                                 rtc_sclk_s1_chipselect,
                                 rtc_sclk_s1_readdata_from_sa,
                                 rtc_sclk_s1_reset_n,
                                 rtc_sclk_s1_write_n,
                                 rtc_sclk_s1_writedata
                              )
;

  output           cpu_data_master_granted_rtc_sclk_s1;
  output           cpu_data_master_qualified_request_rtc_sclk_s1;
  output           cpu_data_master_read_data_valid_rtc_sclk_s1;
  output           cpu_data_master_requests_rtc_sclk_s1;
  output           d1_rtc_sclk_s1_end_xfer;
  output  [  1: 0] rtc_sclk_s1_address;
  output           rtc_sclk_s1_chipselect;
  output  [ 31: 0] rtc_sclk_s1_readdata_from_sa;
  output           rtc_sclk_s1_reset_n;
  output           rtc_sclk_s1_write_n;
  output  [ 31: 0] rtc_sclk_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] rtc_sclk_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_rtc_sclk_s1;
  wire             cpu_data_master_qualified_request_rtc_sclk_s1;
  wire             cpu_data_master_read_data_valid_rtc_sclk_s1;
  wire             cpu_data_master_requests_rtc_sclk_s1;
  wire             cpu_data_master_saved_grant_rtc_sclk_s1;
  reg              d1_reasons_to_wait;
  reg              d1_rtc_sclk_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_rtc_sclk_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] rtc_sclk_s1_address;
  wire             rtc_sclk_s1_allgrants;
  wire             rtc_sclk_s1_allow_new_arb_cycle;
  wire             rtc_sclk_s1_any_bursting_master_saved_grant;
  wire             rtc_sclk_s1_any_continuerequest;
  wire             rtc_sclk_s1_arb_counter_enable;
  reg     [  1: 0] rtc_sclk_s1_arb_share_counter;
  wire    [  1: 0] rtc_sclk_s1_arb_share_counter_next_value;
  wire    [  1: 0] rtc_sclk_s1_arb_share_set_values;
  wire             rtc_sclk_s1_beginbursttransfer_internal;
  wire             rtc_sclk_s1_begins_xfer;
  wire             rtc_sclk_s1_chipselect;
  wire             rtc_sclk_s1_end_xfer;
  wire             rtc_sclk_s1_firsttransfer;
  wire             rtc_sclk_s1_grant_vector;
  wire             rtc_sclk_s1_in_a_read_cycle;
  wire             rtc_sclk_s1_in_a_write_cycle;
  wire             rtc_sclk_s1_master_qreq_vector;
  wire             rtc_sclk_s1_non_bursting_master_requests;
  wire    [ 31: 0] rtc_sclk_s1_readdata_from_sa;
  reg              rtc_sclk_s1_reg_firsttransfer;
  wire             rtc_sclk_s1_reset_n;
  reg              rtc_sclk_s1_slavearbiterlockenable;
  wire             rtc_sclk_s1_slavearbiterlockenable2;
  wire             rtc_sclk_s1_unreg_firsttransfer;
  wire             rtc_sclk_s1_waits_for_read;
  wire             rtc_sclk_s1_waits_for_write;
  wire             rtc_sclk_s1_write_n;
  wire    [ 31: 0] rtc_sclk_s1_writedata;
  wire    [ 26: 0] shifted_address_to_rtc_sclk_s1_from_cpu_data_master;
  wire             wait_for_rtc_sclk_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~rtc_sclk_s1_end_xfer;
    end


  assign rtc_sclk_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_rtc_sclk_s1));
  //assign rtc_sclk_s1_readdata_from_sa = rtc_sclk_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign rtc_sclk_s1_readdata_from_sa = rtc_sclk_s1_readdata;

  assign cpu_data_master_requests_rtc_sclk_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18a0) & (cpu_data_master_read | cpu_data_master_write);
  //rtc_sclk_s1_arb_share_counter set values, which is an e_mux
  assign rtc_sclk_s1_arb_share_set_values = 1;

  //rtc_sclk_s1_non_bursting_master_requests mux, which is an e_mux
  assign rtc_sclk_s1_non_bursting_master_requests = cpu_data_master_requests_rtc_sclk_s1;

  //rtc_sclk_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign rtc_sclk_s1_any_bursting_master_saved_grant = 0;

  //rtc_sclk_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign rtc_sclk_s1_arb_share_counter_next_value = rtc_sclk_s1_firsttransfer ? (rtc_sclk_s1_arb_share_set_values - 1) : |rtc_sclk_s1_arb_share_counter ? (rtc_sclk_s1_arb_share_counter - 1) : 0;

  //rtc_sclk_s1_allgrants all slave grants, which is an e_mux
  assign rtc_sclk_s1_allgrants = |rtc_sclk_s1_grant_vector;

  //rtc_sclk_s1_end_xfer assignment, which is an e_assign
  assign rtc_sclk_s1_end_xfer = ~(rtc_sclk_s1_waits_for_read | rtc_sclk_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_rtc_sclk_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_rtc_sclk_s1 = rtc_sclk_s1_end_xfer & (~rtc_sclk_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //rtc_sclk_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign rtc_sclk_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_rtc_sclk_s1 & rtc_sclk_s1_allgrants) | (end_xfer_arb_share_counter_term_rtc_sclk_s1 & ~rtc_sclk_s1_non_bursting_master_requests);

  //rtc_sclk_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_sclk_s1_arb_share_counter <= 0;
      else if (rtc_sclk_s1_arb_counter_enable)
          rtc_sclk_s1_arb_share_counter <= rtc_sclk_s1_arb_share_counter_next_value;
    end


  //rtc_sclk_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_sclk_s1_slavearbiterlockenable <= 0;
      else if ((|rtc_sclk_s1_master_qreq_vector & end_xfer_arb_share_counter_term_rtc_sclk_s1) | (end_xfer_arb_share_counter_term_rtc_sclk_s1 & ~rtc_sclk_s1_non_bursting_master_requests))
          rtc_sclk_s1_slavearbiterlockenable <= |rtc_sclk_s1_arb_share_counter_next_value;
    end


  //cpu/data_master rtc_sclk/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = rtc_sclk_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //rtc_sclk_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign rtc_sclk_s1_slavearbiterlockenable2 = |rtc_sclk_s1_arb_share_counter_next_value;

  //cpu/data_master rtc_sclk/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = rtc_sclk_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //rtc_sclk_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign rtc_sclk_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_rtc_sclk_s1 = cpu_data_master_requests_rtc_sclk_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //rtc_sclk_s1_writedata mux, which is an e_mux
  assign rtc_sclk_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_rtc_sclk_s1 = cpu_data_master_qualified_request_rtc_sclk_s1;

  //cpu/data_master saved-grant rtc_sclk/s1, which is an e_assign
  assign cpu_data_master_saved_grant_rtc_sclk_s1 = cpu_data_master_requests_rtc_sclk_s1;

  //allow new arb cycle for rtc_sclk/s1, which is an e_assign
  assign rtc_sclk_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign rtc_sclk_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign rtc_sclk_s1_master_qreq_vector = 1;

  //rtc_sclk_s1_reset_n assignment, which is an e_assign
  assign rtc_sclk_s1_reset_n = reset_n;

  assign rtc_sclk_s1_chipselect = cpu_data_master_granted_rtc_sclk_s1;
  //rtc_sclk_s1_firsttransfer first transaction, which is an e_assign
  assign rtc_sclk_s1_firsttransfer = rtc_sclk_s1_begins_xfer ? rtc_sclk_s1_unreg_firsttransfer : rtc_sclk_s1_reg_firsttransfer;

  //rtc_sclk_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign rtc_sclk_s1_unreg_firsttransfer = ~(rtc_sclk_s1_slavearbiterlockenable & rtc_sclk_s1_any_continuerequest);

  //rtc_sclk_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rtc_sclk_s1_reg_firsttransfer <= 1'b1;
      else if (rtc_sclk_s1_begins_xfer)
          rtc_sclk_s1_reg_firsttransfer <= rtc_sclk_s1_unreg_firsttransfer;
    end


  //rtc_sclk_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign rtc_sclk_s1_beginbursttransfer_internal = rtc_sclk_s1_begins_xfer;

  //~rtc_sclk_s1_write_n assignment, which is an e_mux
  assign rtc_sclk_s1_write_n = ~(cpu_data_master_granted_rtc_sclk_s1 & cpu_data_master_write);

  assign shifted_address_to_rtc_sclk_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //rtc_sclk_s1_address mux, which is an e_mux
  assign rtc_sclk_s1_address = shifted_address_to_rtc_sclk_s1_from_cpu_data_master >> 2;

  //d1_rtc_sclk_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_rtc_sclk_s1_end_xfer <= 1;
      else 
        d1_rtc_sclk_s1_end_xfer <= rtc_sclk_s1_end_xfer;
    end


  //rtc_sclk_s1_waits_for_read in a cycle, which is an e_mux
  assign rtc_sclk_s1_waits_for_read = rtc_sclk_s1_in_a_read_cycle & rtc_sclk_s1_begins_xfer;

  //rtc_sclk_s1_in_a_read_cycle assignment, which is an e_assign
  assign rtc_sclk_s1_in_a_read_cycle = cpu_data_master_granted_rtc_sclk_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = rtc_sclk_s1_in_a_read_cycle;

  //rtc_sclk_s1_waits_for_write in a cycle, which is an e_mux
  assign rtc_sclk_s1_waits_for_write = rtc_sclk_s1_in_a_write_cycle & 0;

  //rtc_sclk_s1_in_a_write_cycle assignment, which is an e_assign
  assign rtc_sclk_s1_in_a_write_cycle = cpu_data_master_granted_rtc_sclk_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = rtc_sclk_s1_in_a_write_cycle;

  assign wait_for_rtc_sclk_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //rtc_sclk/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module scl_s1_arbitrator (
                           // inputs:
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_read,
                            cpu_data_master_waitrequest,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            reset_n,
                            scl_s1_readdata,

                           // outputs:
                            cpu_data_master_granted_scl_s1,
                            cpu_data_master_qualified_request_scl_s1,
                            cpu_data_master_read_data_valid_scl_s1,
                            cpu_data_master_requests_scl_s1,
                            d1_scl_s1_end_xfer,
                            scl_s1_address,
                            scl_s1_chipselect,
                            scl_s1_readdata_from_sa,
                            scl_s1_reset_n,
                            scl_s1_write_n,
                            scl_s1_writedata
                         )
;

  output           cpu_data_master_granted_scl_s1;
  output           cpu_data_master_qualified_request_scl_s1;
  output           cpu_data_master_read_data_valid_scl_s1;
  output           cpu_data_master_requests_scl_s1;
  output           d1_scl_s1_end_xfer;
  output  [  1: 0] scl_s1_address;
  output           scl_s1_chipselect;
  output  [ 31: 0] scl_s1_readdata_from_sa;
  output           scl_s1_reset_n;
  output           scl_s1_write_n;
  output  [ 31: 0] scl_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] scl_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_scl_s1;
  wire             cpu_data_master_qualified_request_scl_s1;
  wire             cpu_data_master_read_data_valid_scl_s1;
  wire             cpu_data_master_requests_scl_s1;
  wire             cpu_data_master_saved_grant_scl_s1;
  reg              d1_reasons_to_wait;
  reg              d1_scl_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_scl_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] scl_s1_address;
  wire             scl_s1_allgrants;
  wire             scl_s1_allow_new_arb_cycle;
  wire             scl_s1_any_bursting_master_saved_grant;
  wire             scl_s1_any_continuerequest;
  wire             scl_s1_arb_counter_enable;
  reg     [  1: 0] scl_s1_arb_share_counter;
  wire    [  1: 0] scl_s1_arb_share_counter_next_value;
  wire    [  1: 0] scl_s1_arb_share_set_values;
  wire             scl_s1_beginbursttransfer_internal;
  wire             scl_s1_begins_xfer;
  wire             scl_s1_chipselect;
  wire             scl_s1_end_xfer;
  wire             scl_s1_firsttransfer;
  wire             scl_s1_grant_vector;
  wire             scl_s1_in_a_read_cycle;
  wire             scl_s1_in_a_write_cycle;
  wire             scl_s1_master_qreq_vector;
  wire             scl_s1_non_bursting_master_requests;
  wire    [ 31: 0] scl_s1_readdata_from_sa;
  reg              scl_s1_reg_firsttransfer;
  wire             scl_s1_reset_n;
  reg              scl_s1_slavearbiterlockenable;
  wire             scl_s1_slavearbiterlockenable2;
  wire             scl_s1_unreg_firsttransfer;
  wire             scl_s1_waits_for_read;
  wire             scl_s1_waits_for_write;
  wire             scl_s1_write_n;
  wire    [ 31: 0] scl_s1_writedata;
  wire    [ 26: 0] shifted_address_to_scl_s1_from_cpu_data_master;
  wire             wait_for_scl_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~scl_s1_end_xfer;
    end


  assign scl_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_scl_s1));
  //assign scl_s1_readdata_from_sa = scl_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign scl_s1_readdata_from_sa = scl_s1_readdata;

  assign cpu_data_master_requests_scl_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1890) & (cpu_data_master_read | cpu_data_master_write);
  //scl_s1_arb_share_counter set values, which is an e_mux
  assign scl_s1_arb_share_set_values = 1;

  //scl_s1_non_bursting_master_requests mux, which is an e_mux
  assign scl_s1_non_bursting_master_requests = cpu_data_master_requests_scl_s1;

  //scl_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign scl_s1_any_bursting_master_saved_grant = 0;

  //scl_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign scl_s1_arb_share_counter_next_value = scl_s1_firsttransfer ? (scl_s1_arb_share_set_values - 1) : |scl_s1_arb_share_counter ? (scl_s1_arb_share_counter - 1) : 0;

  //scl_s1_allgrants all slave grants, which is an e_mux
  assign scl_s1_allgrants = |scl_s1_grant_vector;

  //scl_s1_end_xfer assignment, which is an e_assign
  assign scl_s1_end_xfer = ~(scl_s1_waits_for_read | scl_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_scl_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_scl_s1 = scl_s1_end_xfer & (~scl_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //scl_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign scl_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_scl_s1 & scl_s1_allgrants) | (end_xfer_arb_share_counter_term_scl_s1 & ~scl_s1_non_bursting_master_requests);

  //scl_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          scl_s1_arb_share_counter <= 0;
      else if (scl_s1_arb_counter_enable)
          scl_s1_arb_share_counter <= scl_s1_arb_share_counter_next_value;
    end


  //scl_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          scl_s1_slavearbiterlockenable <= 0;
      else if ((|scl_s1_master_qreq_vector & end_xfer_arb_share_counter_term_scl_s1) | (end_xfer_arb_share_counter_term_scl_s1 & ~scl_s1_non_bursting_master_requests))
          scl_s1_slavearbiterlockenable <= |scl_s1_arb_share_counter_next_value;
    end


  //cpu/data_master scl/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = scl_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //scl_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign scl_s1_slavearbiterlockenable2 = |scl_s1_arb_share_counter_next_value;

  //cpu/data_master scl/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = scl_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //scl_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign scl_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_scl_s1 = cpu_data_master_requests_scl_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //scl_s1_writedata mux, which is an e_mux
  assign scl_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_scl_s1 = cpu_data_master_qualified_request_scl_s1;

  //cpu/data_master saved-grant scl/s1, which is an e_assign
  assign cpu_data_master_saved_grant_scl_s1 = cpu_data_master_requests_scl_s1;

  //allow new arb cycle for scl/s1, which is an e_assign
  assign scl_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign scl_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign scl_s1_master_qreq_vector = 1;

  //scl_s1_reset_n assignment, which is an e_assign
  assign scl_s1_reset_n = reset_n;

  assign scl_s1_chipselect = cpu_data_master_granted_scl_s1;
  //scl_s1_firsttransfer first transaction, which is an e_assign
  assign scl_s1_firsttransfer = scl_s1_begins_xfer ? scl_s1_unreg_firsttransfer : scl_s1_reg_firsttransfer;

  //scl_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign scl_s1_unreg_firsttransfer = ~(scl_s1_slavearbiterlockenable & scl_s1_any_continuerequest);

  //scl_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          scl_s1_reg_firsttransfer <= 1'b1;
      else if (scl_s1_begins_xfer)
          scl_s1_reg_firsttransfer <= scl_s1_unreg_firsttransfer;
    end


  //scl_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign scl_s1_beginbursttransfer_internal = scl_s1_begins_xfer;

  //~scl_s1_write_n assignment, which is an e_mux
  assign scl_s1_write_n = ~(cpu_data_master_granted_scl_s1 & cpu_data_master_write);

  assign shifted_address_to_scl_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //scl_s1_address mux, which is an e_mux
  assign scl_s1_address = shifted_address_to_scl_s1_from_cpu_data_master >> 2;

  //d1_scl_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_scl_s1_end_xfer <= 1;
      else 
        d1_scl_s1_end_xfer <= scl_s1_end_xfer;
    end


  //scl_s1_waits_for_read in a cycle, which is an e_mux
  assign scl_s1_waits_for_read = scl_s1_in_a_read_cycle & scl_s1_begins_xfer;

  //scl_s1_in_a_read_cycle assignment, which is an e_assign
  assign scl_s1_in_a_read_cycle = cpu_data_master_granted_scl_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = scl_s1_in_a_read_cycle;

  //scl_s1_waits_for_write in a cycle, which is an e_mux
  assign scl_s1_waits_for_write = scl_s1_in_a_write_cycle & 0;

  //scl_s1_in_a_write_cycle assignment, which is an e_assign
  assign scl_s1_in_a_write_cycle = cpu_data_master_granted_scl_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = scl_s1_in_a_write_cycle;

  assign wait_for_scl_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //scl/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sda_s1_arbitrator (
                           // inputs:
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_read,
                            cpu_data_master_waitrequest,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            reset_n,
                            sda_s1_readdata,

                           // outputs:
                            cpu_data_master_granted_sda_s1,
                            cpu_data_master_qualified_request_sda_s1,
                            cpu_data_master_read_data_valid_sda_s1,
                            cpu_data_master_requests_sda_s1,
                            d1_sda_s1_end_xfer,
                            sda_s1_address,
                            sda_s1_chipselect,
                            sda_s1_readdata_from_sa,
                            sda_s1_reset_n,
                            sda_s1_write_n,
                            sda_s1_writedata
                         )
;

  output           cpu_data_master_granted_sda_s1;
  output           cpu_data_master_qualified_request_sda_s1;
  output           cpu_data_master_read_data_valid_sda_s1;
  output           cpu_data_master_requests_sda_s1;
  output           d1_sda_s1_end_xfer;
  output  [  1: 0] sda_s1_address;
  output           sda_s1_chipselect;
  output  [ 31: 0] sda_s1_readdata_from_sa;
  output           sda_s1_reset_n;
  output           sda_s1_write_n;
  output  [ 31: 0] sda_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] sda_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sda_s1;
  wire             cpu_data_master_qualified_request_sda_s1;
  wire             cpu_data_master_read_data_valid_sda_s1;
  wire             cpu_data_master_requests_sda_s1;
  wire             cpu_data_master_saved_grant_sda_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sda_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sda_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sda_s1_address;
  wire             sda_s1_allgrants;
  wire             sda_s1_allow_new_arb_cycle;
  wire             sda_s1_any_bursting_master_saved_grant;
  wire             sda_s1_any_continuerequest;
  wire             sda_s1_arb_counter_enable;
  reg     [  1: 0] sda_s1_arb_share_counter;
  wire    [  1: 0] sda_s1_arb_share_counter_next_value;
  wire    [  1: 0] sda_s1_arb_share_set_values;
  wire             sda_s1_beginbursttransfer_internal;
  wire             sda_s1_begins_xfer;
  wire             sda_s1_chipselect;
  wire             sda_s1_end_xfer;
  wire             sda_s1_firsttransfer;
  wire             sda_s1_grant_vector;
  wire             sda_s1_in_a_read_cycle;
  wire             sda_s1_in_a_write_cycle;
  wire             sda_s1_master_qreq_vector;
  wire             sda_s1_non_bursting_master_requests;
  wire    [ 31: 0] sda_s1_readdata_from_sa;
  reg              sda_s1_reg_firsttransfer;
  wire             sda_s1_reset_n;
  reg              sda_s1_slavearbiterlockenable;
  wire             sda_s1_slavearbiterlockenable2;
  wire             sda_s1_unreg_firsttransfer;
  wire             sda_s1_waits_for_read;
  wire             sda_s1_waits_for_write;
  wire             sda_s1_write_n;
  wire    [ 31: 0] sda_s1_writedata;
  wire    [ 26: 0] shifted_address_to_sda_s1_from_cpu_data_master;
  wire             wait_for_sda_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sda_s1_end_xfer;
    end


  assign sda_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sda_s1));
  //assign sda_s1_readdata_from_sa = sda_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sda_s1_readdata_from_sa = sda_s1_readdata;

  assign cpu_data_master_requests_sda_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1880) & (cpu_data_master_read | cpu_data_master_write);
  //sda_s1_arb_share_counter set values, which is an e_mux
  assign sda_s1_arb_share_set_values = 1;

  //sda_s1_non_bursting_master_requests mux, which is an e_mux
  assign sda_s1_non_bursting_master_requests = cpu_data_master_requests_sda_s1;

  //sda_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sda_s1_any_bursting_master_saved_grant = 0;

  //sda_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sda_s1_arb_share_counter_next_value = sda_s1_firsttransfer ? (sda_s1_arb_share_set_values - 1) : |sda_s1_arb_share_counter ? (sda_s1_arb_share_counter - 1) : 0;

  //sda_s1_allgrants all slave grants, which is an e_mux
  assign sda_s1_allgrants = |sda_s1_grant_vector;

  //sda_s1_end_xfer assignment, which is an e_assign
  assign sda_s1_end_xfer = ~(sda_s1_waits_for_read | sda_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sda_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sda_s1 = sda_s1_end_xfer & (~sda_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sda_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sda_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sda_s1 & sda_s1_allgrants) | (end_xfer_arb_share_counter_term_sda_s1 & ~sda_s1_non_bursting_master_requests);

  //sda_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sda_s1_arb_share_counter <= 0;
      else if (sda_s1_arb_counter_enable)
          sda_s1_arb_share_counter <= sda_s1_arb_share_counter_next_value;
    end


  //sda_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sda_s1_slavearbiterlockenable <= 0;
      else if ((|sda_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sda_s1) | (end_xfer_arb_share_counter_term_sda_s1 & ~sda_s1_non_bursting_master_requests))
          sda_s1_slavearbiterlockenable <= |sda_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sda/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sda_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sda_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sda_s1_slavearbiterlockenable2 = |sda_s1_arb_share_counter_next_value;

  //cpu/data_master sda/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sda_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sda_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sda_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sda_s1 = cpu_data_master_requests_sda_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //sda_s1_writedata mux, which is an e_mux
  assign sda_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sda_s1 = cpu_data_master_qualified_request_sda_s1;

  //cpu/data_master saved-grant sda/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sda_s1 = cpu_data_master_requests_sda_s1;

  //allow new arb cycle for sda/s1, which is an e_assign
  assign sda_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sda_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sda_s1_master_qreq_vector = 1;

  //sda_s1_reset_n assignment, which is an e_assign
  assign sda_s1_reset_n = reset_n;

  assign sda_s1_chipselect = cpu_data_master_granted_sda_s1;
  //sda_s1_firsttransfer first transaction, which is an e_assign
  assign sda_s1_firsttransfer = sda_s1_begins_xfer ? sda_s1_unreg_firsttransfer : sda_s1_reg_firsttransfer;

  //sda_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sda_s1_unreg_firsttransfer = ~(sda_s1_slavearbiterlockenable & sda_s1_any_continuerequest);

  //sda_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sda_s1_reg_firsttransfer <= 1'b1;
      else if (sda_s1_begins_xfer)
          sda_s1_reg_firsttransfer <= sda_s1_unreg_firsttransfer;
    end


  //sda_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sda_s1_beginbursttransfer_internal = sda_s1_begins_xfer;

  //~sda_s1_write_n assignment, which is an e_mux
  assign sda_s1_write_n = ~(cpu_data_master_granted_sda_s1 & cpu_data_master_write);

  assign shifted_address_to_sda_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sda_s1_address mux, which is an e_mux
  assign sda_s1_address = shifted_address_to_sda_s1_from_cpu_data_master >> 2;

  //d1_sda_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sda_s1_end_xfer <= 1;
      else 
        d1_sda_s1_end_xfer <= sda_s1_end_xfer;
    end


  //sda_s1_waits_for_read in a cycle, which is an e_mux
  assign sda_s1_waits_for_read = sda_s1_in_a_read_cycle & sda_s1_begins_xfer;

  //sda_s1_in_a_read_cycle assignment, which is an e_assign
  assign sda_s1_in_a_read_cycle = cpu_data_master_granted_sda_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sda_s1_in_a_read_cycle;

  //sda_s1_waits_for_write in a cycle, which is an e_mux
  assign sda_s1_waits_for_write = sda_s1_in_a_write_cycle & 0;

  //sda_s1_in_a_write_cycle assignment, which is an e_assign
  assign sda_s1_in_a_write_cycle = cpu_data_master_granted_sda_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sda_s1_in_a_write_cycle;

  assign wait_for_sda_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sda/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_s1_module (
                                                         // inputs:
                                                          clear_fifo,
                                                          clk,
                                                          data_in,
                                                          read,
                                                          reset_n,
                                                          sync_reset,
                                                          write,

                                                         // outputs:
                                                          data_out,
                                                          empty,
                                                          fifo_contains_ones_n,
                                                          full
                                                       )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module (
                                                                // inputs:
                                                                 clear_fifo,
                                                                 clk,
                                                                 data_in,
                                                                 read,
                                                                 reset_n,
                                                                 sync_reset,
                                                                 write,

                                                                // outputs:
                                                                 data_out,
                                                                 empty,
                                                                 fifo_contains_ones_n,
                                                                 full
                                                              )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_byteenable,
                              cpu_data_master_dbs_address,
                              cpu_data_master_dbs_write_16,
                              cpu_data_master_no_byte_enables_and_last_term,
                              cpu_data_master_read,
                              cpu_data_master_waitrequest,
                              cpu_data_master_write,
                              cpu_instruction_master_address_to_slave,
                              cpu_instruction_master_dbs_address,
                              cpu_instruction_master_latency_counter,
                              cpu_instruction_master_read,
                              reset_n,
                              sdram_s1_readdata,
                              sdram_s1_readdatavalid,
                              sdram_s1_waitrequest,

                             // outputs:
                              cpu_data_master_byteenable_sdram_s1,
                              cpu_data_master_granted_sdram_s1,
                              cpu_data_master_qualified_request_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1_shift_register,
                              cpu_data_master_requests_sdram_s1,
                              cpu_instruction_master_granted_sdram_s1,
                              cpu_instruction_master_qualified_request_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                              cpu_instruction_master_requests_sdram_s1,
                              d1_sdram_s1_end_xfer,
                              sdram_s1_address,
                              sdram_s1_byteenable_n,
                              sdram_s1_chipselect,
                              sdram_s1_read_n,
                              sdram_s1_readdata_from_sa,
                              sdram_s1_reset_n,
                              sdram_s1_waitrequest_from_sa,
                              sdram_s1_write_n,
                              sdram_s1_writedata
                           )
;

  output  [  1: 0] cpu_data_master_byteenable_sdram_s1;
  output           cpu_data_master_granted_sdram_s1;
  output           cpu_data_master_qualified_request_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_data_master_requests_sdram_s1;
  output           cpu_instruction_master_granted_sdram_s1;
  output           cpu_instruction_master_qualified_request_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_s1;
  output           d1_sdram_s1_end_xfer;
  output  [ 23: 0] sdram_s1_address;
  output  [  1: 0] sdram_s1_byteenable_n;
  output           sdram_s1_chipselect;
  output           sdram_s1_read_n;
  output  [ 15: 0] sdram_s1_readdata_from_sa;
  output           sdram_s1_reset_n;
  output           sdram_s1_waitrequest_from_sa;
  output           sdram_s1_write_n;
  output  [ 15: 0] sdram_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input            cpu_data_master_no_byte_enables_and_last_term;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata;
  input            sdram_s1_readdatavalid;
  input            sdram_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_s1;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_saved_grant_sdram_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_saved_grant_sdram_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
  wire    [ 23: 0] sdram_s1_address;
  wire             sdram_s1_allgrants;
  wire             sdram_s1_allow_new_arb_cycle;
  wire             sdram_s1_any_bursting_master_saved_grant;
  wire             sdram_s1_any_continuerequest;
  reg     [  1: 0] sdram_s1_arb_addend;
  wire             sdram_s1_arb_counter_enable;
  reg     [  1: 0] sdram_s1_arb_share_counter;
  wire    [  1: 0] sdram_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_s1_arb_share_set_values;
  wire    [  1: 0] sdram_s1_arb_winner;
  wire             sdram_s1_arbitration_holdoff_internal;
  wire             sdram_s1_beginbursttransfer_internal;
  wire             sdram_s1_begins_xfer;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire    [  3: 0] sdram_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_s1_chosen_master_rot_left;
  wire             sdram_s1_end_xfer;
  wire             sdram_s1_firsttransfer;
  wire    [  1: 0] sdram_s1_grant_vector;
  wire             sdram_s1_in_a_read_cycle;
  wire             sdram_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_s1_master_qreq_vector;
  wire             sdram_s1_move_on_to_next_transaction;
  wire             sdram_s1_non_bursting_master_requests;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid_from_sa;
  reg              sdram_s1_reg_firsttransfer;
  wire             sdram_s1_reset_n;
  reg     [  1: 0] sdram_s1_saved_chosen_master_vector;
  reg              sdram_s1_slavearbiterlockenable;
  wire             sdram_s1_slavearbiterlockenable2;
  wire             sdram_s1_unreg_firsttransfer;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_waits_for_read;
  wire             sdram_s1_waits_for_write;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_s1_end_xfer;
    end


  assign sdram_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_s1 | cpu_instruction_master_qualified_request_sdram_s1));
  //assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid;

  //assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdata_from_sa = sdram_s1_readdata;

  assign cpu_data_master_requests_sdram_s1 = ({cpu_data_master_address_to_slave[26 : 25] , 25'b0} == 27'h4000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest;

  //sdram_s1_arb_share_counter set values, which is an e_mux
  assign sdram_s1_arb_share_set_values = (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    1;

  //sdram_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1 |
    cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_s1_any_bursting_master_saved_grant = 0;

  //sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_s1_arb_share_counter_next_value = sdram_s1_firsttransfer ? (sdram_s1_arb_share_set_values - 1) : |sdram_s1_arb_share_counter ? (sdram_s1_arb_share_counter - 1) : 0;

  //sdram_s1_allgrants all slave grants, which is an e_mux
  assign sdram_s1_allgrants = (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector);

  //sdram_s1_end_xfer assignment, which is an e_assign
  assign sdram_s1_end_xfer = ~(sdram_s1_waits_for_read | sdram_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_s1 = sdram_s1_end_xfer & (~sdram_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_s1 & sdram_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests);

  //sdram_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_share_counter <= 0;
      else if (sdram_s1_arb_counter_enable)
          sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
    end


  //sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_s1) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests))
          sdram_s1_slavearbiterlockenable <= |sdram_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_s1_slavearbiterlockenable2 = |sdram_s1_arb_share_counter_next_value;

  //cpu/data_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= cpu_instruction_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_s1 & cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_s1 = cpu_data_master_requests_sdram_s1 & ~((cpu_data_master_read & (~cpu_data_master_waitrequest | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))) | ((~cpu_data_master_waitrequest | cpu_data_master_no_byte_enables_and_last_term | !cpu_data_master_byteenable_sdram_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_s1_move_on_to_next_transaction = sdram_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_s1_module rdv_fifo_for_cpu_data_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_s1;

  //sdram_s1_writedata mux, which is an e_mux
  assign sdram_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_s1 = (({cpu_instruction_master_address_to_slave[26 : 25] , 25'b0} == 27'h4000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_sdram_s1 <= cpu_data_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_s1 & cpu_data_master_requests_sdram_s1;

  assign cpu_instruction_master_qualified_request_sdram_s1 = cpu_instruction_master_requests_sdram_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_s1;

  //allow new arb cycle for sdram/s1, which is an e_assign
  assign sdram_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_s1;

  //cpu/instruction_master grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_s1 = sdram_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_s1;

  //cpu/data_master grant sdram/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_s1 = sdram_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[1] && cpu_data_master_requests_sdram_s1;

  //sdram/s1 chosen-master double-vector, which is an e_assign
  assign sdram_s1_chosen_master_double_vector = {sdram_s1_master_qreq_vector, sdram_s1_master_qreq_vector} & ({~sdram_s1_master_qreq_vector, ~sdram_s1_master_qreq_vector} + sdram_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_s1_arb_winner = (sdram_s1_allow_new_arb_cycle & | sdram_s1_grant_vector) ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;

  //saved sdram_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_saved_chosen_master_vector <= 0;
      else if (sdram_s1_allow_new_arb_cycle)
          sdram_s1_saved_chosen_master_vector <= |sdram_s1_grant_vector ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_s1_grant_vector = {(sdram_s1_chosen_master_double_vector[1] | sdram_s1_chosen_master_double_vector[3]),
    (sdram_s1_chosen_master_double_vector[0] | sdram_s1_chosen_master_double_vector[2])};

  //sdram/s1 chosen master rotated left, which is an e_assign
  assign sdram_s1_chosen_master_rot_left = (sdram_s1_arb_winner << 1) ? (sdram_s1_arb_winner << 1) : 1;

  //sdram/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_addend <= 1;
      else if (|sdram_s1_grant_vector)
          sdram_s1_arb_addend <= sdram_s1_end_xfer? sdram_s1_chosen_master_rot_left : sdram_s1_grant_vector;
    end


  //sdram_s1_reset_n assignment, which is an e_assign
  assign sdram_s1_reset_n = reset_n;

  assign sdram_s1_chipselect = cpu_data_master_granted_sdram_s1 | cpu_instruction_master_granted_sdram_s1;
  //sdram_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_firsttransfer = sdram_s1_begins_xfer ? sdram_s1_unreg_firsttransfer : sdram_s1_reg_firsttransfer;

  //sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_unreg_firsttransfer = ~(sdram_s1_slavearbiterlockenable & sdram_s1_any_continuerequest);

  //sdram_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_s1_begins_xfer)
          sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
    end


  //sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_s1_beginbursttransfer_internal = sdram_s1_begins_xfer;

  //sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_s1_arbitration_holdoff_internal = sdram_s1_begins_xfer & sdram_s1_firsttransfer;

  //~sdram_s1_read_n assignment, which is an e_mux
  assign sdram_s1_read_n = ~((cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read));

  //~sdram_s1_write_n assignment, which is an e_mux
  assign sdram_s1_write_n = ~(cpu_data_master_granted_sdram_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_s1_address mux, which is an e_mux
  assign sdram_s1_address = (cpu_data_master_granted_sdram_s1)? (shifted_address_to_sdram_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_s1_end_xfer <= 1;
      else 
        d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
    end


  //sdram_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_s1_waits_for_read = sdram_s1_in_a_read_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_s1_in_a_read_cycle;

  //sdram_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_s1_waits_for_write = sdram_s1_in_a_write_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_write_cycle = cpu_data_master_granted_sdram_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_s1_in_a_write_cycle;

  assign wait_for_sdram_s1_counter = 0;
  //~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_s1_byteenable_n = ~((cpu_data_master_granted_sdram_s1)? cpu_data_master_byteenable_sdram_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_s1_segment_1,
cpu_data_master_byteenable_sdram_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_s1_segment_0 :
    cpu_data_master_byteenable_sdram_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_s1 + cpu_instruction_master_granted_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_s1 + cpu_instruction_master_saved_grant_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sel_s1_arbitrator (
                           // inputs:
                            clk,
                            cpu_data_master_address_to_slave,
                            cpu_data_master_read,
                            cpu_data_master_waitrequest,
                            cpu_data_master_write,
                            cpu_data_master_writedata,
                            reset_n,
                            sel_s1_readdata,

                           // outputs:
                            cpu_data_master_granted_sel_s1,
                            cpu_data_master_qualified_request_sel_s1,
                            cpu_data_master_read_data_valid_sel_s1,
                            cpu_data_master_requests_sel_s1,
                            d1_sel_s1_end_xfer,
                            sel_s1_address,
                            sel_s1_chipselect,
                            sel_s1_readdata_from_sa,
                            sel_s1_reset_n,
                            sel_s1_write_n,
                            sel_s1_writedata
                         )
;

  output           cpu_data_master_granted_sel_s1;
  output           cpu_data_master_qualified_request_sel_s1;
  output           cpu_data_master_read_data_valid_sel_s1;
  output           cpu_data_master_requests_sel_s1;
  output           d1_sel_s1_end_xfer;
  output  [  1: 0] sel_s1_address;
  output           sel_s1_chipselect;
  output  [ 31: 0] sel_s1_readdata_from_sa;
  output           sel_s1_reset_n;
  output           sel_s1_write_n;
  output  [ 31: 0] sel_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] sel_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sel_s1;
  wire             cpu_data_master_qualified_request_sel_s1;
  wire             cpu_data_master_read_data_valid_sel_s1;
  wire             cpu_data_master_requests_sel_s1;
  wire             cpu_data_master_saved_grant_sel_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sel_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sel_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] sel_s1_address;
  wire             sel_s1_allgrants;
  wire             sel_s1_allow_new_arb_cycle;
  wire             sel_s1_any_bursting_master_saved_grant;
  wire             sel_s1_any_continuerequest;
  wire             sel_s1_arb_counter_enable;
  reg     [  1: 0] sel_s1_arb_share_counter;
  wire    [  1: 0] sel_s1_arb_share_counter_next_value;
  wire    [  1: 0] sel_s1_arb_share_set_values;
  wire             sel_s1_beginbursttransfer_internal;
  wire             sel_s1_begins_xfer;
  wire             sel_s1_chipselect;
  wire             sel_s1_end_xfer;
  wire             sel_s1_firsttransfer;
  wire             sel_s1_grant_vector;
  wire             sel_s1_in_a_read_cycle;
  wire             sel_s1_in_a_write_cycle;
  wire             sel_s1_master_qreq_vector;
  wire             sel_s1_non_bursting_master_requests;
  wire    [ 31: 0] sel_s1_readdata_from_sa;
  reg              sel_s1_reg_firsttransfer;
  wire             sel_s1_reset_n;
  reg              sel_s1_slavearbiterlockenable;
  wire             sel_s1_slavearbiterlockenable2;
  wire             sel_s1_unreg_firsttransfer;
  wire             sel_s1_waits_for_read;
  wire             sel_s1_waits_for_write;
  wire             sel_s1_write_n;
  wire    [ 31: 0] sel_s1_writedata;
  wire    [ 26: 0] shifted_address_to_sel_s1_from_cpu_data_master;
  wire             wait_for_sel_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sel_s1_end_xfer;
    end


  assign sel_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sel_s1));
  //assign sel_s1_readdata_from_sa = sel_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sel_s1_readdata_from_sa = sel_s1_readdata;

  assign cpu_data_master_requests_sel_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18f0) & (cpu_data_master_read | cpu_data_master_write);
  //sel_s1_arb_share_counter set values, which is an e_mux
  assign sel_s1_arb_share_set_values = 1;

  //sel_s1_non_bursting_master_requests mux, which is an e_mux
  assign sel_s1_non_bursting_master_requests = cpu_data_master_requests_sel_s1;

  //sel_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sel_s1_any_bursting_master_saved_grant = 0;

  //sel_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sel_s1_arb_share_counter_next_value = sel_s1_firsttransfer ? (sel_s1_arb_share_set_values - 1) : |sel_s1_arb_share_counter ? (sel_s1_arb_share_counter - 1) : 0;

  //sel_s1_allgrants all slave grants, which is an e_mux
  assign sel_s1_allgrants = |sel_s1_grant_vector;

  //sel_s1_end_xfer assignment, which is an e_assign
  assign sel_s1_end_xfer = ~(sel_s1_waits_for_read | sel_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sel_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sel_s1 = sel_s1_end_xfer & (~sel_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sel_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sel_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sel_s1 & sel_s1_allgrants) | (end_xfer_arb_share_counter_term_sel_s1 & ~sel_s1_non_bursting_master_requests);

  //sel_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sel_s1_arb_share_counter <= 0;
      else if (sel_s1_arb_counter_enable)
          sel_s1_arb_share_counter <= sel_s1_arb_share_counter_next_value;
    end


  //sel_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sel_s1_slavearbiterlockenable <= 0;
      else if ((|sel_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sel_s1) | (end_xfer_arb_share_counter_term_sel_s1 & ~sel_s1_non_bursting_master_requests))
          sel_s1_slavearbiterlockenable <= |sel_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sel/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sel_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sel_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sel_s1_slavearbiterlockenable2 = |sel_s1_arb_share_counter_next_value;

  //cpu/data_master sel/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sel_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sel_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sel_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sel_s1 = cpu_data_master_requests_sel_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //sel_s1_writedata mux, which is an e_mux
  assign sel_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_sel_s1 = cpu_data_master_qualified_request_sel_s1;

  //cpu/data_master saved-grant sel/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sel_s1 = cpu_data_master_requests_sel_s1;

  //allow new arb cycle for sel/s1, which is an e_assign
  assign sel_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sel_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sel_s1_master_qreq_vector = 1;

  //sel_s1_reset_n assignment, which is an e_assign
  assign sel_s1_reset_n = reset_n;

  assign sel_s1_chipselect = cpu_data_master_granted_sel_s1;
  //sel_s1_firsttransfer first transaction, which is an e_assign
  assign sel_s1_firsttransfer = sel_s1_begins_xfer ? sel_s1_unreg_firsttransfer : sel_s1_reg_firsttransfer;

  //sel_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sel_s1_unreg_firsttransfer = ~(sel_s1_slavearbiterlockenable & sel_s1_any_continuerequest);

  //sel_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sel_s1_reg_firsttransfer <= 1'b1;
      else if (sel_s1_begins_xfer)
          sel_s1_reg_firsttransfer <= sel_s1_unreg_firsttransfer;
    end


  //sel_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sel_s1_beginbursttransfer_internal = sel_s1_begins_xfer;

  //~sel_s1_write_n assignment, which is an e_mux
  assign sel_s1_write_n = ~(cpu_data_master_granted_sel_s1 & cpu_data_master_write);

  assign shifted_address_to_sel_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sel_s1_address mux, which is an e_mux
  assign sel_s1_address = shifted_address_to_sel_s1_from_cpu_data_master >> 2;

  //d1_sel_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sel_s1_end_xfer <= 1;
      else 
        d1_sel_s1_end_xfer <= sel_s1_end_xfer;
    end


  //sel_s1_waits_for_read in a cycle, which is an e_mux
  assign sel_s1_waits_for_read = sel_s1_in_a_read_cycle & sel_s1_begins_xfer;

  //sel_s1_in_a_read_cycle assignment, which is an e_assign
  assign sel_s1_in_a_read_cycle = cpu_data_master_granted_sel_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sel_s1_in_a_read_cycle;

  //sel_s1_waits_for_write in a cycle, which is an e_mux
  assign sel_s1_waits_for_write = sel_s1_in_a_write_cycle & 0;

  //sel_s1_in_a_write_cycle assignment, which is an e_assign
  assign sel_s1_in_a_write_cycle = cpu_data_master_granted_sel_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sel_s1_in_a_write_cycle;

  assign wait_for_sel_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sel/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_data_master_address_to_slave,
                                         cpu_data_master_read,
                                         cpu_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_data_master_granted_sysid_control_slave,
                                         cpu_data_master_qualified_request_sysid_control_slave,
                                         cpu_data_master_read_data_valid_sysid_control_slave,
                                         cpu_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_data_master_granted_sysid_control_slave;
  output           cpu_data_master_qualified_request_sysid_control_slave;
  output           cpu_data_master_read_data_valid_sysid_control_slave;
  output           cpu_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_sysid_control_slave_from_cpu_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_data_master_requests_sysid_control_slave = (({cpu_data_master_address_to_slave[26 : 3] , 3'b0} == 27'h1900) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_data_master_granted_sysid_control_slave = cpu_data_master_qualified_request_sysid_control_slave;

  //cpu/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_read,
                              cpu_data_master_waitrequest,
                              cpu_data_master_write,
                              cpu_data_master_writedata,
                              reset_n,
                              timer_s1_irq,
                              timer_s1_readdata,

                             // outputs:
                              cpu_data_master_granted_timer_s1,
                              cpu_data_master_qualified_request_timer_s1,
                              cpu_data_master_read_data_valid_timer_s1,
                              cpu_data_master_requests_timer_s1,
                              d1_timer_s1_end_xfer,
                              timer_s1_address,
                              timer_s1_chipselect,
                              timer_s1_irq_from_sa,
                              timer_s1_readdata_from_sa,
                              timer_s1_reset_n,
                              timer_s1_write_n,
                              timer_s1_writedata
                           )
;

  output           cpu_data_master_granted_timer_s1;
  output           cpu_data_master_qualified_request_timer_s1;
  output           cpu_data_master_read_data_valid_timer_s1;
  output           cpu_data_master_requests_timer_s1;
  output           d1_timer_s1_end_xfer;
  output  [  2: 0] timer_s1_address;
  output           timer_s1_chipselect;
  output           timer_s1_irq_from_sa;
  output  [ 15: 0] timer_s1_readdata_from_sa;
  output           timer_s1_reset_n;
  output           timer_s1_write_n;
  output  [ 15: 0] timer_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            timer_s1_irq;
  input   [ 15: 0] timer_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_saved_grant_timer_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_timer_s1_from_cpu_data_master;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_allgrants;
  wire             timer_s1_allow_new_arb_cycle;
  wire             timer_s1_any_bursting_master_saved_grant;
  wire             timer_s1_any_continuerequest;
  wire             timer_s1_arb_counter_enable;
  reg     [  1: 0] timer_s1_arb_share_counter;
  wire    [  1: 0] timer_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_s1_arb_share_set_values;
  wire             timer_s1_beginbursttransfer_internal;
  wire             timer_s1_begins_xfer;
  wire             timer_s1_chipselect;
  wire             timer_s1_end_xfer;
  wire             timer_s1_firsttransfer;
  wire             timer_s1_grant_vector;
  wire             timer_s1_in_a_read_cycle;
  wire             timer_s1_in_a_write_cycle;
  wire             timer_s1_irq_from_sa;
  wire             timer_s1_master_qreq_vector;
  wire             timer_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  reg              timer_s1_reg_firsttransfer;
  wire             timer_s1_reset_n;
  reg              timer_s1_slavearbiterlockenable;
  wire             timer_s1_slavearbiterlockenable2;
  wire             timer_s1_unreg_firsttransfer;
  wire             timer_s1_waits_for_read;
  wire             timer_s1_waits_for_write;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire             wait_for_timer_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_s1_end_xfer;
    end


  assign timer_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_timer_s1));
  //assign timer_s1_readdata_from_sa = timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_readdata_from_sa = timer_s1_readdata;

  assign cpu_data_master_requests_timer_s1 = ({cpu_data_master_address_to_slave[26 : 5] , 5'b0} == 27'h1820) & (cpu_data_master_read | cpu_data_master_write);
  //timer_s1_arb_share_counter set values, which is an e_mux
  assign timer_s1_arb_share_set_values = 1;

  //timer_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_s1_non_bursting_master_requests = cpu_data_master_requests_timer_s1;

  //timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_s1_any_bursting_master_saved_grant = 0;

  //timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_s1_arb_share_counter_next_value = timer_s1_firsttransfer ? (timer_s1_arb_share_set_values - 1) : |timer_s1_arb_share_counter ? (timer_s1_arb_share_counter - 1) : 0;

  //timer_s1_allgrants all slave grants, which is an e_mux
  assign timer_s1_allgrants = |timer_s1_grant_vector;

  //timer_s1_end_xfer assignment, which is an e_assign
  assign timer_s1_end_xfer = ~(timer_s1_waits_for_read | timer_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_s1 = timer_s1_end_xfer & (~timer_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_s1 & timer_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests);

  //timer_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_arb_share_counter <= 0;
      else if (timer_s1_arb_counter_enable)
          timer_s1_arb_share_counter <= timer_s1_arb_share_counter_next_value;
    end


  //timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_slavearbiterlockenable <= 0;
      else if ((|timer_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_s1) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests))
          timer_s1_slavearbiterlockenable <= |timer_s1_arb_share_counter_next_value;
    end


  //cpu/data_master timer/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = timer_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_s1_slavearbiterlockenable2 = |timer_s1_arb_share_counter_next_value;

  //cpu/data_master timer/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = timer_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_timer_s1 = cpu_data_master_requests_timer_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //timer_s1_writedata mux, which is an e_mux
  assign timer_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_timer_s1 = cpu_data_master_qualified_request_timer_s1;

  //cpu/data_master saved-grant timer/s1, which is an e_assign
  assign cpu_data_master_saved_grant_timer_s1 = cpu_data_master_requests_timer_s1;

  //allow new arb cycle for timer/s1, which is an e_assign
  assign timer_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_s1_master_qreq_vector = 1;

  //timer_s1_reset_n assignment, which is an e_assign
  assign timer_s1_reset_n = reset_n;

  assign timer_s1_chipselect = cpu_data_master_granted_timer_s1;
  //timer_s1_firsttransfer first transaction, which is an e_assign
  assign timer_s1_firsttransfer = timer_s1_begins_xfer ? timer_s1_unreg_firsttransfer : timer_s1_reg_firsttransfer;

  //timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_s1_unreg_firsttransfer = ~(timer_s1_slavearbiterlockenable & timer_s1_any_continuerequest);

  //timer_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_reg_firsttransfer <= 1'b1;
      else if (timer_s1_begins_xfer)
          timer_s1_reg_firsttransfer <= timer_s1_unreg_firsttransfer;
    end


  //timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_s1_beginbursttransfer_internal = timer_s1_begins_xfer;

  //~timer_s1_write_n assignment, which is an e_mux
  assign timer_s1_write_n = ~(cpu_data_master_granted_timer_s1 & cpu_data_master_write);

  assign shifted_address_to_timer_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //timer_s1_address mux, which is an e_mux
  assign timer_s1_address = shifted_address_to_timer_s1_from_cpu_data_master >> 2;

  //d1_timer_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_s1_end_xfer <= 1;
      else 
        d1_timer_s1_end_xfer <= timer_s1_end_xfer;
    end


  //timer_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_s1_waits_for_read = timer_s1_in_a_read_cycle & timer_s1_begins_xfer;

  //timer_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_s1_in_a_read_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_s1_in_a_read_cycle;

  //timer_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_s1_waits_for_write = timer_s1_in_a_write_cycle & 0;

  //timer_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_s1_in_a_write_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_s1_in_a_write_cycle;

  assign wait_for_timer_s1_counter = 0;
  //assign timer_s1_irq_from_sa = timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_irq_from_sa = timer_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module uart_s1_arbitrator (
                            // inputs:
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_read,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,
                             uart_s1_dataavailable,
                             uart_s1_irq,
                             uart_s1_readdata,
                             uart_s1_readyfordata,

                            // outputs:
                             cpu_data_master_granted_uart_s1,
                             cpu_data_master_qualified_request_uart_s1,
                             cpu_data_master_read_data_valid_uart_s1,
                             cpu_data_master_requests_uart_s1,
                             d1_uart_s1_end_xfer,
                             uart_s1_address,
                             uart_s1_begintransfer,
                             uart_s1_chipselect,
                             uart_s1_dataavailable_from_sa,
                             uart_s1_irq_from_sa,
                             uart_s1_read_n,
                             uart_s1_readdata_from_sa,
                             uart_s1_readyfordata_from_sa,
                             uart_s1_reset_n,
                             uart_s1_write_n,
                             uart_s1_writedata
                          )
;

  output           cpu_data_master_granted_uart_s1;
  output           cpu_data_master_qualified_request_uart_s1;
  output           cpu_data_master_read_data_valid_uart_s1;
  output           cpu_data_master_requests_uart_s1;
  output           d1_uart_s1_end_xfer;
  output  [  2: 0] uart_s1_address;
  output           uart_s1_begintransfer;
  output           uart_s1_chipselect;
  output           uart_s1_dataavailable_from_sa;
  output           uart_s1_irq_from_sa;
  output           uart_s1_read_n;
  output  [ 15: 0] uart_s1_readdata_from_sa;
  output           uart_s1_readyfordata_from_sa;
  output           uart_s1_reset_n;
  output           uart_s1_write_n;
  output  [ 15: 0] uart_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            uart_s1_dataavailable;
  input            uart_s1_irq;
  input   [ 15: 0] uart_s1_readdata;
  input            uart_s1_readyfordata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_uart_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_saved_grant_uart_s1;
  reg              d1_reasons_to_wait;
  reg              d1_uart_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_uart_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_uart_s1_from_cpu_data_master;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_allgrants;
  wire             uart_s1_allow_new_arb_cycle;
  wire             uart_s1_any_bursting_master_saved_grant;
  wire             uart_s1_any_continuerequest;
  wire             uart_s1_arb_counter_enable;
  reg     [  1: 0] uart_s1_arb_share_counter;
  wire    [  1: 0] uart_s1_arb_share_counter_next_value;
  wire    [  1: 0] uart_s1_arb_share_set_values;
  wire             uart_s1_beginbursttransfer_internal;
  wire             uart_s1_begins_xfer;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_end_xfer;
  wire             uart_s1_firsttransfer;
  wire             uart_s1_grant_vector;
  wire             uart_s1_in_a_read_cycle;
  wire             uart_s1_in_a_write_cycle;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_master_qreq_vector;
  wire             uart_s1_non_bursting_master_requests;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  reg              uart_s1_reg_firsttransfer;
  wire             uart_s1_reset_n;
  reg              uart_s1_slavearbiterlockenable;
  wire             uart_s1_slavearbiterlockenable2;
  wire             uart_s1_unreg_firsttransfer;
  wire             uart_s1_waits_for_read;
  wire             uart_s1_waits_for_write;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire             wait_for_uart_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~uart_s1_end_xfer;
    end


  assign uart_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_uart_s1));
  //assign uart_s1_readdata_from_sa = uart_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readdata_from_sa = uart_s1_readdata;

  assign cpu_data_master_requests_uart_s1 = ({cpu_data_master_address_to_slave[26 : 5] , 5'b0} == 27'h1800) & (cpu_data_master_read | cpu_data_master_write);
  //assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable;

  //assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata;

  //uart_s1_arb_share_counter set values, which is an e_mux
  assign uart_s1_arb_share_set_values = 1;

  //uart_s1_non_bursting_master_requests mux, which is an e_mux
  assign uart_s1_non_bursting_master_requests = cpu_data_master_requests_uart_s1;

  //uart_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign uart_s1_any_bursting_master_saved_grant = 0;

  //uart_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign uart_s1_arb_share_counter_next_value = uart_s1_firsttransfer ? (uart_s1_arb_share_set_values - 1) : |uart_s1_arb_share_counter ? (uart_s1_arb_share_counter - 1) : 0;

  //uart_s1_allgrants all slave grants, which is an e_mux
  assign uart_s1_allgrants = |uart_s1_grant_vector;

  //uart_s1_end_xfer assignment, which is an e_assign
  assign uart_s1_end_xfer = ~(uart_s1_waits_for_read | uart_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_uart_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_uart_s1 = uart_s1_end_xfer & (~uart_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //uart_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign uart_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_uart_s1 & uart_s1_allgrants) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests);

  //uart_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_arb_share_counter <= 0;
      else if (uart_s1_arb_counter_enable)
          uart_s1_arb_share_counter <= uart_s1_arb_share_counter_next_value;
    end


  //uart_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_slavearbiterlockenable <= 0;
      else if ((|uart_s1_master_qreq_vector & end_xfer_arb_share_counter_term_uart_s1) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests))
          uart_s1_slavearbiterlockenable <= |uart_s1_arb_share_counter_next_value;
    end


  //cpu/data_master uart/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = uart_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //uart_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign uart_s1_slavearbiterlockenable2 = |uart_s1_arb_share_counter_next_value;

  //cpu/data_master uart/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = uart_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //uart_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign uart_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_uart_s1 = cpu_data_master_requests_uart_s1;
  //uart_s1_writedata mux, which is an e_mux
  assign uart_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_uart_s1 = cpu_data_master_qualified_request_uart_s1;

  //cpu/data_master saved-grant uart/s1, which is an e_assign
  assign cpu_data_master_saved_grant_uart_s1 = cpu_data_master_requests_uart_s1;

  //allow new arb cycle for uart/s1, which is an e_assign
  assign uart_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign uart_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign uart_s1_master_qreq_vector = 1;

  assign uart_s1_begintransfer = uart_s1_begins_xfer;
  //uart_s1_reset_n assignment, which is an e_assign
  assign uart_s1_reset_n = reset_n;

  assign uart_s1_chipselect = cpu_data_master_granted_uart_s1;
  //uart_s1_firsttransfer first transaction, which is an e_assign
  assign uart_s1_firsttransfer = uart_s1_begins_xfer ? uart_s1_unreg_firsttransfer : uart_s1_reg_firsttransfer;

  //uart_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign uart_s1_unreg_firsttransfer = ~(uart_s1_slavearbiterlockenable & uart_s1_any_continuerequest);

  //uart_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_reg_firsttransfer <= 1'b1;
      else if (uart_s1_begins_xfer)
          uart_s1_reg_firsttransfer <= uart_s1_unreg_firsttransfer;
    end


  //uart_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign uart_s1_beginbursttransfer_internal = uart_s1_begins_xfer;

  //~uart_s1_read_n assignment, which is an e_mux
  assign uart_s1_read_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_read);

  //~uart_s1_write_n assignment, which is an e_mux
  assign uart_s1_write_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_write);

  assign shifted_address_to_uart_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //uart_s1_address mux, which is an e_mux
  assign uart_s1_address = shifted_address_to_uart_s1_from_cpu_data_master >> 2;

  //d1_uart_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_uart_s1_end_xfer <= 1;
      else 
        d1_uart_s1_end_xfer <= uart_s1_end_xfer;
    end


  //uart_s1_waits_for_read in a cycle, which is an e_mux
  assign uart_s1_waits_for_read = uart_s1_in_a_read_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_read_cycle assignment, which is an e_assign
  assign uart_s1_in_a_read_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = uart_s1_in_a_read_cycle;

  //uart_s1_waits_for_write in a cycle, which is an e_mux
  assign uart_s1_waits_for_write = uart_s1_in_a_write_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_write_cycle assignment, which is an e_assign
  assign uart_s1_in_a_write_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = uart_s1_in_a_write_cycle;

  assign wait_for_uart_s1_counter = 0;
  //assign uart_s1_irq_from_sa = uart_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_irq_from_sa = uart_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //uart/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module kernel_reset_clk_domain_synch_module (
                                              // inputs:
                                               clk,
                                               data_in,
                                               reset_n,

                                              // outputs:
                                               data_out
                                            )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module kernel (
                // 1) global signals:
                 clk,
                 reset_n,

                // the_KEY2
                 in_port_to_the_KEY2,

                // the_KEY3
                 in_port_to_the_KEY3,

                // the_KEY4
                 in_port_to_the_KEY4,

                // the_buzzer
                 out_port_from_the_buzzer,

                // the_dig
                 out_port_from_the_dig,

                // the_epcs
                 data0_to_the_epcs,
                 dclk_from_the_epcs,
                 sce_from_the_epcs,
                 sdo_from_the_epcs,

                // the_led
                 out_port_from_the_led,

                // the_rtc_data
                 bidir_port_to_and_from_the_rtc_data,

                // the_rtc_rst_n
                 out_port_from_the_rtc_rst_n,

                // the_rtc_sclk
                 out_port_from_the_rtc_sclk,

                // the_scl
                 out_port_from_the_scl,

                // the_sda
                 bidir_port_to_and_from_the_sda,

                // the_sdram
                 zs_addr_from_the_sdram,
                 zs_ba_from_the_sdram,
                 zs_cas_n_from_the_sdram,
                 zs_cke_from_the_sdram,
                 zs_cs_n_from_the_sdram,
                 zs_dq_to_and_from_the_sdram,
                 zs_dqm_from_the_sdram,
                 zs_ras_n_from_the_sdram,
                 zs_we_n_from_the_sdram,

                // the_sel
                 out_port_from_the_sel,

                // the_uart
                 rxd_to_the_uart,
                 txd_from_the_uart
              )
;

  inout            bidir_port_to_and_from_the_rtc_data;
  inout            bidir_port_to_and_from_the_sda;
  output           dclk_from_the_epcs;
  output           out_port_from_the_buzzer;
  output  [  7: 0] out_port_from_the_dig;
  output  [  3: 0] out_port_from_the_led;
  output           out_port_from_the_rtc_rst_n;
  output           out_port_from_the_rtc_sclk;
  output           out_port_from_the_scl;
  output  [  5: 0] out_port_from_the_sel;
  output           sce_from_the_epcs;
  output           sdo_from_the_epcs;
  output           txd_from_the_uart;
  output  [ 12: 0] zs_addr_from_the_sdram;
  output  [  1: 0] zs_ba_from_the_sdram;
  output           zs_cas_n_from_the_sdram;
  output           zs_cke_from_the_sdram;
  output           zs_cs_n_from_the_sdram;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram;
  output  [  1: 0] zs_dqm_from_the_sdram;
  output           zs_ras_n_from_the_sdram;
  output           zs_we_n_from_the_sdram;
  input            clk;
  input            data0_to_the_epcs;
  input            in_port_to_the_KEY2;
  input            in_port_to_the_KEY3;
  input            in_port_to_the_KEY4;
  input            reset_n;
  input            rxd_to_the_uart;

  wire    [  1: 0] KEY2_s1_address;
  wire             KEY2_s1_chipselect;
  wire             KEY2_s1_irq;
  wire             KEY2_s1_irq_from_sa;
  wire    [ 31: 0] KEY2_s1_readdata;
  wire    [ 31: 0] KEY2_s1_readdata_from_sa;
  wire             KEY2_s1_reset_n;
  wire             KEY2_s1_write_n;
  wire    [ 31: 0] KEY2_s1_writedata;
  wire    [  1: 0] KEY3_s1_address;
  wire             KEY3_s1_chipselect;
  wire             KEY3_s1_irq;
  wire             KEY3_s1_irq_from_sa;
  wire    [ 31: 0] KEY3_s1_readdata;
  wire    [ 31: 0] KEY3_s1_readdata_from_sa;
  wire             KEY3_s1_reset_n;
  wire             KEY3_s1_write_n;
  wire    [ 31: 0] KEY3_s1_writedata;
  wire    [  1: 0] KEY4_s1_address;
  wire             KEY4_s1_chipselect;
  wire             KEY4_s1_irq;
  wire             KEY4_s1_irq_from_sa;
  wire    [ 31: 0] KEY4_s1_readdata;
  wire    [ 31: 0] KEY4_s1_readdata_from_sa;
  wire             KEY4_s1_reset_n;
  wire             KEY4_s1_write_n;
  wire    [ 31: 0] KEY4_s1_writedata;
  wire             bidir_port_to_and_from_the_rtc_data;
  wire             bidir_port_to_and_from_the_sda;
  wire    [  1: 0] buzzer_s1_address;
  wire             buzzer_s1_chipselect;
  wire    [ 31: 0] buzzer_s1_readdata;
  wire    [ 31: 0] buzzer_s1_readdata_from_sa;
  wire             buzzer_s1_reset_n;
  wire             buzzer_s1_write_n;
  wire    [ 31: 0] buzzer_s1_writedata;
  wire             clk_reset_n;
  wire    [ 26: 0] cpu_data_master_address;
  wire    [ 26: 0] cpu_data_master_address_to_slave;
  wire    [  3: 0] cpu_data_master_byteenable;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_dbs_address;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire             cpu_data_master_debugaccess;
  wire             cpu_data_master_granted_KEY2_s1;
  wire             cpu_data_master_granted_KEY3_s1;
  wire             cpu_data_master_granted_KEY4_s1;
  wire             cpu_data_master_granted_buzzer_s1;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_granted_dig_s1;
  wire             cpu_data_master_granted_epcs_epcs_control_port;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_granted_led_s1;
  wire             cpu_data_master_granted_rtc_data_s1;
  wire             cpu_data_master_granted_rtc_rst_n_s1;
  wire             cpu_data_master_granted_rtc_sclk_s1;
  wire             cpu_data_master_granted_scl_s1;
  wire             cpu_data_master_granted_sda_s1;
  wire             cpu_data_master_granted_sdram_s1;
  wire             cpu_data_master_granted_sel_s1;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_granted_uart_s1;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_no_byte_enables_and_last_term;
  wire             cpu_data_master_qualified_request_KEY2_s1;
  wire             cpu_data_master_qualified_request_KEY3_s1;
  wire             cpu_data_master_qualified_request_KEY4_s1;
  wire             cpu_data_master_qualified_request_buzzer_s1;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_dig_s1;
  wire             cpu_data_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_led_s1;
  wire             cpu_data_master_qualified_request_rtc_data_s1;
  wire             cpu_data_master_qualified_request_rtc_rst_n_s1;
  wire             cpu_data_master_qualified_request_rtc_sclk_s1;
  wire             cpu_data_master_qualified_request_scl_s1;
  wire             cpu_data_master_qualified_request_sda_s1;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_qualified_request_sel_s1;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read;
  wire             cpu_data_master_read_data_valid_KEY2_s1;
  wire             cpu_data_master_read_data_valid_KEY3_s1;
  wire             cpu_data_master_read_data_valid_KEY4_s1;
  wire             cpu_data_master_read_data_valid_buzzer_s1;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_dig_s1;
  wire             cpu_data_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_led_s1;
  wire             cpu_data_master_read_data_valid_rtc_data_s1;
  wire             cpu_data_master_read_data_valid_rtc_rst_n_s1;
  wire             cpu_data_master_read_data_valid_rtc_sclk_s1;
  wire             cpu_data_master_read_data_valid_scl_s1;
  wire             cpu_data_master_read_data_valid_sda_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_data_master_read_data_valid_sel_s1;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_requests_KEY2_s1;
  wire             cpu_data_master_requests_KEY3_s1;
  wire             cpu_data_master_requests_KEY4_s1;
  wire             cpu_data_master_requests_buzzer_s1;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_dig_s1;
  wire             cpu_data_master_requests_epcs_epcs_control_port;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_led_s1;
  wire             cpu_data_master_requests_rtc_data_s1;
  wire             cpu_data_master_requests_rtc_rst_n_s1;
  wire             cpu_data_master_requests_rtc_sclk_s1;
  wire             cpu_data_master_requests_scl_s1;
  wire             cpu_data_master_requests_sda_s1;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_requests_sel_s1;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_waitrequest;
  wire             cpu_data_master_write;
  wire    [ 31: 0] cpu_data_master_writedata;
  wire    [ 26: 0] cpu_instruction_master_address;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_instruction_master_dbs_address;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_granted_epcs_epcs_control_port;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_latency_counter;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_read;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_epcs_epcs_control_port;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_waitrequest;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire             cpu_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  wire             d1_KEY2_s1_end_xfer;
  wire             d1_KEY3_s1_end_xfer;
  wire             d1_KEY4_s1_end_xfer;
  wire             d1_buzzer_s1_end_xfer;
  wire             d1_cpu_jtag_debug_module_end_xfer;
  wire             d1_dig_s1_end_xfer;
  wire             d1_epcs_epcs_control_port_end_xfer;
  wire             d1_jtag_uart_avalon_jtag_slave_end_xfer;
  wire             d1_led_s1_end_xfer;
  wire             d1_rtc_data_s1_end_xfer;
  wire             d1_rtc_rst_n_s1_end_xfer;
  wire             d1_rtc_sclk_s1_end_xfer;
  wire             d1_scl_s1_end_xfer;
  wire             d1_sda_s1_end_xfer;
  wire             d1_sdram_s1_end_xfer;
  wire             d1_sel_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_s1_end_xfer;
  wire             d1_uart_s1_end_xfer;
  wire             dclk_from_the_epcs;
  wire    [  1: 0] dig_s1_address;
  wire             dig_s1_chipselect;
  wire    [ 31: 0] dig_s1_readdata;
  wire    [ 31: 0] dig_s1_readdata_from_sa;
  wire             dig_s1_reset_n;
  wire             dig_s1_write_n;
  wire    [ 31: 0] dig_s1_writedata;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_chipselect;
  wire             epcs_epcs_control_port_dataavailable;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_endofpacket;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_irq;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             epcs_epcs_control_port_reset_n;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_irq;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  wire             jtag_uart_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [  1: 0] led_s1_address;
  wire             led_s1_chipselect;
  wire    [ 31: 0] led_s1_readdata;
  wire    [ 31: 0] led_s1_readdata_from_sa;
  wire             led_s1_reset_n;
  wire             led_s1_write_n;
  wire    [ 31: 0] led_s1_writedata;
  wire             out_port_from_the_buzzer;
  wire    [  7: 0] out_port_from_the_dig;
  wire    [  3: 0] out_port_from_the_led;
  wire             out_port_from_the_rtc_rst_n;
  wire             out_port_from_the_rtc_sclk;
  wire             out_port_from_the_scl;
  wire    [  5: 0] out_port_from_the_sel;
  wire             reset_n_sources;
  wire    [  1: 0] rtc_data_s1_address;
  wire             rtc_data_s1_chipselect;
  wire    [ 31: 0] rtc_data_s1_readdata;
  wire    [ 31: 0] rtc_data_s1_readdata_from_sa;
  wire             rtc_data_s1_reset_n;
  wire             rtc_data_s1_write_n;
  wire    [ 31: 0] rtc_data_s1_writedata;
  wire    [  1: 0] rtc_rst_n_s1_address;
  wire             rtc_rst_n_s1_chipselect;
  wire    [ 31: 0] rtc_rst_n_s1_readdata;
  wire    [ 31: 0] rtc_rst_n_s1_readdata_from_sa;
  wire             rtc_rst_n_s1_reset_n;
  wire             rtc_rst_n_s1_write_n;
  wire    [ 31: 0] rtc_rst_n_s1_writedata;
  wire    [  1: 0] rtc_sclk_s1_address;
  wire             rtc_sclk_s1_chipselect;
  wire    [ 31: 0] rtc_sclk_s1_readdata;
  wire    [ 31: 0] rtc_sclk_s1_readdata_from_sa;
  wire             rtc_sclk_s1_reset_n;
  wire             rtc_sclk_s1_write_n;
  wire    [ 31: 0] rtc_sclk_s1_writedata;
  wire             sce_from_the_epcs;
  wire    [  1: 0] scl_s1_address;
  wire             scl_s1_chipselect;
  wire    [ 31: 0] scl_s1_readdata;
  wire    [ 31: 0] scl_s1_readdata_from_sa;
  wire             scl_s1_reset_n;
  wire             scl_s1_write_n;
  wire    [ 31: 0] scl_s1_writedata;
  wire    [  1: 0] sda_s1_address;
  wire             sda_s1_chipselect;
  wire    [ 31: 0] sda_s1_readdata;
  wire    [ 31: 0] sda_s1_readdata_from_sa;
  wire             sda_s1_reset_n;
  wire             sda_s1_write_n;
  wire    [ 31: 0] sda_s1_writedata;
  wire             sdo_from_the_epcs;
  wire    [ 23: 0] sdram_s1_address;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid;
  wire             sdram_s1_reset_n;
  wire             sdram_s1_waitrequest;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire    [  1: 0] sel_s1_address;
  wire             sel_s1_chipselect;
  wire    [ 31: 0] sel_s1_readdata;
  wire    [ 31: 0] sel_s1_readdata_from_sa;
  wire             sel_s1_reset_n;
  wire             sel_s1_write_n;
  wire    [ 31: 0] sel_s1_writedata;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_chipselect;
  wire             timer_s1_irq;
  wire             timer_s1_irq_from_sa;
  wire    [ 15: 0] timer_s1_readdata;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  wire             timer_s1_reset_n;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire             txd_from_the_uart;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_irq;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata;
  wire             uart_s1_readyfordata_from_sa;
  wire             uart_s1_reset_n;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;
  KEY2_s1_arbitrator the_KEY2_s1
    (
      .KEY2_s1_address                           (KEY2_s1_address),
      .KEY2_s1_chipselect                        (KEY2_s1_chipselect),
      .KEY2_s1_irq                               (KEY2_s1_irq),
      .KEY2_s1_irq_from_sa                       (KEY2_s1_irq_from_sa),
      .KEY2_s1_readdata                          (KEY2_s1_readdata),
      .KEY2_s1_readdata_from_sa                  (KEY2_s1_readdata_from_sa),
      .KEY2_s1_reset_n                           (KEY2_s1_reset_n),
      .KEY2_s1_write_n                           (KEY2_s1_write_n),
      .KEY2_s1_writedata                         (KEY2_s1_writedata),
      .clk                                       (clk),
      .cpu_data_master_address_to_slave          (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_KEY2_s1           (cpu_data_master_granted_KEY2_s1),
      .cpu_data_master_qualified_request_KEY2_s1 (cpu_data_master_qualified_request_KEY2_s1),
      .cpu_data_master_read                      (cpu_data_master_read),
      .cpu_data_master_read_data_valid_KEY2_s1   (cpu_data_master_read_data_valid_KEY2_s1),
      .cpu_data_master_requests_KEY2_s1          (cpu_data_master_requests_KEY2_s1),
      .cpu_data_master_waitrequest               (cpu_data_master_waitrequest),
      .cpu_data_master_write                     (cpu_data_master_write),
      .cpu_data_master_writedata                 (cpu_data_master_writedata),
      .d1_KEY2_s1_end_xfer                       (d1_KEY2_s1_end_xfer),
      .reset_n                                   (clk_reset_n)
    );

  KEY2 the_KEY2
    (
      .address    (KEY2_s1_address),
      .chipselect (KEY2_s1_chipselect),
      .clk        (clk),
      .in_port    (in_port_to_the_KEY2),
      .irq        (KEY2_s1_irq),
      .readdata   (KEY2_s1_readdata),
      .reset_n    (KEY2_s1_reset_n),
      .write_n    (KEY2_s1_write_n),
      .writedata  (KEY2_s1_writedata)
    );

  KEY3_s1_arbitrator the_KEY3_s1
    (
      .KEY3_s1_address                           (KEY3_s1_address),
      .KEY3_s1_chipselect                        (KEY3_s1_chipselect),
      .KEY3_s1_irq                               (KEY3_s1_irq),
      .KEY3_s1_irq_from_sa                       (KEY3_s1_irq_from_sa),
      .KEY3_s1_readdata                          (KEY3_s1_readdata),
      .KEY3_s1_readdata_from_sa                  (KEY3_s1_readdata_from_sa),
      .KEY3_s1_reset_n                           (KEY3_s1_reset_n),
      .KEY3_s1_write_n                           (KEY3_s1_write_n),
      .KEY3_s1_writedata                         (KEY3_s1_writedata),
      .clk                                       (clk),
      .cpu_data_master_address_to_slave          (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_KEY3_s1           (cpu_data_master_granted_KEY3_s1),
      .cpu_data_master_qualified_request_KEY3_s1 (cpu_data_master_qualified_request_KEY3_s1),
      .cpu_data_master_read                      (cpu_data_master_read),
      .cpu_data_master_read_data_valid_KEY3_s1   (cpu_data_master_read_data_valid_KEY3_s1),
      .cpu_data_master_requests_KEY3_s1          (cpu_data_master_requests_KEY3_s1),
      .cpu_data_master_waitrequest               (cpu_data_master_waitrequest),
      .cpu_data_master_write                     (cpu_data_master_write),
      .cpu_data_master_writedata                 (cpu_data_master_writedata),
      .d1_KEY3_s1_end_xfer                       (d1_KEY3_s1_end_xfer),
      .reset_n                                   (clk_reset_n)
    );

  KEY3 the_KEY3
    (
      .address    (KEY3_s1_address),
      .chipselect (KEY3_s1_chipselect),
      .clk        (clk),
      .in_port    (in_port_to_the_KEY3),
      .irq        (KEY3_s1_irq),
      .readdata   (KEY3_s1_readdata),
      .reset_n    (KEY3_s1_reset_n),
      .write_n    (KEY3_s1_write_n),
      .writedata  (KEY3_s1_writedata)
    );

  KEY4_s1_arbitrator the_KEY4_s1
    (
      .KEY4_s1_address                           (KEY4_s1_address),
      .KEY4_s1_chipselect                        (KEY4_s1_chipselect),
      .KEY4_s1_irq                               (KEY4_s1_irq),
      .KEY4_s1_irq_from_sa                       (KEY4_s1_irq_from_sa),
      .KEY4_s1_readdata                          (KEY4_s1_readdata),
      .KEY4_s1_readdata_from_sa                  (KEY4_s1_readdata_from_sa),
      .KEY4_s1_reset_n                           (KEY4_s1_reset_n),
      .KEY4_s1_write_n                           (KEY4_s1_write_n),
      .KEY4_s1_writedata                         (KEY4_s1_writedata),
      .clk                                       (clk),
      .cpu_data_master_address_to_slave          (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_KEY4_s1           (cpu_data_master_granted_KEY4_s1),
      .cpu_data_master_qualified_request_KEY4_s1 (cpu_data_master_qualified_request_KEY4_s1),
      .cpu_data_master_read                      (cpu_data_master_read),
      .cpu_data_master_read_data_valid_KEY4_s1   (cpu_data_master_read_data_valid_KEY4_s1),
      .cpu_data_master_requests_KEY4_s1          (cpu_data_master_requests_KEY4_s1),
      .cpu_data_master_waitrequest               (cpu_data_master_waitrequest),
      .cpu_data_master_write                     (cpu_data_master_write),
      .cpu_data_master_writedata                 (cpu_data_master_writedata),
      .d1_KEY4_s1_end_xfer                       (d1_KEY4_s1_end_xfer),
      .reset_n                                   (clk_reset_n)
    );

  KEY4 the_KEY4
    (
      .address    (KEY4_s1_address),
      .chipselect (KEY4_s1_chipselect),
      .clk        (clk),
      .in_port    (in_port_to_the_KEY4),
      .irq        (KEY4_s1_irq),
      .readdata   (KEY4_s1_readdata),
      .reset_n    (KEY4_s1_reset_n),
      .write_n    (KEY4_s1_write_n),
      .writedata  (KEY4_s1_writedata)
    );

  buzzer_s1_arbitrator the_buzzer_s1
    (
      .buzzer_s1_address                           (buzzer_s1_address),
      .buzzer_s1_chipselect                        (buzzer_s1_chipselect),
      .buzzer_s1_readdata                          (buzzer_s1_readdata),
      .buzzer_s1_readdata_from_sa                  (buzzer_s1_readdata_from_sa),
      .buzzer_s1_reset_n                           (buzzer_s1_reset_n),
      .buzzer_s1_write_n                           (buzzer_s1_write_n),
      .buzzer_s1_writedata                         (buzzer_s1_writedata),
      .clk                                         (clk),
      .cpu_data_master_address_to_slave            (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_buzzer_s1           (cpu_data_master_granted_buzzer_s1),
      .cpu_data_master_qualified_request_buzzer_s1 (cpu_data_master_qualified_request_buzzer_s1),
      .cpu_data_master_read                        (cpu_data_master_read),
      .cpu_data_master_read_data_valid_buzzer_s1   (cpu_data_master_read_data_valid_buzzer_s1),
      .cpu_data_master_requests_buzzer_s1          (cpu_data_master_requests_buzzer_s1),
      .cpu_data_master_waitrequest                 (cpu_data_master_waitrequest),
      .cpu_data_master_write                       (cpu_data_master_write),
      .cpu_data_master_writedata                   (cpu_data_master_writedata),
      .d1_buzzer_s1_end_xfer                       (d1_buzzer_s1_end_xfer),
      .reset_n                                     (clk_reset_n)
    );

  buzzer the_buzzer
    (
      .address    (buzzer_s1_address),
      .chipselect (buzzer_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_buzzer),
      .readdata   (buzzer_s1_readdata),
      .reset_n    (buzzer_s1_reset_n),
      .write_n    (buzzer_s1_write_n),
      .writedata  (buzzer_s1_writedata)
    );

  cpu_jtag_debug_module_arbitrator the_cpu_jtag_debug_module
    (
      .clk                                                            (clk),
      .cpu_data_master_address_to_slave                               (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                     (cpu_data_master_byteenable),
      .cpu_data_master_debugaccess                                    (cpu_data_master_debugaccess),
      .cpu_data_master_granted_cpu_jtag_debug_module                  (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module        (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_read                                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module          (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_requests_cpu_jtag_debug_module                 (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_waitrequest                                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                                          (cpu_data_master_write),
      .cpu_data_master_writedata                                      (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                        (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_cpu_jtag_debug_module           (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_latency_counter                         (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_read                                    (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module   (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_cpu_jtag_debug_module          (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_jtag_debug_module_address                                  (cpu_jtag_debug_module_address),
      .cpu_jtag_debug_module_begintransfer                            (cpu_jtag_debug_module_begintransfer),
      .cpu_jtag_debug_module_byteenable                               (cpu_jtag_debug_module_byteenable),
      .cpu_jtag_debug_module_chipselect                               (cpu_jtag_debug_module_chipselect),
      .cpu_jtag_debug_module_debugaccess                              (cpu_jtag_debug_module_debugaccess),
      .cpu_jtag_debug_module_readdata                                 (cpu_jtag_debug_module_readdata),
      .cpu_jtag_debug_module_readdata_from_sa                         (cpu_jtag_debug_module_readdata_from_sa),
      .cpu_jtag_debug_module_reset_n                                  (cpu_jtag_debug_module_reset_n),
      .cpu_jtag_debug_module_resetrequest                             (cpu_jtag_debug_module_resetrequest),
      .cpu_jtag_debug_module_resetrequest_from_sa                     (cpu_jtag_debug_module_resetrequest_from_sa),
      .cpu_jtag_debug_module_write                                    (cpu_jtag_debug_module_write),
      .cpu_jtag_debug_module_writedata                                (cpu_jtag_debug_module_writedata),
      .d1_cpu_jtag_debug_module_end_xfer                              (d1_cpu_jtag_debug_module_end_xfer),
      .reset_n                                                        (clk_reset_n)
    );

  cpu_data_master_arbitrator the_cpu_data_master
    (
      .KEY2_s1_irq_from_sa                                           (KEY2_s1_irq_from_sa),
      .KEY2_s1_readdata_from_sa                                      (KEY2_s1_readdata_from_sa),
      .KEY3_s1_irq_from_sa                                           (KEY3_s1_irq_from_sa),
      .KEY3_s1_readdata_from_sa                                      (KEY3_s1_readdata_from_sa),
      .KEY4_s1_irq_from_sa                                           (KEY4_s1_irq_from_sa),
      .KEY4_s1_readdata_from_sa                                      (KEY4_s1_readdata_from_sa),
      .buzzer_s1_readdata_from_sa                                    (buzzer_s1_readdata_from_sa),
      .clk                                                           (clk),
      .cpu_data_master_address                                       (cpu_data_master_address),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable_sdram_s1                           (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                   (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                  (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_KEY2_s1                               (cpu_data_master_granted_KEY2_s1),
      .cpu_data_master_granted_KEY3_s1                               (cpu_data_master_granted_KEY3_s1),
      .cpu_data_master_granted_KEY4_s1                               (cpu_data_master_granted_KEY4_s1),
      .cpu_data_master_granted_buzzer_s1                             (cpu_data_master_granted_buzzer_s1),
      .cpu_data_master_granted_cpu_jtag_debug_module                 (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_granted_dig_s1                                (cpu_data_master_granted_dig_s1),
      .cpu_data_master_granted_epcs_epcs_control_port                (cpu_data_master_granted_epcs_epcs_control_port),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_granted_led_s1                                (cpu_data_master_granted_led_s1),
      .cpu_data_master_granted_rtc_data_s1                           (cpu_data_master_granted_rtc_data_s1),
      .cpu_data_master_granted_rtc_rst_n_s1                          (cpu_data_master_granted_rtc_rst_n_s1),
      .cpu_data_master_granted_rtc_sclk_s1                           (cpu_data_master_granted_rtc_sclk_s1),
      .cpu_data_master_granted_scl_s1                                (cpu_data_master_granted_scl_s1),
      .cpu_data_master_granted_sda_s1                                (cpu_data_master_granted_sda_s1),
      .cpu_data_master_granted_sdram_s1                              (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_granted_sel_s1                                (cpu_data_master_granted_sel_s1),
      .cpu_data_master_granted_sysid_control_slave                   (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_granted_timer_s1                              (cpu_data_master_granted_timer_s1),
      .cpu_data_master_granted_uart_s1                               (cpu_data_master_granted_uart_s1),
      .cpu_data_master_irq                                           (cpu_data_master_irq),
      .cpu_data_master_no_byte_enables_and_last_term                 (cpu_data_master_no_byte_enables_and_last_term),
      .cpu_data_master_qualified_request_KEY2_s1                     (cpu_data_master_qualified_request_KEY2_s1),
      .cpu_data_master_qualified_request_KEY3_s1                     (cpu_data_master_qualified_request_KEY3_s1),
      .cpu_data_master_qualified_request_KEY4_s1                     (cpu_data_master_qualified_request_KEY4_s1),
      .cpu_data_master_qualified_request_buzzer_s1                   (cpu_data_master_qualified_request_buzzer_s1),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module       (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_dig_s1                      (cpu_data_master_qualified_request_dig_s1),
      .cpu_data_master_qualified_request_epcs_epcs_control_port      (cpu_data_master_qualified_request_epcs_epcs_control_port),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_led_s1                      (cpu_data_master_qualified_request_led_s1),
      .cpu_data_master_qualified_request_rtc_data_s1                 (cpu_data_master_qualified_request_rtc_data_s1),
      .cpu_data_master_qualified_request_rtc_rst_n_s1                (cpu_data_master_qualified_request_rtc_rst_n_s1),
      .cpu_data_master_qualified_request_rtc_sclk_s1                 (cpu_data_master_qualified_request_rtc_sclk_s1),
      .cpu_data_master_qualified_request_scl_s1                      (cpu_data_master_qualified_request_scl_s1),
      .cpu_data_master_qualified_request_sda_s1                      (cpu_data_master_qualified_request_sda_s1),
      .cpu_data_master_qualified_request_sdram_s1                    (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_qualified_request_sel_s1                      (cpu_data_master_qualified_request_sel_s1),
      .cpu_data_master_qualified_request_sysid_control_slave         (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_qualified_request_timer_s1                    (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_qualified_request_uart_s1                     (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_KEY2_s1                       (cpu_data_master_read_data_valid_KEY2_s1),
      .cpu_data_master_read_data_valid_KEY3_s1                       (cpu_data_master_read_data_valid_KEY3_s1),
      .cpu_data_master_read_data_valid_KEY4_s1                       (cpu_data_master_read_data_valid_KEY4_s1),
      .cpu_data_master_read_data_valid_buzzer_s1                     (cpu_data_master_read_data_valid_buzzer_s1),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module         (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_dig_s1                        (cpu_data_master_read_data_valid_dig_s1),
      .cpu_data_master_read_data_valid_epcs_epcs_control_port        (cpu_data_master_read_data_valid_epcs_epcs_control_port),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_led_s1                        (cpu_data_master_read_data_valid_led_s1),
      .cpu_data_master_read_data_valid_rtc_data_s1                   (cpu_data_master_read_data_valid_rtc_data_s1),
      .cpu_data_master_read_data_valid_rtc_rst_n_s1                  (cpu_data_master_read_data_valid_rtc_rst_n_s1),
      .cpu_data_master_read_data_valid_rtc_sclk_s1                   (cpu_data_master_read_data_valid_rtc_sclk_s1),
      .cpu_data_master_read_data_valid_scl_s1                        (cpu_data_master_read_data_valid_scl_s1),
      .cpu_data_master_read_data_valid_sda_s1                        (cpu_data_master_read_data_valid_sda_s1),
      .cpu_data_master_read_data_valid_sdram_s1                      (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register       (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_read_data_valid_sel_s1                        (cpu_data_master_read_data_valid_sel_s1),
      .cpu_data_master_read_data_valid_sysid_control_slave           (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_read_data_valid_timer_s1                      (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_read_data_valid_uart_s1                       (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_readdata                                      (cpu_data_master_readdata),
      .cpu_data_master_requests_KEY2_s1                              (cpu_data_master_requests_KEY2_s1),
      .cpu_data_master_requests_KEY3_s1                              (cpu_data_master_requests_KEY3_s1),
      .cpu_data_master_requests_KEY4_s1                              (cpu_data_master_requests_KEY4_s1),
      .cpu_data_master_requests_buzzer_s1                            (cpu_data_master_requests_buzzer_s1),
      .cpu_data_master_requests_cpu_jtag_debug_module                (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_requests_dig_s1                               (cpu_data_master_requests_dig_s1),
      .cpu_data_master_requests_epcs_epcs_control_port               (cpu_data_master_requests_epcs_epcs_control_port),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_led_s1                               (cpu_data_master_requests_led_s1),
      .cpu_data_master_requests_rtc_data_s1                          (cpu_data_master_requests_rtc_data_s1),
      .cpu_data_master_requests_rtc_rst_n_s1                         (cpu_data_master_requests_rtc_rst_n_s1),
      .cpu_data_master_requests_rtc_sclk_s1                          (cpu_data_master_requests_rtc_sclk_s1),
      .cpu_data_master_requests_scl_s1                               (cpu_data_master_requests_scl_s1),
      .cpu_data_master_requests_sda_s1                               (cpu_data_master_requests_sda_s1),
      .cpu_data_master_requests_sdram_s1                             (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_requests_sel_s1                               (cpu_data_master_requests_sel_s1),
      .cpu_data_master_requests_sysid_control_slave                  (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_requests_timer_s1                             (cpu_data_master_requests_timer_s1),
      .cpu_data_master_requests_uart_s1                              (cpu_data_master_requests_uart_s1),
      .cpu_data_master_waitrequest                                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .cpu_jtag_debug_module_readdata_from_sa                        (cpu_jtag_debug_module_readdata_from_sa),
      .d1_KEY2_s1_end_xfer                                           (d1_KEY2_s1_end_xfer),
      .d1_KEY3_s1_end_xfer                                           (d1_KEY3_s1_end_xfer),
      .d1_KEY4_s1_end_xfer                                           (d1_KEY4_s1_end_xfer),
      .d1_buzzer_s1_end_xfer                                         (d1_buzzer_s1_end_xfer),
      .d1_cpu_jtag_debug_module_end_xfer                             (d1_cpu_jtag_debug_module_end_xfer),
      .d1_dig_s1_end_xfer                                            (d1_dig_s1_end_xfer),
      .d1_epcs_epcs_control_port_end_xfer                            (d1_epcs_epcs_control_port_end_xfer),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .d1_led_s1_end_xfer                                            (d1_led_s1_end_xfer),
      .d1_rtc_data_s1_end_xfer                                       (d1_rtc_data_s1_end_xfer),
      .d1_rtc_rst_n_s1_end_xfer                                      (d1_rtc_rst_n_s1_end_xfer),
      .d1_rtc_sclk_s1_end_xfer                                       (d1_rtc_sclk_s1_end_xfer),
      .d1_scl_s1_end_xfer                                            (d1_scl_s1_end_xfer),
      .d1_sda_s1_end_xfer                                            (d1_sda_s1_end_xfer),
      .d1_sdram_s1_end_xfer                                          (d1_sdram_s1_end_xfer),
      .d1_sel_s1_end_xfer                                            (d1_sel_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                               (d1_sysid_control_slave_end_xfer),
      .d1_timer_s1_end_xfer                                          (d1_timer_s1_end_xfer),
      .d1_uart_s1_end_xfer                                           (d1_uart_s1_end_xfer),
      .dig_s1_readdata_from_sa                                       (dig_s1_readdata_from_sa),
      .epcs_epcs_control_port_irq_from_sa                            (epcs_epcs_control_port_irq_from_sa),
      .epcs_epcs_control_port_readdata_from_sa                       (epcs_epcs_control_port_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .led_s1_readdata_from_sa                                       (led_s1_readdata_from_sa),
      .reset_n                                                       (clk_reset_n),
      .rtc_data_s1_readdata_from_sa                                  (rtc_data_s1_readdata_from_sa),
      .rtc_rst_n_s1_readdata_from_sa                                 (rtc_rst_n_s1_readdata_from_sa),
      .rtc_sclk_s1_readdata_from_sa                                  (rtc_sclk_s1_readdata_from_sa),
      .scl_s1_readdata_from_sa                                       (scl_s1_readdata_from_sa),
      .sda_s1_readdata_from_sa                                       (sda_s1_readdata_from_sa),
      .sdram_s1_readdata_from_sa                                     (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                  (sdram_s1_waitrequest_from_sa),
      .sel_s1_readdata_from_sa                                       (sel_s1_readdata_from_sa),
      .sysid_control_slave_readdata_from_sa                          (sysid_control_slave_readdata_from_sa),
      .timer_s1_irq_from_sa                                          (timer_s1_irq_from_sa),
      .timer_s1_readdata_from_sa                                     (timer_s1_readdata_from_sa),
      .uart_s1_irq_from_sa                                           (uart_s1_irq_from_sa),
      .uart_s1_readdata_from_sa                                      (uart_s1_readdata_from_sa)
    );

  cpu_instruction_master_arbitrator the_cpu_instruction_master
    (
      .clk                                                             (clk),
      .cpu_instruction_master_address                                  (cpu_instruction_master_address),
      .cpu_instruction_master_address_to_slave                         (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                              (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cpu_jtag_debug_module            (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_granted_epcs_epcs_control_port           (cpu_instruction_master_granted_epcs_epcs_control_port),
      .cpu_instruction_master_granted_sdram_s1                         (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                          (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module  (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_qualified_request_epcs_epcs_control_port (cpu_instruction_master_qualified_request_epcs_epcs_control_port),
      .cpu_instruction_master_qualified_request_sdram_s1               (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                     (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module    (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_epcs_epcs_control_port   (cpu_instruction_master_read_data_valid_epcs_epcs_control_port),
      .cpu_instruction_master_read_data_valid_sdram_s1                 (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register  (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_readdata                                 (cpu_instruction_master_readdata),
      .cpu_instruction_master_readdatavalid                            (cpu_instruction_master_readdatavalid),
      .cpu_instruction_master_requests_cpu_jtag_debug_module           (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_instruction_master_requests_epcs_epcs_control_port          (cpu_instruction_master_requests_epcs_epcs_control_port),
      .cpu_instruction_master_requests_sdram_s1                        (cpu_instruction_master_requests_sdram_s1),
      .cpu_instruction_master_waitrequest                              (cpu_instruction_master_waitrequest),
      .cpu_jtag_debug_module_readdata_from_sa                          (cpu_jtag_debug_module_readdata_from_sa),
      .d1_cpu_jtag_debug_module_end_xfer                               (d1_cpu_jtag_debug_module_end_xfer),
      .d1_epcs_epcs_control_port_end_xfer                              (d1_epcs_epcs_control_port_end_xfer),
      .d1_sdram_s1_end_xfer                                            (d1_sdram_s1_end_xfer),
      .epcs_epcs_control_port_readdata_from_sa                         (epcs_epcs_control_port_readdata_from_sa),
      .reset_n                                                         (clk_reset_n),
      .sdram_s1_readdata_from_sa                                       (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                    (sdram_s1_waitrequest_from_sa)
    );

  cpu the_cpu
    (
      .clk                                   (clk),
      .d_address                             (cpu_data_master_address),
      .d_byteenable                          (cpu_data_master_byteenable),
      .d_irq                                 (cpu_data_master_irq),
      .d_read                                (cpu_data_master_read),
      .d_readdata                            (cpu_data_master_readdata),
      .d_waitrequest                         (cpu_data_master_waitrequest),
      .d_write                               (cpu_data_master_write),
      .d_writedata                           (cpu_data_master_writedata),
      .i_address                             (cpu_instruction_master_address),
      .i_read                                (cpu_instruction_master_read),
      .i_readdata                            (cpu_instruction_master_readdata),
      .i_readdatavalid                       (cpu_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_jtag_debug_module_writedata),
      .reset_n                               (cpu_jtag_debug_module_reset_n)
    );

  dig_s1_arbitrator the_dig_s1
    (
      .clk                                      (clk),
      .cpu_data_master_address_to_slave         (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_dig_s1           (cpu_data_master_granted_dig_s1),
      .cpu_data_master_qualified_request_dig_s1 (cpu_data_master_qualified_request_dig_s1),
      .cpu_data_master_read                     (cpu_data_master_read),
      .cpu_data_master_read_data_valid_dig_s1   (cpu_data_master_read_data_valid_dig_s1),
      .cpu_data_master_requests_dig_s1          (cpu_data_master_requests_dig_s1),
      .cpu_data_master_waitrequest              (cpu_data_master_waitrequest),
      .cpu_data_master_write                    (cpu_data_master_write),
      .cpu_data_master_writedata                (cpu_data_master_writedata),
      .d1_dig_s1_end_xfer                       (d1_dig_s1_end_xfer),
      .dig_s1_address                           (dig_s1_address),
      .dig_s1_chipselect                        (dig_s1_chipselect),
      .dig_s1_readdata                          (dig_s1_readdata),
      .dig_s1_readdata_from_sa                  (dig_s1_readdata_from_sa),
      .dig_s1_reset_n                           (dig_s1_reset_n),
      .dig_s1_write_n                           (dig_s1_write_n),
      .dig_s1_writedata                         (dig_s1_writedata),
      .reset_n                                  (clk_reset_n)
    );

  dig the_dig
    (
      .address    (dig_s1_address),
      .chipselect (dig_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_dig),
      .readdata   (dig_s1_readdata),
      .reset_n    (dig_s1_reset_n),
      .write_n    (dig_s1_write_n),
      .writedata  (dig_s1_writedata)
    );

  epcs_epcs_control_port_arbitrator the_epcs_epcs_control_port
    (
      .clk                                                             (clk),
      .cpu_data_master_address_to_slave                                (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_epcs_epcs_control_port                  (cpu_data_master_granted_epcs_epcs_control_port),
      .cpu_data_master_qualified_request_epcs_epcs_control_port        (cpu_data_master_qualified_request_epcs_epcs_control_port),
      .cpu_data_master_read                                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_epcs_epcs_control_port          (cpu_data_master_read_data_valid_epcs_epcs_control_port),
      .cpu_data_master_requests_epcs_epcs_control_port                 (cpu_data_master_requests_epcs_epcs_control_port),
      .cpu_data_master_write                                           (cpu_data_master_write),
      .cpu_data_master_writedata                                       (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                         (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_epcs_epcs_control_port           (cpu_instruction_master_granted_epcs_epcs_control_port),
      .cpu_instruction_master_latency_counter                          (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_epcs_epcs_control_port (cpu_instruction_master_qualified_request_epcs_epcs_control_port),
      .cpu_instruction_master_read                                     (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_epcs_epcs_control_port   (cpu_instruction_master_read_data_valid_epcs_epcs_control_port),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register  (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_epcs_epcs_control_port          (cpu_instruction_master_requests_epcs_epcs_control_port),
      .d1_epcs_epcs_control_port_end_xfer                              (d1_epcs_epcs_control_port_end_xfer),
      .epcs_epcs_control_port_address                                  (epcs_epcs_control_port_address),
      .epcs_epcs_control_port_chipselect                               (epcs_epcs_control_port_chipselect),
      .epcs_epcs_control_port_dataavailable                            (epcs_epcs_control_port_dataavailable),
      .epcs_epcs_control_port_dataavailable_from_sa                    (epcs_epcs_control_port_dataavailable_from_sa),
      .epcs_epcs_control_port_endofpacket                              (epcs_epcs_control_port_endofpacket),
      .epcs_epcs_control_port_endofpacket_from_sa                      (epcs_epcs_control_port_endofpacket_from_sa),
      .epcs_epcs_control_port_irq                                      (epcs_epcs_control_port_irq),
      .epcs_epcs_control_port_irq_from_sa                              (epcs_epcs_control_port_irq_from_sa),
      .epcs_epcs_control_port_read_n                                   (epcs_epcs_control_port_read_n),
      .epcs_epcs_control_port_readdata                                 (epcs_epcs_control_port_readdata),
      .epcs_epcs_control_port_readdata_from_sa                         (epcs_epcs_control_port_readdata_from_sa),
      .epcs_epcs_control_port_readyfordata                             (epcs_epcs_control_port_readyfordata),
      .epcs_epcs_control_port_readyfordata_from_sa                     (epcs_epcs_control_port_readyfordata_from_sa),
      .epcs_epcs_control_port_reset_n                                  (epcs_epcs_control_port_reset_n),
      .epcs_epcs_control_port_write_n                                  (epcs_epcs_control_port_write_n),
      .epcs_epcs_control_port_writedata                                (epcs_epcs_control_port_writedata),
      .reset_n                                                         (clk_reset_n)
    );

  epcs the_epcs
    (
      .address       (epcs_epcs_control_port_address),
      .chipselect    (epcs_epcs_control_port_chipselect),
      .clk           (clk),
      .data0         (data0_to_the_epcs),
      .dataavailable (epcs_epcs_control_port_dataavailable),
      .dclk          (dclk_from_the_epcs),
      .endofpacket   (epcs_epcs_control_port_endofpacket),
      .irq           (epcs_epcs_control_port_irq),
      .read_n        (epcs_epcs_control_port_read_n),
      .readdata      (epcs_epcs_control_port_readdata),
      .readyfordata  (epcs_epcs_control_port_readyfordata),
      .reset_n       (epcs_epcs_control_port_reset_n),
      .sce           (sce_from_the_epcs),
      .sdo           (sdo_from_the_epcs),
      .write_n       (epcs_epcs_control_port_write_n),
      .writedata     (epcs_epcs_control_port_writedata)
    );

  jtag_uart_avalon_jtag_slave_arbitrator the_jtag_uart_avalon_jtag_slave
    (
      .clk                                                           (clk),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_waitrequest                                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .jtag_uart_avalon_jtag_slave_address                           (jtag_uart_avalon_jtag_slave_address),
      .jtag_uart_avalon_jtag_slave_chipselect                        (jtag_uart_avalon_jtag_slave_chipselect),
      .jtag_uart_avalon_jtag_slave_dataavailable                     (jtag_uart_avalon_jtag_slave_dataavailable),
      .jtag_uart_avalon_jtag_slave_dataavailable_from_sa             (jtag_uart_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_avalon_jtag_slave_irq                               (jtag_uart_avalon_jtag_slave_irq),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_read_n                            (jtag_uart_avalon_jtag_slave_read_n),
      .jtag_uart_avalon_jtag_slave_readdata                          (jtag_uart_avalon_jtag_slave_readdata),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_readyfordata                      (jtag_uart_avalon_jtag_slave_readyfordata),
      .jtag_uart_avalon_jtag_slave_readyfordata_from_sa              (jtag_uart_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_avalon_jtag_slave_reset_n                           (jtag_uart_avalon_jtag_slave_reset_n),
      .jtag_uart_avalon_jtag_slave_waitrequest                       (jtag_uart_avalon_jtag_slave_waitrequest),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_avalon_jtag_slave_write_n                           (jtag_uart_avalon_jtag_slave_write_n),
      .jtag_uart_avalon_jtag_slave_writedata                         (jtag_uart_avalon_jtag_slave_writedata),
      .reset_n                                                       (clk_reset_n)
    );

  jtag_uart the_jtag_uart
    (
      .av_address     (jtag_uart_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_avalon_jtag_slave_writedata),
      .clk            (clk),
      .dataavailable  (jtag_uart_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_avalon_jtag_slave_reset_n)
    );

  led_s1_arbitrator the_led_s1
    (
      .clk                                      (clk),
      .cpu_data_master_address_to_slave         (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_led_s1           (cpu_data_master_granted_led_s1),
      .cpu_data_master_qualified_request_led_s1 (cpu_data_master_qualified_request_led_s1),
      .cpu_data_master_read                     (cpu_data_master_read),
      .cpu_data_master_read_data_valid_led_s1   (cpu_data_master_read_data_valid_led_s1),
      .cpu_data_master_requests_led_s1          (cpu_data_master_requests_led_s1),
      .cpu_data_master_waitrequest              (cpu_data_master_waitrequest),
      .cpu_data_master_write                    (cpu_data_master_write),
      .cpu_data_master_writedata                (cpu_data_master_writedata),
      .d1_led_s1_end_xfer                       (d1_led_s1_end_xfer),
      .led_s1_address                           (led_s1_address),
      .led_s1_chipselect                        (led_s1_chipselect),
      .led_s1_readdata                          (led_s1_readdata),
      .led_s1_readdata_from_sa                  (led_s1_readdata_from_sa),
      .led_s1_reset_n                           (led_s1_reset_n),
      .led_s1_write_n                           (led_s1_write_n),
      .led_s1_writedata                         (led_s1_writedata),
      .reset_n                                  (clk_reset_n)
    );

  led the_led
    (
      .address    (led_s1_address),
      .chipselect (led_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_led),
      .readdata   (led_s1_readdata),
      .reset_n    (led_s1_reset_n),
      .write_n    (led_s1_write_n),
      .writedata  (led_s1_writedata)
    );

  rtc_data_s1_arbitrator the_rtc_data_s1
    (
      .clk                                           (clk),
      .cpu_data_master_address_to_slave              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_rtc_data_s1           (cpu_data_master_granted_rtc_data_s1),
      .cpu_data_master_qualified_request_rtc_data_s1 (cpu_data_master_qualified_request_rtc_data_s1),
      .cpu_data_master_read                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_rtc_data_s1   (cpu_data_master_read_data_valid_rtc_data_s1),
      .cpu_data_master_requests_rtc_data_s1          (cpu_data_master_requests_rtc_data_s1),
      .cpu_data_master_waitrequest                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                         (cpu_data_master_write),
      .cpu_data_master_writedata                     (cpu_data_master_writedata),
      .d1_rtc_data_s1_end_xfer                       (d1_rtc_data_s1_end_xfer),
      .reset_n                                       (clk_reset_n),
      .rtc_data_s1_address                           (rtc_data_s1_address),
      .rtc_data_s1_chipselect                        (rtc_data_s1_chipselect),
      .rtc_data_s1_readdata                          (rtc_data_s1_readdata),
      .rtc_data_s1_readdata_from_sa                  (rtc_data_s1_readdata_from_sa),
      .rtc_data_s1_reset_n                           (rtc_data_s1_reset_n),
      .rtc_data_s1_write_n                           (rtc_data_s1_write_n),
      .rtc_data_s1_writedata                         (rtc_data_s1_writedata)
    );

  rtc_data the_rtc_data
    (
      .address    (rtc_data_s1_address),
      .bidir_port (bidir_port_to_and_from_the_rtc_data),
      .chipselect (rtc_data_s1_chipselect),
      .clk        (clk),
      .readdata   (rtc_data_s1_readdata),
      .reset_n    (rtc_data_s1_reset_n),
      .write_n    (rtc_data_s1_write_n),
      .writedata  (rtc_data_s1_writedata)
    );

  rtc_rst_n_s1_arbitrator the_rtc_rst_n_s1
    (
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_rtc_rst_n_s1           (cpu_data_master_granted_rtc_rst_n_s1),
      .cpu_data_master_qualified_request_rtc_rst_n_s1 (cpu_data_master_qualified_request_rtc_rst_n_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_rtc_rst_n_s1   (cpu_data_master_read_data_valid_rtc_rst_n_s1),
      .cpu_data_master_requests_rtc_rst_n_s1          (cpu_data_master_requests_rtc_rst_n_s1),
      .cpu_data_master_waitrequest                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                          (cpu_data_master_write),
      .cpu_data_master_writedata                      (cpu_data_master_writedata),
      .d1_rtc_rst_n_s1_end_xfer                       (d1_rtc_rst_n_s1_end_xfer),
      .reset_n                                        (clk_reset_n),
      .rtc_rst_n_s1_address                           (rtc_rst_n_s1_address),
      .rtc_rst_n_s1_chipselect                        (rtc_rst_n_s1_chipselect),
      .rtc_rst_n_s1_readdata                          (rtc_rst_n_s1_readdata),
      .rtc_rst_n_s1_readdata_from_sa                  (rtc_rst_n_s1_readdata_from_sa),
      .rtc_rst_n_s1_reset_n                           (rtc_rst_n_s1_reset_n),
      .rtc_rst_n_s1_write_n                           (rtc_rst_n_s1_write_n),
      .rtc_rst_n_s1_writedata                         (rtc_rst_n_s1_writedata)
    );

  rtc_rst_n the_rtc_rst_n
    (
      .address    (rtc_rst_n_s1_address),
      .chipselect (rtc_rst_n_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_rtc_rst_n),
      .readdata   (rtc_rst_n_s1_readdata),
      .reset_n    (rtc_rst_n_s1_reset_n),
      .write_n    (rtc_rst_n_s1_write_n),
      .writedata  (rtc_rst_n_s1_writedata)
    );

  rtc_sclk_s1_arbitrator the_rtc_sclk_s1
    (
      .clk                                           (clk),
      .cpu_data_master_address_to_slave              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_rtc_sclk_s1           (cpu_data_master_granted_rtc_sclk_s1),
      .cpu_data_master_qualified_request_rtc_sclk_s1 (cpu_data_master_qualified_request_rtc_sclk_s1),
      .cpu_data_master_read                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_rtc_sclk_s1   (cpu_data_master_read_data_valid_rtc_sclk_s1),
      .cpu_data_master_requests_rtc_sclk_s1          (cpu_data_master_requests_rtc_sclk_s1),
      .cpu_data_master_waitrequest                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                         (cpu_data_master_write),
      .cpu_data_master_writedata                     (cpu_data_master_writedata),
      .d1_rtc_sclk_s1_end_xfer                       (d1_rtc_sclk_s1_end_xfer),
      .reset_n                                       (clk_reset_n),
      .rtc_sclk_s1_address                           (rtc_sclk_s1_address),
      .rtc_sclk_s1_chipselect                        (rtc_sclk_s1_chipselect),
      .rtc_sclk_s1_readdata                          (rtc_sclk_s1_readdata),
      .rtc_sclk_s1_readdata_from_sa                  (rtc_sclk_s1_readdata_from_sa),
      .rtc_sclk_s1_reset_n                           (rtc_sclk_s1_reset_n),
      .rtc_sclk_s1_write_n                           (rtc_sclk_s1_write_n),
      .rtc_sclk_s1_writedata                         (rtc_sclk_s1_writedata)
    );

  rtc_sclk the_rtc_sclk
    (
      .address    (rtc_sclk_s1_address),
      .chipselect (rtc_sclk_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_rtc_sclk),
      .readdata   (rtc_sclk_s1_readdata),
      .reset_n    (rtc_sclk_s1_reset_n),
      .write_n    (rtc_sclk_s1_write_n),
      .writedata  (rtc_sclk_s1_writedata)
    );

  scl_s1_arbitrator the_scl_s1
    (
      .clk                                      (clk),
      .cpu_data_master_address_to_slave         (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_scl_s1           (cpu_data_master_granted_scl_s1),
      .cpu_data_master_qualified_request_scl_s1 (cpu_data_master_qualified_request_scl_s1),
      .cpu_data_master_read                     (cpu_data_master_read),
      .cpu_data_master_read_data_valid_scl_s1   (cpu_data_master_read_data_valid_scl_s1),
      .cpu_data_master_requests_scl_s1          (cpu_data_master_requests_scl_s1),
      .cpu_data_master_waitrequest              (cpu_data_master_waitrequest),
      .cpu_data_master_write                    (cpu_data_master_write),
      .cpu_data_master_writedata                (cpu_data_master_writedata),
      .d1_scl_s1_end_xfer                       (d1_scl_s1_end_xfer),
      .reset_n                                  (clk_reset_n),
      .scl_s1_address                           (scl_s1_address),
      .scl_s1_chipselect                        (scl_s1_chipselect),
      .scl_s1_readdata                          (scl_s1_readdata),
      .scl_s1_readdata_from_sa                  (scl_s1_readdata_from_sa),
      .scl_s1_reset_n                           (scl_s1_reset_n),
      .scl_s1_write_n                           (scl_s1_write_n),
      .scl_s1_writedata                         (scl_s1_writedata)
    );

  scl the_scl
    (
      .address    (scl_s1_address),
      .chipselect (scl_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_scl),
      .readdata   (scl_s1_readdata),
      .reset_n    (scl_s1_reset_n),
      .write_n    (scl_s1_write_n),
      .writedata  (scl_s1_writedata)
    );

  sda_s1_arbitrator the_sda_s1
    (
      .clk                                      (clk),
      .cpu_data_master_address_to_slave         (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sda_s1           (cpu_data_master_granted_sda_s1),
      .cpu_data_master_qualified_request_sda_s1 (cpu_data_master_qualified_request_sda_s1),
      .cpu_data_master_read                     (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sda_s1   (cpu_data_master_read_data_valid_sda_s1),
      .cpu_data_master_requests_sda_s1          (cpu_data_master_requests_sda_s1),
      .cpu_data_master_waitrequest              (cpu_data_master_waitrequest),
      .cpu_data_master_write                    (cpu_data_master_write),
      .cpu_data_master_writedata                (cpu_data_master_writedata),
      .d1_sda_s1_end_xfer                       (d1_sda_s1_end_xfer),
      .reset_n                                  (clk_reset_n),
      .sda_s1_address                           (sda_s1_address),
      .sda_s1_chipselect                        (sda_s1_chipselect),
      .sda_s1_readdata                          (sda_s1_readdata),
      .sda_s1_readdata_from_sa                  (sda_s1_readdata_from_sa),
      .sda_s1_reset_n                           (sda_s1_reset_n),
      .sda_s1_write_n                           (sda_s1_write_n),
      .sda_s1_writedata                         (sda_s1_writedata)
    );

  sda the_sda
    (
      .address    (sda_s1_address),
      .bidir_port (bidir_port_to_and_from_the_sda),
      .chipselect (sda_s1_chipselect),
      .clk        (clk),
      .readdata   (sda_s1_readdata),
      .reset_n    (sda_s1_reset_n),
      .write_n    (sda_s1_write_n),
      .writedata  (sda_s1_writedata)
    );

  sdram_s1_arbitrator the_sdram_s1
    (
      .clk                                                            (clk),
      .cpu_data_master_address_to_slave                               (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                     (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_s1                            (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                    (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                   (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_s1                               (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_no_byte_enables_and_last_term                  (cpu_data_master_no_byte_enables_and_last_term),
      .cpu_data_master_qualified_request_sdram_s1                     (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_read                                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_s1                       (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register        (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_sdram_s1                              (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_waitrequest                                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                                          (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                        (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                             (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_s1                        (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                         (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_s1              (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                    (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_s1                (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_sdram_s1                       (cpu_instruction_master_requests_sdram_s1),
      .d1_sdram_s1_end_xfer                                           (d1_sdram_s1_end_xfer),
      .reset_n                                                        (clk_reset_n),
      .sdram_s1_address                                               (sdram_s1_address),
      .sdram_s1_byteenable_n                                          (sdram_s1_byteenable_n),
      .sdram_s1_chipselect                                            (sdram_s1_chipselect),
      .sdram_s1_read_n                                                (sdram_s1_read_n),
      .sdram_s1_readdata                                              (sdram_s1_readdata),
      .sdram_s1_readdata_from_sa                                      (sdram_s1_readdata_from_sa),
      .sdram_s1_readdatavalid                                         (sdram_s1_readdatavalid),
      .sdram_s1_reset_n                                               (sdram_s1_reset_n),
      .sdram_s1_waitrequest                                           (sdram_s1_waitrequest),
      .sdram_s1_waitrequest_from_sa                                   (sdram_s1_waitrequest_from_sa),
      .sdram_s1_write_n                                               (sdram_s1_write_n),
      .sdram_s1_writedata                                             (sdram_s1_writedata)
    );

  sdram the_sdram
    (
      .az_addr        (sdram_s1_address),
      .az_be_n        (sdram_s1_byteenable_n),
      .az_cs          (sdram_s1_chipselect),
      .az_data        (sdram_s1_writedata),
      .az_rd_n        (sdram_s1_read_n),
      .az_wr_n        (sdram_s1_write_n),
      .clk            (clk),
      .reset_n        (sdram_s1_reset_n),
      .za_data        (sdram_s1_readdata),
      .za_valid       (sdram_s1_readdatavalid),
      .za_waitrequest (sdram_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram),
      .zs_ba          (zs_ba_from_the_sdram),
      .zs_cas_n       (zs_cas_n_from_the_sdram),
      .zs_cke         (zs_cke_from_the_sdram),
      .zs_cs_n        (zs_cs_n_from_the_sdram),
      .zs_dq          (zs_dq_to_and_from_the_sdram),
      .zs_dqm         (zs_dqm_from_the_sdram),
      .zs_ras_n       (zs_ras_n_from_the_sdram),
      .zs_we_n        (zs_we_n_from_the_sdram)
    );

  sel_s1_arbitrator the_sel_s1
    (
      .clk                                      (clk),
      .cpu_data_master_address_to_slave         (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sel_s1           (cpu_data_master_granted_sel_s1),
      .cpu_data_master_qualified_request_sel_s1 (cpu_data_master_qualified_request_sel_s1),
      .cpu_data_master_read                     (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sel_s1   (cpu_data_master_read_data_valid_sel_s1),
      .cpu_data_master_requests_sel_s1          (cpu_data_master_requests_sel_s1),
      .cpu_data_master_waitrequest              (cpu_data_master_waitrequest),
      .cpu_data_master_write                    (cpu_data_master_write),
      .cpu_data_master_writedata                (cpu_data_master_writedata),
      .d1_sel_s1_end_xfer                       (d1_sel_s1_end_xfer),
      .reset_n                                  (clk_reset_n),
      .sel_s1_address                           (sel_s1_address),
      .sel_s1_chipselect                        (sel_s1_chipselect),
      .sel_s1_readdata                          (sel_s1_readdata),
      .sel_s1_readdata_from_sa                  (sel_s1_readdata_from_sa),
      .sel_s1_reset_n                           (sel_s1_reset_n),
      .sel_s1_write_n                           (sel_s1_write_n),
      .sel_s1_writedata                         (sel_s1_writedata)
    );

  sel the_sel
    (
      .address    (sel_s1_address),
      .chipselect (sel_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_sel),
      .readdata   (sel_s1_readdata),
      .reset_n    (sel_s1_reset_n),
      .write_n    (sel_s1_write_n),
      .writedata  (sel_s1_writedata)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                   (clk),
      .cpu_data_master_address_to_slave                      (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sysid_control_slave           (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_qualified_request_sysid_control_slave (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_read                                  (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sysid_control_slave   (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_requests_sysid_control_slave          (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_write                                 (cpu_data_master_write),
      .d1_sysid_control_slave_end_xfer                       (d1_sysid_control_slave_end_xfer),
      .reset_n                                               (clk_reset_n),
      .sysid_control_slave_address                           (sysid_control_slave_address),
      .sysid_control_slave_readdata                          (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                  (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                           (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  timer_s1_arbitrator the_timer_s1
    (
      .clk                                        (clk),
      .cpu_data_master_address_to_slave           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_timer_s1           (cpu_data_master_granted_timer_s1),
      .cpu_data_master_qualified_request_timer_s1 (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_read                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_timer_s1   (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_requests_timer_s1          (cpu_data_master_requests_timer_s1),
      .cpu_data_master_waitrequest                (cpu_data_master_waitrequest),
      .cpu_data_master_write                      (cpu_data_master_write),
      .cpu_data_master_writedata                  (cpu_data_master_writedata),
      .d1_timer_s1_end_xfer                       (d1_timer_s1_end_xfer),
      .reset_n                                    (clk_reset_n),
      .timer_s1_address                           (timer_s1_address),
      .timer_s1_chipselect                        (timer_s1_chipselect),
      .timer_s1_irq                               (timer_s1_irq),
      .timer_s1_irq_from_sa                       (timer_s1_irq_from_sa),
      .timer_s1_readdata                          (timer_s1_readdata),
      .timer_s1_readdata_from_sa                  (timer_s1_readdata_from_sa),
      .timer_s1_reset_n                           (timer_s1_reset_n),
      .timer_s1_write_n                           (timer_s1_write_n),
      .timer_s1_writedata                         (timer_s1_writedata)
    );

  timer the_timer
    (
      .address    (timer_s1_address),
      .chipselect (timer_s1_chipselect),
      .clk        (clk),
      .irq        (timer_s1_irq),
      .readdata   (timer_s1_readdata),
      .reset_n    (timer_s1_reset_n),
      .write_n    (timer_s1_write_n),
      .writedata  (timer_s1_writedata)
    );

  uart_s1_arbitrator the_uart_s1
    (
      .clk                                       (clk),
      .cpu_data_master_address_to_slave          (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_uart_s1           (cpu_data_master_granted_uart_s1),
      .cpu_data_master_qualified_request_uart_s1 (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                      (cpu_data_master_read),
      .cpu_data_master_read_data_valid_uart_s1   (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_requests_uart_s1          (cpu_data_master_requests_uart_s1),
      .cpu_data_master_write                     (cpu_data_master_write),
      .cpu_data_master_writedata                 (cpu_data_master_writedata),
      .d1_uart_s1_end_xfer                       (d1_uart_s1_end_xfer),
      .reset_n                                   (clk_reset_n),
      .uart_s1_address                           (uart_s1_address),
      .uart_s1_begintransfer                     (uart_s1_begintransfer),
      .uart_s1_chipselect                        (uart_s1_chipselect),
      .uart_s1_dataavailable                     (uart_s1_dataavailable),
      .uart_s1_dataavailable_from_sa             (uart_s1_dataavailable_from_sa),
      .uart_s1_irq                               (uart_s1_irq),
      .uart_s1_irq_from_sa                       (uart_s1_irq_from_sa),
      .uart_s1_read_n                            (uart_s1_read_n),
      .uart_s1_readdata                          (uart_s1_readdata),
      .uart_s1_readdata_from_sa                  (uart_s1_readdata_from_sa),
      .uart_s1_readyfordata                      (uart_s1_readyfordata),
      .uart_s1_readyfordata_from_sa              (uart_s1_readyfordata_from_sa),
      .uart_s1_reset_n                           (uart_s1_reset_n),
      .uart_s1_write_n                           (uart_s1_write_n),
      .uart_s1_writedata                         (uart_s1_writedata)
    );

  uart the_uart
    (
      .address       (uart_s1_address),
      .begintransfer (uart_s1_begintransfer),
      .chipselect    (uart_s1_chipselect),
      .clk           (clk),
      .dataavailable (uart_s1_dataavailable),
      .irq           (uart_s1_irq),
      .read_n        (uart_s1_read_n),
      .readdata      (uart_s1_readdata),
      .readyfordata  (uart_s1_readyfordata),
      .reset_n       (uart_s1_reset_n),
      .rxd           (rxd_to_the_uart),
      .txd           (txd_from_the_uart),
      .write_n       (uart_s1_write_n),
      .writedata     (uart_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  kernel_reset_clk_domain_synch_module kernel_reset_clk_domain_synch
    (
      .clk      (clk),
      .data_in  (1'b1),
      .data_out (clk_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_jtag_debug_module_resetrequest_from_sa |
    cpu_jtag_debug_module_resetrequest_from_sa);

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/11.0/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/11.0/quartus/eda/sim_lib/220model.v"
`include "c:/altera/11.0/quartus/eda/sim_lib/sgate.v"
`include "rtc_sclk.v"
`include "uart.v"
`include "led.v"
`include "sdram.v"
`include "sysid.v"
`include "timer.v"
`include "rtc_data.v"
`include "rtc_rst_n.v"
`include "epcs.v"
`include "sda.v"
`include "jtag_uart.v"
`include "sel.v"
`include "buzzer.v"
`include "cpu_test_bench.v"
`include "cpu_mult_cell.v"
`include "cpu_oci_test_bench.v"
`include "cpu_jtag_debug_module_tck.v"
`include "cpu_jtag_debug_module_sysclk.v"
`include "cpu_jtag_debug_module_wrapper.v"
`include "cpu.v"
`include "KEY3.v"
`include "KEY2.v"
`include "scl.v"
`include "KEY4.v"
`include "dig.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             bidir_port_to_and_from_the_rtc_data;
  wire             bidir_port_to_and_from_the_sda;
  reg              clk;
  wire             data0_to_the_epcs;
  wire             dclk_from_the_epcs;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             in_port_to_the_KEY2;
  wire             in_port_to_the_KEY3;
  wire             in_port_to_the_KEY4;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             out_port_from_the_buzzer;
  wire    [  7: 0] out_port_from_the_dig;
  wire    [  3: 0] out_port_from_the_led;
  wire             out_port_from_the_rtc_rst_n;
  wire             out_port_from_the_rtc_sclk;
  wire             out_port_from_the_scl;
  wire    [  5: 0] out_port_from_the_sel;
  reg              reset_n;
  wire             rxd_to_the_uart;
  wire             sce_from_the_epcs;
  wire             sdo_from_the_epcs;
  wire             sysid_control_slave_clock;
  wire             txd_from_the_uart;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  kernel DUT
    (
      .bidir_port_to_and_from_the_rtc_data (bidir_port_to_and_from_the_rtc_data),
      .bidir_port_to_and_from_the_sda      (bidir_port_to_and_from_the_sda),
      .clk                                 (clk),
      .data0_to_the_epcs                   (data0_to_the_epcs),
      .dclk_from_the_epcs                  (dclk_from_the_epcs),
      .in_port_to_the_KEY2                 (in_port_to_the_KEY2),
      .in_port_to_the_KEY3                 (in_port_to_the_KEY3),
      .in_port_to_the_KEY4                 (in_port_to_the_KEY4),
      .out_port_from_the_buzzer            (out_port_from_the_buzzer),
      .out_port_from_the_dig               (out_port_from_the_dig),
      .out_port_from_the_led               (out_port_from_the_led),
      .out_port_from_the_rtc_rst_n         (out_port_from_the_rtc_rst_n),
      .out_port_from_the_rtc_sclk          (out_port_from_the_rtc_sclk),
      .out_port_from_the_scl               (out_port_from_the_scl),
      .out_port_from_the_sel               (out_port_from_the_sel),
      .reset_n                             (reset_n),
      .rxd_to_the_uart                     (rxd_to_the_uart),
      .sce_from_the_epcs                   (sce_from_the_epcs),
      .sdo_from_the_epcs                   (sdo_from_the_epcs),
      .txd_from_the_uart                   (txd_from_the_uart),
      .zs_addr_from_the_sdram              (zs_addr_from_the_sdram),
      .zs_ba_from_the_sdram                (zs_ba_from_the_sdram),
      .zs_cas_n_from_the_sdram             (zs_cas_n_from_the_sdram),
      .zs_cke_from_the_sdram               (zs_cke_from_the_sdram),
      .zs_cs_n_from_the_sdram              (zs_cs_n_from_the_sdram),
      .zs_dq_to_and_from_the_sdram         (zs_dq_to_and_from_the_sdram),
      .zs_dqm_from_the_sdram               (zs_dqm_from_the_sdram),
      .zs_ras_n_from_the_sdram             (zs_ras_n_from_the_sdram),
      .zs_we_n_from_the_sdram              (zs_we_n_from_the_sdram)
    );

  initial
    clk = 1'b0;
  always
    #5 clk <= ~clk;
  
  initial 
    begin
      reset_n <= 0;
      #100 reset_n <= 1;
    end

endmodule


//synthesis translate_on