# Verilog Significand Multiply Circuit

## Description

This is a generic version of the logic to multiply two significands. It can be used with any of the IEEE 754 binary types: 16-, 32-, 64-, and 128-bits.

Code is explained in the video series [Building an FPU in Verilog](https://www.youtube.com/watch?v=rYkVdJnVJFQ&list=PLlO9sSrh8HrwcDHAtwec1ycV-m50nfUVs).
See the video *Building an FPU in Verilog: Building an 11-bit Multiply*.

This version of the code:
- Builds the second version of the multiply circuit. It relies on Verilog to generate adders for each of the partial products.
- Eliminates one addition operation from the previous version.

## Manifest

|   Filename   |                        Description                        |
|--------------|-----------------------------------------------------------|
| README.md | This file. |
| sigmul.v | Simple, generic multiply circuit |

## Copyright

:copyright: Chris Larsen, 2021
