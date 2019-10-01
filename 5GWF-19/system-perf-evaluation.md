## System-level Performance Evaluation

### From Link Level to System Level Performance

- Link level performance evaluation consider a single NB-IoT communication link between a pair of devices in an isolate noise-only scenario
- System level performance evaluation builds on link level results to consider a network with multiple concurrent communication links as in a realistic scenario
  - Gain deeper insight into the different network factors that affect the rate
  - Analyse cell planning strategies and compute the user performance indicators
  - Modify scheduling algorithms and study their performance 

\begin{figure}
	\centering
  \includegraphics[scale=0.25]{./images/network_topo.eps}
\end{figure}

<!--
  - Analyze the rate of NB-IoT transmission modes under different scenarios
  - Gain deeper insight into the different factors that can affect the rate
  - Modify parameters and propagation conditions and study their effect
-->

### Evaluation Scenario
- Study area
    - Surface: circular cell of radius 4 km
    - Distribution of devices: uniform
    - Single Base Station
    - Environment type: urban
- Uplink link budget
  - Parameters as in link level study
  - Shadow fading: lognormal $\mathcal{N}(0,8)$
  - Interference loss: $IF = 3$ dB
  - Penetration loss: $L_{penetration} = 15$ dB
  - 50% of indoor devices

\begin{picture}(50,50)
\put(190,60){\hbox{\includegraphics[scale=0.25]{./images/network_topo.eps}}}
\end{picture}

### Computing the User Rates (1/2)

- The uplink SINR for each device $i$ and each transmit format $t$ with:
  - $L_{channel}(i)$ channel loss with shadow fading
  - $N(t) = -174+10\text{log}_{10}(B(t)) + NF$
  - $\beta(i) = 1$ for an indoor device, and 0 otherwise

$$SINR(i,t) = P_{TX} + G_{system} - L_{system} - L_{channel}(i) - \beta(i) L_{penetration} - N(t) - IF$$

- The corresponding maximum data rate after *link adaptation*
$$D(i,t) = \underset{m}{\text{max}}(\underset{r}{\text{max}}(D(m,r,t)))$$ 
$$\text{with } SINR(i,t) \geq SINR_{threshold}(m,r,t)$$

<!--  
  - This is equal to the feasible rate with the lowest number of repetitions and highest MCS index 
-->

### Computing the User Rates (2/2)

- The maximum data rate for each device $i$ assuming that multi-tone and single-tone transmissions provide similar spectral efficiencies respectively
$$D(i) = \underset{t}{\text{max}}\ D(i,t)$$
- The device data rate for average radio conditions
$$\bar{D} = \frac{\sum_{i}D(i)}{I}$$
- The average device rate after scheduling
$$d = \frac{\bar{D}}{I}$$

### Transmission Formats

- For a cell radius of 4 km, good radio conditions enable to exploit the spectral efficiency of multi tone transmission
- For larger cells, single tone transmissions achieves better signal quality and becomes more attractive 

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/nbiot_tx_format_tones.eps}
\end{figure}

### Repetitions

- Only 20% of devices use more than one repetition for a cell radius of 4 km
- 45% of devices use two or more repetitions in harsh radio conditions 

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/nbiot_repetitions.eps}
\end{figure}

### Modulation and Coding Schemes
- For a cell radius of 4 km, 50% of devices use high MCS index (greater or equal to 9) in order to increase data rates
- For larger cell radius, 70% of devices use high MCS index!

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/nbiot_mcs_index.eps}
\end{figure}

### Link Adaptation: MCS index and Repetitions

- In order to combat harsh radio conditions and maximize rates, high MCS indexes are used jointly with a high number of repetitions

```{=latex}
\begin{figure}
	\centering
  \includegraphics<1>[scale=0.4]{./images/nbiot_mcs_repetitions_occurence-4000.eps}
  \includegraphics<2>[scale=0.4]{./images/nbiot_mcs_repetitions_occurence-8000.eps}
\end{figure}
```

### Network Capacity for NB-IoT and LoRaWAN
- The average NB-IoT rate decreases linearly with the number of device, while it drops drastically beyond 1000 devices for LoRaWAN

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/lpwa_rate_comparison-4000.eps}
\end{figure}

### Network Capacity with Constant Arrival Rate 

- If we consider an arrival rate of 5 packets per hour on each device, LoRaWAN does not succeed in delivering such service for more than 1000 devices

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/lpwa_bounded_rate_comparison-4000.eps}
\end{figure}

<!--
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
-->

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
  - Indoor dense urban (penetration margin of 18 dB)

- Best coverage is computed for single tone transmission and $\Delta f = 3.75$ kHz

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
