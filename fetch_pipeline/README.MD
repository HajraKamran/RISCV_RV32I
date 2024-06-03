# Fetch Stage Pipeline

## Overview

This project implements the Fetch Stage Pipeline of a RISC-V RV32I processor in Verilog. The Fetch Stage is responsible for fetching instructions from memory and preparing them for the subsequent stages of the pipeline.

## Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Contributing](#contributing)


## Introduction

This repository contains the Verilog code for the Fetch Stage Pipeline of a RISC-V RV32I processor. The Fetch Stage is the first stage in the pipeline, where instructions are fetched from memory based on the program counter (PC) and prepared for decoding and execution.

## Project Structure

The project is organized as follows:

- `src/`: Contains the Verilog source files for the Fetch Stage Pipeline.
- `tb/`: Contains the testbench files for simulation and verification.
- `flist`: Filelist containing paths to all Verilog source files.
- `README.md`: This README file.

## Getting Started

To get started with this project, clone the repository to your local machine:

```bash
git clone git@github.com:HajraKamran/RISCV_RV32I.git
```
## Contributing

Contributions to this project are welcome. To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch 
3. Make your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to the branch (`git push origin master/main).
6. Create a new Pull Request.

