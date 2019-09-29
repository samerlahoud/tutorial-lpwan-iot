## System-level Performance Evaluation

### Results
- Spectral efficiency/instantaneous physical rate, for multi-tone and single-tone transmissions
    - Multi-tone transmissions provide similar spectral efficiencies. Consequently, network capacity = maximum data rate $\Rightarrow$ RU = 180 kHz (12 subcarriers) over 1 ms
    - Single-tone transmissions provide similar spectral efficiencies. Consequently, maximum data rate $\Rightarrow$ RU = 15 kHz over 8 ms
    - Generate devices, compute their received SNR
    - Perform link adaptation: determine their MCS and number of repetitions
    - Deduce their instantaneous physical rate/spectral efficiency
    - Average user instantaneous physical rate/spectral efficiency $\rightarrow$ network capacity = average number of devices per cell = average user instantaneous rate/average user required rate

### Results
- Link adaptation
    - Objective: maximize the instantaneous physical rate
    - For each number of repetition $R$, identify the MCS that maximizes the instantaneous rate, subject to: received SNR $\geq SNR_{threshold}$ $\Rightarrow$ one MCS candidate for each $R$
    - Choose, from these candidates, the (MCS, $R$) couple that maximizes the instantaneous physical rate
- Results:
    - Average user instantaneous rate to compute the cell capacity
    - Percentage of users using each MCS, or each (MCS, $R$) couple if more relevant

### Evaluation Scenario
- Area
    - Surface: circle of radius 4 km
    - Distribution of devices: uniform
    - Single eNodeB
    - Environment type: urban
- Uplink link budget similar to link level performance study

\begin{figure}
	\centering
  \includegraphics[scale=0.3]{./images/network_topo.eps}
\end{figure}

## Coverage Comparison of NB-IoT and LoRaWAN

### Outage Probability and Receiver Sensitivity

- Coverage outage is observed when the received power is less than the sensitivity
- Receiver sensitivity is given at different target rates:

|         | 100 b/s       | 200 b/s  |
|---------|---------------|----------|
| NB-IoT  | -150.1 dBm    | -147 dBm |
| LoRaWAN | -142 dBm      | -139 dBm |

- Coverage is computed for different environments (path loss formulas)
  - Outdoor rural
  - Outdoor urban
  - Indoor dense urban

### Coverage Comparison (1/3)
- The outage probability of NB-IoT at 100 b/s is almost null for all cases whereas it reaches 36% for LoRaWAN in indoor dense urban environments

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coverage-100bps-4000m.eps}
\end{figure}

### Coverage Comparison (2/3)
- The outage probability of NB-IoT at 200 b/s is slightly degraded in indoor dense urban environments

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coverage-200bps-4000m.eps}
\end{figure}

### Coverage Comparison (3/3)
- For a larger radius (8 km), LoRaWAN exhibits severe coverage limitation at 200 b/s in comparison with NB-IoT 

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coverage-200bps-8000m.eps}
\end{figure}
