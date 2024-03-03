---
title: valib
description: An abstraction over signal processing in Rust for reusable musical DSP algorithms
category: Projects
heroImage: ../../assets/images/banner.jpg
pubDate: 2024-03-03
tags: [Music, DSP, Rust, 'Open Source']
---

# [valib](https://github.com/solarliner/valib)

`valib` started from a reading of V. Zavalishin's book [The Art of VA Filter Design](https://www.discodsp.net/VAFilterDesign_2.1.2.pdf), and trying to implement the different filter structures found throughout that book, while trying to allow reusability as much as possible. As I worked on the project, I also started making small example plugins showcasing different features and implementations that were present in the library.

The library has grown now to provide implementation for oscillators, filters, oversampling, and boasts genericity over scalar types (and SIMD!). It has also made me dive deeper into DSP algorithm and their implementations.
