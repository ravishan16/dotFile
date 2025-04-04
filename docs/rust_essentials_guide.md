# 🦀 Rust Essentials Guide

Rust is a modern systems programming language focused on safety, speed, and concurrency. This guide covers the absolute basics to get you started after installation.

## Installation (via rustup - Recommended)

The officially recommended way to install and manage Rust versions is using `rustup`, the Rust toolchain installer. The setup script `09_install_rust.sh` in this repository uses this method.

```bash
# Installs rustup, Rust compiler (rustc), package manager (cargo), etc.
# The '-y --no-modify-path' flags run non-interactively; remove them for interactive install.
curl --proto '=https' --tlsv1.2 -sSf [https://sh.rustup.rs](https://sh.rustup.rs) | sh -s -- -y --no-modify-path
```

After installation, you need to ensure Cargo's bin directory is in your shell's PATH. `rustup` typically adds this configuration to your shell profile (`.zshrc`, `.bash_profile`, etc.), but you might need to restart your shell or run the following command in your current session:

```bash
# Source the cargo environment script (if it exists)
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Alternatively, manually add to PATH (add this line to your .zshrc or equivalent)
# export PATH="$HOME/.cargo/bin:$PATH"
```
`rustup` makes it easy to update Rust (`rustup update`) and manage different toolchains (stable, beta, nightly) if needed.

Verify installation:
```bash
# Check if the commands are available and output their versions
rustc --version
cargo --version
```

If the commands are not found, double-check that `$HOME/.cargo/bin` is correctly added to your PATH and that you've restarted your terminal or sourced the relevant profile file.

## Cargo: The Rust Build Tool and Package Manager

Cargo handles many common tasks for Rust projects:

* Building your code (`cargo build`)
* Running your code (`cargo run`)
* Running tests (`cargo test`)
* Checking code without building (`cargo check`)
* Building documentation (`cargo doc`)
* Publishing libraries (`cargo publish`)
* Managing dependencies (via `Cargo.toml`)

### Creating a New Project

```bash
# Create a new binary (application) project
cargo new hello_world
cd hello_world

# Create a new library project
# cargo new my_library --lib
```

This creates a standard project structure:

```
hello_world/
├── Cargo.toml  # Manifest file (metadata, dependencies)
└── src/        # Source code directory
    └── main.rs # Main source file for binaries
```

### Building and Running (Cheatsheet)

* **`cargo check`**
    * Quickly check code for errors without full compilation.
    * `cargo check`
* **`cargo build`**
    * Compile project (debug build).
    * Output: `./target/debug/<project_name>`
    * `cargo build`
* **`cargo build --release`**
    * Compile project (optimized release build).
    * Output: `./target/release/<project_name>`
    * `cargo build --release`
* **`cargo run`**
    * Compile (if needed) and run project (debug build).
    * `cargo run`
    * Run release build: `cargo run --release`

### `Cargo.toml` - The Manifest File

This file describes your project (called a "crate" in Rust):

```toml
[package]
name = "hello_world" # Crate name
version = "0.1.0"    # Semantic version
edition = "2021"     # Rust edition (usually latest)

# See more keys and definitions at [https://doc.rust-lang.org/cargo/reference/manifest.html](https://doc.rust-lang.org/cargo/reference/manifest.html)

[dependencies]
# Add external libraries (crates) here
# Example: rand = "0.8.5"
```

## Rust Language Basics

### Variables and Mutability

Variables are immutable by default. Use `mut` to make them mutable.

```rust
fn main() {
    let x = 5; // Immutable
    // x = 6; // This would cause a compile error!

    let mut y = 10; // Mutable
    println!("Initial y: {}", y);
    y = 11;
    println!("Modified y: {}", y);

    // Constants (must have type annotation, always immutable)
    const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
    println!("Constant: {}", THREE_HOURS_IN_SECONDS);
}
```

### Basic Data Types

Rust is statically typed, but the compiler can often infer types.

* **Integers:** `i8`, `u8`, `i16`, `u16`, `i32`, `u32`, `i64`, `u64`, `i128`, `u128`, `isize`, `usize` (signed `i` / unsigned `u`, size depends on architecture for `isize`/`usize`).
  ```rust
  let guess: u32 = "42".parse().expect("Not a number!");
  let count = 100_000; // Use _ for readability
  ```
* **Floating-Point:** `f32`, `f64` (default).
  ```rust
  let pi = 3.14159; // f64 by default
  let temp: f32 = 98.6;
  ```
* **Booleans:** `bool` (`true` or `false`).
  ```rust
  let is_active = true;
  let has_permission: bool = false;
  ```
* **Characters:** `char` (single Unicode scalar value, use single quotes).
  ```rust
  let grade = 'A';
  let emoji = '🦀';
  ```
* **Tuples:** Fixed-size collection of potentially different types.
  ```rust
  let tup: (i32, f64, char) = (500, 6.4, 'z');
  let (x, y, z) = tup; // Destructuring
  println!("The value of y is: {}", y); // Access via destructuring
  println!("First element: {}", tup.0); // Access via index
  ```
* **Arrays:** Fixed-size collection of the *same* type. Stored on the stack.
  ```rust
  let numbers: [i32; 5] = [1, 2, 3, 4, 5];
  let first = numbers[0];
  // let invalid = numbers[10]; // Compile error or runtime panic!
  println!("First number: {}", first);
  ```

### Functions

Defined using the `fn` keyword. Type annotations for parameters are required. Return type is specified after `->`.

```rust
fn main() {
    println!("Hello from main!");
    another_function(5, 'h');
    let sum = add_five(10);
    println!("10 + 5 = {}", sum);
}

// Function with parameters
fn another_function(value: i32, unit_label: char) {
    println!("The measurement is: {}{}", value, unit_label);
}

// Function with a return value
// The last expression in the function is implicitly returned (no semicolon)
// Or use the `return` keyword explicitly.
fn add_five(x: i32) -> i32 {
    x + 5 // No semicolon means this is the return value
}
```

### Control Flow

* **`if`** Expressions:
  ```rust
  let number = 6;

  if number % 4 == 0 {
      println!("number is divisible by 4");
  } else if number % 3 == 0 {
      println!("number is divisible by 3");
  } else {
      println!("number is not divisible by 4 or 3");
  }

  // `if` is an expression, can be used in `let` statements
  let condition = true;
  let value = if condition { 5 } else { 6 };
  println!("The value is: {}", value);
  ```
* **Loops:** `loop`, `while`, `for`.
  ```rust
  // Infinite loop (use `break` to exit)
  let mut counter = 0;
  let result = loop {
      counter += 1;
      if counter == 10 {
          break counter * 2; // `break` can return a value
      }
  };
  println!("Loop result: {}", result);

  // `while` loop
  let mut number = 3;
  while number != 0 {
      println!("{}!", number);
      number -= 1;
  }
  println!("LIFTOFF!!!");

  // `for` loop (most common, iterates over collections)
  let a = [10, 20, 30, 40, 50]; // Ensure array is complete
  for element in a {
      println!("the value is: {}", element);
  }

  // For loop with a range
  ````markdown
