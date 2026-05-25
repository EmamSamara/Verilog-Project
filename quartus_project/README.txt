============================================================
  ENCS3310 — Fast Multiplier Project
  Student ID: 1220022  |  Gate delays: ID digit = 2
============================================================

FILES IN THIS PROJECT
─────────────────────
gate_lib.v            → Basic gate primitives (AND, OR, XOR, INV, etc.)
dff.v                 → D Flip-Flop used by RCA multiplier
dff_cla.v             → D Flip-Flop used by CLA multiplier
full_adder.v          → 1-bit Full Adder (structural)
rca_4bit.v            → 4-bit Ripple Carry Adder
cla_4bit.v            → 4-bit Carry Look-Ahead Adder
multiplier_rca.v      → STAGE 1: 4x8 Multiplier using RCA
multiplier_cla.v      → STAGE 2: 4x8 Multiplier using CLA
full_adder_buggy.v    → Full adder with intentional XNOR bug
rca_4bit_buggy.v      → RCA built from buggy full adder
multiplier_rca_buggy.v→ Buggy multiplier (for error demo)
tb_multiplier_rca.v   → Testbench: 4096 cases for RCA
tb_multiplier_cla.v   → Testbench: 4096 cases for CLA
tb_error_detection.v  → Testbench: detects bug in buggy design

HOW TO OPEN IN QUARTUS
────────────────────────
1. Open Quartus Prime
2. File → Open Project → select multiplier_project.qpf
3. All files are already added in correct order

HOW TO SIMULATE (ModelSim inside Quartus)
──────────────────────────────────────────
1. Processing → Start → Start Analysis & Elaboration
2. Tools → Run Simulation Tool → RTL Simulation
3. In ModelSim: select tb_multiplier_rca or tb_multiplier_cla
4. Run → Run All

HOW TO SIMULATE (Icarus Verilog — command line)
─────────────────────────────────────────────────
# Stage 1 - RCA (all 4096 cases)
iverilog -o tb_rca tb_multiplier_rca.v && vvp tb_rca

# Stage 2 - CLA (all 4096 cases)
iverilog -o tb_cla tb_multiplier_cla.v && vvp tb_cla

# Error detection demo
iverilog -o tb_err tb_error_detection.v && vvp tb_err

GATE DELAYS (Student ID ends in 2)
────────────────────────────────────
INV=3ns  NAND=3ns  NOR=4ns  AND=5ns  OR=5ns  XOR=6ns  XNOR=7ns

MAX LATENCY & CLOCK FREQUENCY
───────────────────────────────
RCA Multiplier: ~251 ns  →  Max Fclk ≈ 3.98 MHz
CLA Multiplier: ~143 ns  →  Max Fclk ≈ 6.99 MHz

INTENTIONAL ERROR (for report)
────────────────────────────────
File: full_adder_buggy.v
Bug:  XNOR2 used instead of AND2 in carry computation
      Correct:  cout = (A AND B) OR ...
      Buggy:    cout = (A XNOR B) OR ...
Effect: Wrong carry when A != B → wrong multiplication results
Detection: tb_error_detection.v catches this automatically
============================================================
