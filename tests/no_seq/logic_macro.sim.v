/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier: ISC
 */

(* whitebox *)
module LOGIC_MACRO (QST, QDS, TBS, TAB, TSL, TA1, TA2, TB1, TB2, BAB, BSL, BA1, BA2, BB1, BB2, QDI, QEN, QCK, QRT, F1, F2, FS, TZ, CZ, QZ, FZ);

    // =============== C_FRAG ===============

    (* NO_SEQ *)
    input  wire TBS;
    (* NO_SEQ *)
    input  wire TAB;
    (* NO_SEQ *)
    input  wire TSL;
    (* NO_SEQ *)
    input  wire TA1;
    (* NO_SEQ *)
    input  wire TA2;
    (* NO_SEQ *)
    input  wire TB1;
    (* NO_SEQ *)
    input  wire TB2;
    (* NO_SEQ *)
    input  wire BAB;
    (* NO_SEQ *)
    input  wire BSL;
    (* NO_SEQ *)
    input  wire BA1;
    (* NO_SEQ *)
    input  wire BA2;
    (* NO_SEQ *)
    input  wire BB1;
    (* NO_SEQ *)
    input  wire BB2;

    (* DELAY_CONST_TAB="1e-10" *)
    (* DELAY_CONST_TSL="1e-10" *)
    (* DELAY_CONST_TA1="1e-10" *)
    (* DELAY_CONST_TA2="1e-10" *)
    (* DELAY_CONST_TB1="1e-10" *)
    (* DELAY_CONST_TB2="1e-10" *)
    output wire TZ;

    (* DELAY_CONST_TBS="1e-10" *)
    (* DELAY_CONST_TAB="1e-10" *)
    (* DELAY_CONST_TSL="1e-10" *)
    (* DELAY_CONST_TA1="1e-10" *)
    (* DELAY_CONST_TA2="1e-10" *)
    (* DELAY_CONST_TB1="1e-10" *)
    (* DELAY_CONST_TB2="1e-10" *)
    (* DELAY_CONST_BAB="1e-10" *)
    (* DELAY_CONST_BSL="1e-10" *)
    (* DELAY_CONST_BA1="1e-10" *)
    (* DELAY_CONST_BA2="1e-10" *)
    (* DELAY_CONST_BB1="1e-10" *)
    (* DELAY_CONST_BB2="1e-10" *)
    output wire CZ;

    // Control parameters
    parameter [0:0] TAS1 = 1'b0;
    parameter [0:0] TAS2 = 1'b0;
    parameter [0:0] TBS1 = 1'b0;
    parameter [0:0] TBS2 = 1'b0;

    parameter [0:0] BAS1 = 1'b0;
    parameter [0:0] BAS2 = 1'b0;
    parameter [0:0] BBS1 = 1'b0;
    parameter [0:0] BBS2 = 1'b0;

    // Input routing inverters
    wire TAP1 = (TAS1) ? ~TA1 : TA1;
    wire TAP2 = (TAS2) ? ~TA2 : TA2;
    wire TBP1 = (TBS1) ? ~TB1 : TB1;
    wire TBP2 = (TBS2) ? ~TB2 : TB2;

    wire BAP1 = (BAS1) ? ~BA1 : BA1;
    wire BAP2 = (BAS2) ? ~BA2 : BA2;
    wire BBP1 = (BBS1) ? ~BB1 : BB1;
    wire BBP2 = (BBS2) ? ~BB2 : BB2;

    // 1st mux stage
    wire TAI = TSL ? TAP2 : TAP1;
    wire TBI = TSL ? TBP2 : TBP1;
    
    wire BAI = BSL ? BAP2 : BAP1;
    wire BBI = BSL ? BBP2 : BBP1;

    // 2nd mux stage
    wire TZI = TAB ? TBI : TAI;
    wire BZI = BAB ? BBI : BAI;

    // 3rd mux stage
    wire CZI = TBS ? BZI : TZI;

    // Output
    assign TZ = TZI;
    assign CZ = CZI;

    // =============== Q_FRAG ===============

    (* CLOCK *)
    input  wire QCK;
    
    // Cannot model timing, VPR currently does not support async SET/RESET
    (* SETUP="QCK 1e-10" *)
    (* NO_COMB *)
    input  wire QST;

    // Cannot model timing, VPR currently does not support async SET/RESET
    (* SETUP="QCK 1e-10" *)
    (* NO_COMB *)
    input  wire QRT;

    (* SETUP="QCK 1e-10" *)
    (* HOLD="QCK 1e-10" *)
    (* NO_COMB *)
    input  wire QEN;

    (* SETUP="QCK 1e-10" *)
    (* HOLD="QCK 1e-10" *)
    (* NO_COMB *)
    input  wire QDI;

    (* SETUP="QCK 1e-10" *)
    (* HOLD="QCK 1e-10" *)
    (* NO_COMB *)
    input  wire QDS;

    (* CLK_TO_Q = "QCK 1e-10" *)
    (* DELAY_CONST_TBS="1e-10" *)
    (* DELAY_CONST_TAB="1e-10" *)
    (* DELAY_CONST_TSL="1e-10" *)
    (* DELAY_CONST_TA1="1e-10" *)
    (* DELAY_CONST_TA2="1e-10" *)
    (* DELAY_CONST_TB1="1e-10" *)
    (* DELAY_CONST_TB2="1e-10" *)
    (* DELAY_CONST_BAB="1e-10" *)
    (* DELAY_CONST_BSL="1e-10" *)
    (* DELAY_CONST_BA1="1e-10" *)
    (* DELAY_CONST_BA2="1e-10" *)
    (* DELAY_CONST_BB1="1e-10" *)
    (* DELAY_CONST_BB2="1e-10" *)
    (* SETUP="QCK 1e-10" *)
    (* HOLD="QCK 1e-10" *)
    output reg  QZ;
    
    // Parameters
    parameter [0:0] Z_QCKS = 1'b1;

    // The QZI-mux
    wire QZI = (QDS) ? QDI : CZI;
        
    // The flip-flop
    initial QZ <= 1'b0;
    always @(posedge QCK or posedge QST or posedge QRT) begin
        if (QST)
            QZ <= 1'b1;
        else if (QRT)
            QZ <= 1'b0;
        else if (QEN)
            QZ <= QZI;
    end

    // =============== F_FRAG ===============

    input  wire F1;
    input  wire F2;
    input  wire FS;

    (* DELAY_CONST_F1="1e-10" *)
    (* DELAY_CONST_F2="1e-10" *)
    (* DELAY_CONST_FS="1e-10" *)
    output wire FZ;

    // The F-mux
    assign FZ = FS ? F2 : F1;

endmodule
