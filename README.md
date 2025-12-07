🐦 Hummingbird Lightweight Cipher – Final Project (VHDL)
By:

    Abidzar Rabbani Khatib Harahap

    Naufal Rafif Adighama

    Ziyadzharif Alfarabi Kurniawan

    Fahreza Arsya Maulana

🚨 Important Notice
The main project is NOT in the main branch.
All the final Vivado files, working VHDL modules, and the complete project folder are located in:

    👉 hummingbird_new branch

Please switch to this branch before opening the Vivado project.

📌 Project Overview

This repository contains a modular VHDL implementation of a simplified Hummingbird lightweight cipher.
The focus of this project is on digital architecture, module integration, and control/datapath separation, not full cryptographic correctness.

The system is built using four major components:

    TopLevel – Connects all modules into one system

    ControlCore – Finite State Machine controlling rounds, registers, and LFSR
    
    RoundDatapath – Performs the round transformations

    StateCore – Holds internal state: registers RS1–RS4, LFSR, key input

A testbench (tb_TopLevel.vhd) is included to simulate and observe the behavior of the full design.
    
     ┌──────────────────────────────────────────────────────────────┐
     │                          TopLevel                            │
     │                                                              │
     │ Inputs: clk, rst, start, mode_enc, key_256, lfsr_seed        │
     │ Output: ciphertext, done                                     │
     │                                                              │
     │   ┌──────────────────────┐        ┌──────────────────────┐   │
     │   │     ControlCore      │        │    RoundDatapath     │   │
     │   └──────────────────────┘        └──────────────────────┘   │
     │             ▲                           ▲                    │
     │             │                           │                    │
     │   ┌──────────────────────┐        ┌──────────────────────┐   │
     │   │      StateCore       │◄───────┤    RoundDatapath     │   │
     │   └──────────────────────┘        └──────────────────────┘   │
     │                                                              │
     └──────────────────────────────────────────────────────────────┘

The system includes:

      -A 256-bit key input
      -A 16-bit LFSR
      -Four 16-bit internal registers (RS1–RS4)
      -A round counter & control FSM
      -A simple datapath for round operations

Here is the Project Structure:

  /hummingbird_new
  
      └── project_finpro_hummingbird/
 
            ├── TopLevel.vhd
      
            ├── ControlCore.vhd
      
             ├── StateCore.vhd
      
            ├── RoundDatapath.vhd
      
            ├── LFSR16.vhd  (if included)
      
            ├── tb_TopLevel.vhd
      
            └── project files for Vivado
      
This project demonstrates:

    Building a structured hardware design

    Implementing a control/datapath cipher architecture

    Using registers and LFSR for state tracking

    Creating a multi-module VHDL project

    Running simulations in Vivado

    Understanding lightweight crypto hardware concepts

It is educational and ideal for understanding how real lightweight ciphers are implemented on constrained hardware like:

      IoT sensors
      
      Smart cards
      
      RFID tags
      
      Low-power embedded devices

This project is for educational use only under university coursework.
Not intended for production cryptographic deployment.
