## System-level Performance Evaluation

### Results
- Instantaneous data rate ($R_b/R$ in kb/s) as a function of the coupling loss (CL, in dB), for 12 tones, 6 tones, 3 tones, 1 tone ($\Delta f = 15$ kHz), and 1 tone ($\Delta f = 3.75$ kHz)
    - TBS = 1000 bits (with 4 RU, 5 RU, 6 RU, 8 RU, and 10 RU for multi-tone transmissions; 6 RU, 8 RU, and 10 RU for single-tone transmissions)
    - Compute $R_b$ and $BW$
    - Deduce $SNR_e$
    - Compute the received $SNR$ as a function of the CL
    - Deduce the required number of transmissions $R$ (Realistic CE, $W_{cs} = 8$ ms)
    - Deduce $R_b/R$. If it depends on the number of RU, display the maximum $R_b/R$.

### Result 3

\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/instantaneousRate.eps}
\end{figure}

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

### Simulation Scenarios
- NB-IoT sensitivity: -150.1357 dBm (100 b/s); -147 dBm (200 b/s)
- LoRaWAN sensitivity: -142 dBm (100 b/s); -139 dBm (200 b/s)

<!-- 
## Coverage of LoRaWAN

### Evaluation Scenario
- Area
    - Surface: square of 8 Km $\times$ 8 Km
    - Number of end-devices: 1000
    - Distribution of end-devices: uniform
    - Single gateway
    - Environment type: urban
- Radio link  
    - Bandwidth: 125 kHz
    - Transmit power: 14 dBm
    - Gateway height: 30 m
    - End-device height: 1.5 m
    - Antenna gains: 6 dBi
    - Noise floor: -153 dBm
    - Pathloss: Okumura-Hata
    - Shadow fading: lognormal $\mathcal{N}(0,8)$

\begin{picture}(50,50)
\put(190,80){\hbox{\includegraphics[scale=0.3]{./images/initial-network.eps}}}
\end{picture}

### Pathloss Model
- Using the Okumura-Hata urban model, the pathloss between device $i$ and the gateway is proportional to the logarithm of the distance $d(i,g)$ in Km:

$$L_{Channel}(i) = A+B \log_{10}(d(i,g))$$

- The two parameters $A$ and $B$ depend on the antenna heights ($h_b = 30$ m for the gateway and $h_d = 1.5$ m for the end-device) and the central frequency $f_c = 868$ MHz
$$A = 69.55 + 26.16 \log_{10}(f_c) - 13.82 \log_{10}(h_b) - 3.2(\log{10}(11.75 h_d))^2+4.97$$
$$B = 44.9 - 6.55 \log_{10}(h_b)$$

### Link Budget

- We consider the following parameters:
    - Transmit power: $P_{Tx} = 14$ dBm
    - Antenna gain: $G_{System} = 6$ dBi
    - Fading and protection margin: $M = 10$ dB
    - Noise floor: $N= -153$ dBm

- We can now compute the received power $P_{RX}(i)$ and $\text{SNR}(i)$ at the gateway for end-device $i$:
$$P_{Rx}(i) = P_{Tx} + G_{System} - L_{Channel}(i) - M$$
$$\text{SNR}(i) = P_{Rx}(i) - N$$

### Spreading Factor Selection
- The spreading factor for each end-device is selected using the following matching table (Source: SX1276/77/78/79 Semtech datasheet):

SNR Interval (dB) | Spreading Factor      |
------------------|:---------------------:|
[-7.5, $+\infty$[ | 7                     |          
[-10, -7.5[       | 8                     |
[-12.5, -10[      | 9                     |
[-15, -12.5[      | 10                    |
[-17.5, -15[      | 11                    |
[-20, -17.5[      | 12                    |

- Note that for SNR values lower that -20 dB, the end-device is considered out of coverage of the gateway

### Coverage Study
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.4]{./images/coverage-sf7.eps}
  \includegraphics<2>[scale=0.4]{./images/coverage-sf78.eps}
  \includegraphics<3>[scale=0.4]{./images/coverage-sf789.eps}
  \includegraphics<4>[scale=0.4]{./images/coverage-sf78910.eps}
  \includegraphics<5>[scale=0.4]{./images/coverage-sf7891011.eps}
  \includegraphics<6>[scale=0.4]{./images/coverage-sf789101112.eps}
  \includegraphics<7>[scale=0.4]{./images/coverage-sf789101112u.eps}
\end{figure}

Spreading Factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|:---------:|:-----------:|:-----------:|:-----------:|:-----------:|:-----------:|
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |

### Spreading Factor and Time on Air
- The Time on Air is defined as the time required to transmit a packet in a sub-band
- The selection of the spreading factor impacts the Time on Air and consequently determines the duty cycle limitation
\begin{figure}
	\centering
  \includegraphics[scale=0.35]{./images/timeonair.eps}
\end{figure}

### Spreading Factor and Energy Consumption
\begin{figure}
	\centering
  \includegraphics[scale=0.2]{./images/energy-sf-lorawan.png}
  \caption*{Source: Lluís Casals {\it et al.}, Modeling the Energy Performance of LoRaWAN, Sensors, 2017}
\end{figure}

- DR0 to DR5 correspond to spreading factors 12 to 7 with a bandwidth of 125 kHz. DR6 correspond to spreading factor 7 and a bandwidth of 250 kHz
- For an end-device sending packets every 100 minutes, changing the spreading factor from 12 to 7 increases its lifetime by almost 1.5 years

### Enhancing the Coverage with Multiple Gateways
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coverage-sf789101112u-4gw.eps}
\end{figure}

Spreading Factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|:---------:|:-----------:|:-----------:|:-----------:|:-----------:|:-----------:|
Cumulative coverage (\%)     |88.70      | 94.50       | 97.60       | 99.20       | 99.60       | 100.00      |

## Capacity of LoRaWAN
### Pure ALOHA Model
- The start times of the packets in an ALOHA channel is modeled as a Poisson point process with parameter $\lambda$ packets/second
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/collision-aloha.eps}
\end{figure}
- If each packet in the channel lasts $T_a$ seconds, the normalized channel traffic can be defined as
$$G= \lambda T_a$$
- The normalized throughput of the ALOHA random access channel is given by
$$S = G \exp(-2G)$$

### ALOHA Model for LoRaWAN
- We consider the case where only *one* spreading factor and *one* sub-channel are available
- The general case of multiple sub-channels and spreading factors can be easily inferred
    - Multiple spreading factors are orthogonal
    - Packets are uniformly transmitted on available sub-channels
- The time to transmit a packet of $l$ bytes (size of MAC payload) on spreading factor $s$ is denoted $T_a(l,s)$
- Given a duty cycle limitation of $d=1\%$, the packet generation rate for each end-device operating on spreading factor $s$ must verify:
$$\lambda(s) \leq \frac{d}{T_a(l,s)}$$
- The normalized channel traffic for $N$ end-devices is obtained as follows:
$$G = N . \lambda(s) . T_a(s)$$

### Capacity Formulas for LoRaWAN
- We consider a LoRaWAN network with $N$ end-devices and one gateway
    - One spreading factor $s$ and one sub-channel are available
    - Transmit attempts are done according to a Poisson distribution
    - All end-devices have the same packet generation rate $\lambda(s)$
    - All packets have the same length of $l$ bytes
- The normalized throughput of the LoRaWAN network is given by:
$$S = G\exp(-2G) = N \lambda(s) T_a(l,s) \exp(-2 N \lambda(s) T_a(l,s))$$
- The total number of transmitted packets per second that are successfully received by the gateway (referred to as successful transmissions in the following) is obtained by:
$$\frac{1}{T_a(l,s)}\times S$$

### Successful Transmissions per Hour
- The number of successful transmissions per hour decreases for more than 50 end-devices
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/total-received-packets-nb-users-aloha.eps}
  \caption*{$l$=50 bytes, SF=7, $\lambda(s) = \frac{d}{T_a(l,s)}$}
\end{figure}

### Data Extraction Rate
- For 100 end-devices the percentage of successful transmissions is equal to 14\% (the average number of successfully transmitted packets per end-device equals 40 per hour, out of 289 generated packets)
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/der-nb-users-aloha.eps}
  \caption*{$l$=50 bytes, SF=7, $\lambda(s) = \frac{d}{T_a(l,s)}$}
\end{figure}

### Packet Generation Rate  
- For small number of end-devices, the throughput is limited by the duty cycle
- For large number of end-devices, the throughput is limited by collisions
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/received-packets-generated-packets-aloha.eps}
  \caption*{$l$=50 bytes, SF=7}
\end{figure}

### Spreading Factors and Successful Transmissions
- For 50 end-devices, the average number of successful transmissions per end-device per hour increases from 6 to 106 when SF decreases from 12 to 7
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/sf-compare-received-packets-nb-users-aloha.eps}
  \caption*{$l$=50 bytes, $\lambda(s) = \frac{d}{T_a(l,s)}$}
\end{figure}

### Collisions and Capture Effect
- It is assumed by default that all transmitted signals that collide will fail to be received
- In practice, the strongest received signal may be successfully received despite the presence of interfering signals $\Rightarrow$ capture effect
- The capture effect depends on:
    - The receiver sensitivity
    - The signal to noise plus interference ratio SINR
- The presence of multiple receivers favors the capture effect
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/capture-schema.eps}
\end{figure}

### Applying the Capture Effect for LoRaWAN
- We consider a LoRaWAN network with $N$ end-devices and $r$ gateways
- We take $G = N \lambda(s) T_a(l,s)$, where $\lambda(s)$ is the packet generation rate of each end-device, and $T_a(l,s)$ the time to transmit a packet of $l$ bytes
- We assume that a packet is successfully received by one gateway if the corresponding received signal power is higher than the maximum interferer
    - We consider an additional margin of $\Delta$ dB ($\Delta$ equals 3 dB or 6 dB in practice)
- The probability of successful transmission of one packet when $n$ collisions occur is denoted by $P_{cap}(n,\Delta)$
- The normalized throughput of the LoRaWAN network is given by:
$$S = G\exp(-2G) (1+\sum_{n=2}^{N} \frac{(2G)^n}{n!} (1-(1-P_{cap}(n,\Delta))^r))$$

### Successful Transmissions with Capture Effect
- For 100 end-devices, the number of successful transmissions per hour per end-device increases from 38 to 52 when considering the capture effect with one gateway, and reaches 84 with 4 gateways
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/capture-effect-aloha.eps}
  \caption*{$l$=50 bytes, SF=7, $\lambda(s) = \frac{d}{T_a(l,s)}$, $\Delta = 6$ dB}
\end{figure}

-->

## Coverage Comparison of LoRaWAN and NB-IoT

### Coupling Loss

- Coverage outage $\Rightarrow$ coupling loss $> MCL$ (NB-IoT: 164 dB, LoRaWAN: 157 dB)
- In indoor dense urban environments, the outage probability of LoRaWAN is 87% (with a single gateway)

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coupling-loss-lora-nbiot-1gw.eps}
\end{figure}

### Enhancing the Coverage with Multiple Gateways

- Network densification decreases the outage probability of LoRaWAN to 55%
- LoRaWAN has coverage limitations in comparison with NB-IoT

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coupling-loss-lora-nbiot-4gw.eps}
\end{figure}
