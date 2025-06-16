import matplotlib.pyplot as plt

# Mock-up data for demonstration
# You should replace these with your actual measured execution times
N = [220]
cpu_times = [0.0005]  # in seconds
gpu_times = [0.002]   # in seconds

# Plotting the comparison
plt.bar(['CPU', 'GPU'], [cpu_times[0], gpu_times[0]], color=['skyblue', 'lightcoral'])

plt.xlabel('Processor')
plt.ylabel('Execution Time (sec)')
plt.title(f'Fibonacci({N[0]}) - CPU vs GPU Execution Time')

plt.text(0, cpu_times[0] + 0.0001, f'{cpu_times[0]} sec', ha='center')
plt.text(1, gpu_times[0] + 0.0001, f'{gpu_times[0]} sec', ha='center')

plt.tight_layout()
plt.show()
