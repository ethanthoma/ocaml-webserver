# ZigMat (for now)

This matrix multiplication library is a high-performance implementation written in Zig. It utilizes block matrix multiplication, SIMD optimizations, and multithreading to achieve efficient matrix operations.

## Features

- **Block Matrix Multiplication**: Splits matrices into smaller blocks for improved cache utilization.
- **SIMD Optimizations**: Utilizes Single Instruction, Multiple Data (SIMD) operations for faster computation.
- **Multithreading Support**: Leverages threading for parallel computation, enhancing performance on multi-core processors.
- **Alignment Optimized**: Ensures data structures are cache-line aligned for efficient memory access.

## Notes

- Limited functions at the moment
- Only matmul is optimized at the moment
- Plan to add more operations using matrix tiling and thread pools
- Eventually add basic neural network functions

## Requirements

- Zig compiler (version 11.0 or newer recommended)

## Installation

You can install this library using the Zig package manager, ZON. Just add a "zigmat" dependency to your `build.zig.zon`.

## Usage

Please see `example/main.zig`. A snippet is below:

```zig
const zigmat = @import("zigmat");

var mat_A = zigmat.ones(f32, allocator, n, n);
defer mat_A.deinit();

var mat_B = zigmat.identity(f32, allocator, n, p);
defer mat_B.deinit();

const mat_C = try zigmat.Matrix(f32).matmul(allocator, mat_A, mat_B);
defer mat_C.deinit();
```

## Benchmarks

CPU: AMD Ryzen 7 5700 with Radeon Graphics

OP: matmul

Params: two 1024x1024 matrices

Result: average of 3.478e+01 ms over 100 trials
