# Performance Evaluation

## Cell Range Estimation

### Link Budget
- The link budget is a measure of all the gains and losses from the transmitter, through the propagation channel, to the target receiver
- The link budget can be expressed as: $$P_{Rx} = P_{Tx} + G_{System} - L_{System} - L_{Channel} - M$$
    - $P_{Rx}$ = median received power
    - $P_{Tx}$ = transmit power
    - $G_{System}$ = system gains (\textit{e.g., } antenna, diversity, and amplifier gains)
    - $L_{System}$ = system losses (\textit{e.g., } cable and connector losses)
    - $L_{Channel}$ = median path loss
    - $M$ = additional margins

### Additional Margins
- Fading margin
- Interference margin
- Penetration margin:
    - indoor penetration loss (first wall): $\sim 18$ dB (in dense urban environment), $\sim 15$ dB (in urban environment), and $\sim 10-12$ dB (in rural environment)
    - deep indoor penetration loss (second wall): +3 dB
- Body loss

### Maximum Allowable Path Loss and Cell Range

- The maximum allowable path loss ($MAPL$) is expressed as:
$$MAPL = \text{max } L_{Channel} \mbox{ } | \mbox{ } P_{Rx} \geq \text{receiver sensitivity}$$
$$\Rightarrow MAPL = P_{Tx} + G_{System} - L_{System} - M - \text{receiver sensitivity}$$
- The maximum allowable distance between the transmitter and the target receiver (cell range) depends on the $MAPL$ and the channel model\footnote{R. El Chall, S. Lahoud, and M. El Helou, "LoRaWAN Network: Radio Propagation Models and Performance Evaluation in Various Environments in Lebanon," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 2, pp. 2366-2378, April 2019.}
- Transmission and reception parameters are determined so as to achieve balanced links (\textit{i.e.,} uplink $MAPL$ = downlink $MAPL$)

### Illustration: NB-IoT Uplink Link Budget Analysis

|     |                                                          |        |
|:---:|:--------------------------------------------------------:|:------:|
| $(a)$ |                $P_{Tx}$ (dBm)               |   23   |
| $(b)$ |              $G_{System} =$ base station antenna gain (dBi)             |   12   |
| $(c)$ |               $L_{System} =$ base station cable loss (dB)           |    3   |
| $(d)$ |                $M$ (dB)                  |   16   |
| $(e)$ |                  $B$ (Hz)                  |  3750  |
| $(f)$ |               Receiver $NF$ (dB)            |    3   |
| $(g)$ |              Receiver $N$ (dBm) = $-174+ 10 \text{log}_{10} (e)+ (f)$| -135.3 |
| $(h)$ |            Required SINR\footnote{Target transmission data rate = 160 b/s} at the receiver (dB)        | -12.74 |
| $(i)$ |   Receiver sensitivity (dBm) =  $(g) + (h)$ |  -148  |
|       |         \textbf{Uplink \textit{MAPL} (dB)} = $(a)+(b)-(c)-(d)-(i)$  | \textbf{164} |
|       |     \textbf{Uplink cell range}\footnote{Okumura-Hata model: base station antenna height = 30 m, device antenna height = 1 m, carrier frequency = 862 MHz} \textbf{- urban environment (km)}         |   \textbf{11}    |

## Coverage of LoRaWAN
### Evaluation Scenario
- Study area
    - Surface: circular cell of radius 4 km
    - Distribution of devices: uniform
    - Single gateway
    - Environment type: urban
- Uplink link budget
  - Parameters as in link level study
  - Shadow fading: $\mathcal{N}(0,8)$
  - Interference: $IF = 3$ dB
  - Penetration loss: $L_{penetration} = 15$ dB
  - 50% of indoor devices

\begin{picture}(50,50)
\put(190,60){\hbox{\includegraphics[scale=0.25]{./images/network_topo.eps}}}
\end{picture}

<!--
### Pathloss Model
- Using the Okumura-Hata urban model, the pathloss between device $i$ and the gateway is proportional to the logarithm of the distance $d(i,g)$ in Km:

$$L_{Channel}(i) = A+B \log_{10}(d(i,g))$$

- The two parameters $A$ and $B$ depend on the antenna heights ($h_b = 30$ m for the gateway and $h_d = 1.5$ m for the end-device) and the central frequency $f_c = 868$ MHz
$$A = 69.55 + 26.16 \log_{10}(f_c) - 13.82 \log_{10}(h_b) - 3.2(\log{10}(11.75 h_d))^2+4.97$$
$$B = 44.9 - 6.55 \log_{10}(h_b)$$
-->
### Signal to Noise Ratio Computation

- We consider the following specific parameters for LoRaWAN:
    - Transmit power: $P_{Tx} = 14$ dBm
    - Noise floor: $N= -153$ dBm

- We can now compute the uplink $SNR(i)$ at the gateway for end-device $i$:
$$SNR(i) = P_{TX} + G_{system} - L_{system} - L_{channel}(i) - \beta(i) L_{penetration} - N - IF$$

  - $L_{channel}(i)$ channel loss with shadow fading
  - $\beta(i) = 1$ for an indoor device, and 0 otherwise

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

### Coverage Study of LoRaWAN
```{=latex}
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
```

Spreading Factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|:---------:|:-----------:|:-----------:|:-----------:|:-----------:|:-----------:|
Cumulative coverage (\%)     |52.60      | 59.10       | 65.80       | 72.00       | 77.60       | 84.10       |

<!--
Spreading factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|-----------|-------------|-------------|-------------|-------------|-------------|
Coverage (\%)                |40.50      | 11.10       | 10.00       | 8.80        | 7.30        | 8.40        |
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |
-->

<!--
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
-->

## Coverage of NB-IoT

### Device Rate Computation (1/2)

- We consider a similar evaluation scenario as for LoRaWAN

- The uplink SINR for each device $i$ and each transmission format $t$ is given by:
$$SINR(i,t) = P_{TX} + G_{system} - L_{system} - L_{channel}(i) - \beta(i) L_{penetration} - N(t) - IF$$

  - $P_{Tx} = 23$ dBm
  - $N(t) = -174+10\text{log}_{10}(B(t)) + NF$

<!--  
  - This is equal to the feasible rate with the lowest number of repetitions and highest MCS index 
-->

### Device Rate Computation (2/2)

- We compute the corresponding maximum data rate after *link adaptation*
$$D(i,t) = \underset{m}{\text{max}}(\underset{r}{\text{max}}(D(m,r,t)))$$ 
$$\text{with } SINR(i,t) \geq SINR_{threshold}(m,r,t)$$

- The maximum data rate \footnote{assuming that multi-tone and single-tone transmissions provide similar spectral efficiencies respectively} for each device $i$  is given by:
$$D(i) = \underset{t}{\text{max}}\ D(i,t)$$

<!--
- The device data rate for average radio conditions
$$\bar{D} = \frac{\sum_{i}D(i)}{I}$$
- The average device rate after scheduling
$$d = \frac{\bar{D}}{I}$$
-->

### Transmission Formats

- For a cell radius of 4 km, good radio conditions enable to exploit the spectral efficiency of multi-tone transmissions
- For larger cells, single tone transmissions achieve better signal quality and become more attractive 

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
- For a cell radius of 4 km, 50% of devices use high MCS index (greater or equal than 9) in order to increase data rates
- For larger cells, 70% of devices use high MCS index!

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/nbiot_mcs_index.eps}
\end{figure}

### Link Adaptation: MCS index and Repetitions

- In order to combat harsh radio conditions and maximize rates, high MCS index is used jointly with a large number of repetitions

```{=latex}
\begin{figure}
	\centering
  \includegraphics<1>[scale=0.4]{./images/nbiot_mcs_repetitions_occurence-4000.eps}
  \includegraphics<2>[scale=0.4]{./images/nbiot_mcs_repetitions_occurence-8000.eps}
\end{figure}
```

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

- Best coverage is computed for single-tone transmission and $\Delta f = 3.75$ kHz

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
- For a larger cell radius (8 km), LoRaWAN exhibits severe coverage limitation at 200 b/s in comparison with NB-IoT 

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/coverage-200bps-8000m.eps}
\end{figure}

## Capacity of LoRaWAN

### Capacity Model for LoRaWAN
- The start times of the packets in an ALOHA channel are modeled as a Poisson point process with parameter $\lambda$ packets/second
- Given a duty cycle limitation of $d=1$\%, we must verify for spreading factor $s$: $$\lambda(s) \leq \frac{d}{T_a(l,s)}$$
- The time to transmit a packet of $l$ bytes (size of MAC payload) on spreading factor $s$ is denoted $T_a(l,s)$
- The normalized total throughput of the LoRaWAN network with $N(s)$ end-devices on spreading factor $s$ is given by:
$$S = \sum_s G(s)\text{exp}(-2G(s))$$ 
$$\text{with } G=N(s) \lambda(s) T_a(l,s)$$

### Packet Generation Rate  
- For small number of end-devices, the throughput is limited by the duty cycle
- For large number of end-devices, the throughput is limited by collisions

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/received-packets-generated-packets-aloha.eps}
  \caption*{$l$=50 bytes, SF=7}
\end{figure}

### Spreading Factors and Packet Delivery
- For 50 end-devices, the average number of delivered packets per end-device per hour increases from 6 to 106 when SF decreases from 12 to 7

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/sf-compare-received-packets-nb-users-aloha.eps}
  \caption*{$l$=50 bytes, $\lambda(s) = \frac{d}{T_a(l,s)}$}
\end{figure}

### Traffic Load and Packet Delivery
- The traffic load for high spreading factors induces a low delivery ratio

```{=latex}
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/lora_pdr.eps}
  \caption*{$l$=50 bytes, $\lambda = \frac{d}{T_a(l,s=12)}$}
\end{figure}
```

<!--
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

## Capacity of NB-IoT

### Average Data Rate Computation
- We compute the maximum data rate $D(i)$ for each device $i$ 
  - Link adapation
  - Choice of transmission format
- The device data rate for average radio conditions is given by:
$$\bar{D} = \frac{\sum_{i}D(i)}{I}$$
- After scheduling, the average device rate is computed as follows:
$$d = \frac{\bar{D}}{I}$$

## Capacity Comparison of NB-IoT and LoRaWAN

### Network Capacity for NB-IoT and LoRaWAN
- The average rate decreases linearly with the number of devices for NB-IoT, while it drastically drops beyond 1000 devices for LoRaWAN

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
