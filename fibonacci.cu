#include <cuda_runtime.h>
#include <iostream>
using namespace std;

// CUDA kernel for Fibonacci sequence
__global__
void fibonacciCuda(int N, unsigned long long* d_Fibonacci) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    if (idx < N) {
        if (idx == 0) d_Fibonacci[idx] = 0;
        else if (idx == 1) d_Fibonacci[idx] = 1;
        else d_Fibonacci[idx] = d_Fibonacci[idx - 1] + d_Fibonacci[idx - 2];
    }
}

void fibonacciCPU(int N, unsigned long long* h_Fibonacci) {
    if (N == 0) return;

    h_Fibonacci[0] = 0;

    if (N == 1) return;

    h_Fibonacci[1] = 1;

    for (int i = 2; i < N; i++) {
        h_Fibonacci[i] = h_Fibonacci[i - 1] + h_Fibonacci[i - 2];
    }
}

int main()
{
    int N = 220;

    unsigned long long* h_Fibonacci = new unsigned long long[N];
    unsigned long long* d_Fibonacci;

    size_t size = N * sizeof(unsigned long long);
    cudaMalloc((void**)&d_Fibonacci, size);
   cudaMemset(d_Fibonacci, 0, size);

    // Measure CPU execution
    clock_t cpuStart = clock();
    fibonacciCPU(N, h_Fibonacci);
    clock_t cpuEnd = clock();

    double cpuTime = (double)(cpuEnd - cpuStart) / CLOCKS_PER_SEC;

    cout << "CPU execution time: " << cpuTime << " seconds" << endl;

    // Measure GPU execution
    clock_t gpuStart = clock();

    int threads = 256;
    int blocks = (N + threads - 1) / threads;

    fibonacciCuda<<<blocks, threads>>>(N, d_Fibonacci);
    cudaDeviceSynchronize();

    clock_t gpuEnd = clock();

    double gpuTime = (double)(gpuEnd - gpuStart) / CLOCKS_PER_SEC;

    cout << "GPU execution time: " << gpuTime << " seconds" << endl;

    // Retrieve the results back to host
   cudaMemcpy(h_Fibonacci, d_Fibonacci, size, cudaMemcpyDeviceToHost);

    cout << "First 10 Fibonacci numbers:" << endl;
    for (int i = 0; i < 10; ++i) {
        cout << h_Fibonacci[i] << " "; 
    }
    cout << endl;

    delete[] h_Fibonacci;
   cudaFree(d_Fibonacci);

    return 0;
}

