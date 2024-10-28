---
layout: post
title:  "Address Tagging"
date:   2024-10-27 20:36:00 +0000
categories: [Microarchitecture, Systems, Compilers, Learnings]
---

# Address Tagging

Today I learned about "Address Tagging".
Intel refers to this as Linear Address Masking (LAM).
ARM refers to it as Top Byte Ignore (TBI).
But in either case it roughly does the same thing.

## Overview

At a super high level, modern 64-bit architectures don't *really* use 64-bits for the (virtual) memory address.
4-level paging based systems only use 48-bits and 5-level use 52-bits.
That still leaves 2^48 or 2^52 bytes of addressable memory, which is still quite a lot.

This also leaves a handful of bits (16 or 12) in the upper bits of the address that are not used.

Usually, an operating system will fill these bits with either all 0s (kernelspace) or all 1s (userspace).
But, with address tagging, the application can use these bits for other purposes.

What happens is that the first byte (8-bits) of the address will be automatically ignored by the hardware when this feature is enabled.

The remaining bits are still used by the OS to determine whether the address is a kernel or userspace address.

## See Also

- [Linux 6.12-rc5 Disabling Intel's Linear Address Masking "LAM" Due To Security Concerns](https://www.phoronix.com/news/Linux-Disabling-Intel-LAM)
- [Top Byte Ignore For Fun and Memory Savings](https://www.linaro.org/blog/top-byte-ignore-for-fun-and-memory-savings/)
- [Hardware-assisted AddressSanitizer Design Documentation](https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html)
- [Memory Tagging and how it improves C/C++ memory safety](https://arxiv.org/pdf/1802.09517)