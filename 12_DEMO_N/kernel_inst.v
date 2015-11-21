  //Example instantiation for system 'kernel'
  kernel kernel_inst
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

