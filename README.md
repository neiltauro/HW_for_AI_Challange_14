## 🔹 Challenge #14 — Fibonacci Sequence in CUDA 🔹

This project demonstrates **the implementation of the Fibonacci sequence** both **sequentially (CPU)** and **parallelly (with CUDA)**.

---

## 📚 Challenge Goals:

- Implement Fibonacci number generation with CUDA kernel.
- Implement a CPU (sequential) version for comparison.
- Measure execution time for both methods.
- Provide observation about their performance.

---

## 🔹 What We Observe 🔹

- The **CPU version executes faster** for small input sizes due to minimal overhead and direct sequential computation.

- The **GPU kernel underperforms** for this Fibonacci implementation because:

  - Each Fibonacci number depends directly on its two preceding values, creating a **serial dependency**.

  - This dependency chain **prevents efficient parallelization**, which limits the advantages of GPU parallelism.

- GPUs excel at large-scale parallel tasks with **independent computations**, but Fibonacci’s recursive data dependency makes it a poor fit for parallel GPU acceleration.

- For algorithms with inherent sequential dependencies like Fibonacci, **CPU implementations often outperform GPU ones**, especially for smaller problem sizes.

- This highlights the importance of **choosing the right computational platform based on the problem structure**.

---

## 🛠 Installation and Compilation:

✅ **Requirements:**

- CUDA Toolkit installed
- `nvcc` compiler available in your PATH
- (Optionally) Python with matplotlib for visualization

✅ **Compile with:**

```bash
nvcc fibonacci.cu -o fibonacci


##