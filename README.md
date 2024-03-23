# RISC-V Single Cycle Processor

Welcome to the RISC-V Single Cycle Processor repository!

This repository contains the implementation of a single cycle processor based on the RISC-V instruction set architecture. The single cycle processor design provides a simple yet effective model for understanding the fundamental concepts of processor architecture and design.

## Features

- **RISC-V ISA**: Implements the RISC-V instruction set architecture, providing a standard interface for software development.
- **Single Cycle Execution**: Each instruction is executed in a single clock cycle, simplifying the control logic and enabling a straightforward implementation.
- **Verilog Implementation**: The processor design is implemented using Verilog HDL, making it easy to simulate and synthesize using industry-standard EDA tools.

## Getting Started

To get started with the RISC-V Single Cycle Processor, follow these steps:

1. **Clone the Repository**: Clone this repository to your local machine using:

    ```
    git clone https://github.com/HajraKamran/riscv-single-cycle-processor.git
    ```

2. **Simulate the Design**: Simulate the processor design using a Verilog simulator such as ModelSim or Icarus Verilog. You can find the testbench files in the `sim` directory.

3. **Synthesize the Design**: Synthesize the Verilog code using synthesis tools like Synopsys Design Compiler or Xilinx Vivado for FPGA implementation.

4. **Explore the Code**: Dive into the Verilog source code to understand the implementation details of the RISC-V single cycle processor. Feel free to modify and experiment with the design.

## Directory Structure

The repository is organized as follows:

- **`rtl`**: Contains the Verilog source files for the RISC-V single cycle processor implementation.
- **`sim`**: Contains the testbench files and simulation scripts for verifying the processor design.
- **`docs`**: Contains documentation files related to the processor design.

## Contributing

Contributions to the RISC-V Single Cycle Processor project are welcome! If you have ideas for improvements, bug fixes, or new features, feel free to open an issue or submit a pull request. Make sure to follow the contribution guidelines outlined in the `CONTRIBUTING.md` file.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

We would like to thank the RISC-V community for developing and maintaining the RISC-V instruction set architecture, which serves as the foundation for this project.

---

Feel free to customize this README according to your specific project details and requirements. Happy coding! 🚀

