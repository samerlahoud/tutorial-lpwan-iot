# Performance Evaluation

## Link Budget Analysis

### Link Budget
- The link budget is a measure of all the gains and losses from the transmitter, through the propagation channel, to the target receiver
- The link budget of a network wireless link can be expressed as:

\begin{equation*}
P_{Rx} = P_{Tx} + G_{System} - L_{System} - L_{Channel} - M
\end{equation*}
\begin{itemize}
  \item[] where:
  \item[] $P_{Rx}$ = the expected received power
  \item[] $P_{Tx}$ = the transmitted power
  \item[] $G_{System}$ = system gains such as antenna gains
  \item[] $L_{System}$ = system losses such as feed-line losses
  \item[] $L_{Channel}$ = path loss
  \item[] $M$ = additional margins
\end{itemize}

### Additional Margins
- Fading margin
- Interference margin
- Penetration margin:
    - indoor penetration loss (first wall): $\sim 18$ dB (in dense urban environment), $\sim 15$ dB (in urban environment), and $\sim 10-12$ dB (in rural environment)
    - deep indoor penetration loss (second wall): +3 dB
- Protection margin

### Maximum Allowable Path Loss
- The maximum allowable path loss ($MAPL$) is expressed as:
\begin{equation*}
MAPL = \max L_{Channel} \mbox{ } | \mbox{ } P_{Rx} = \mbox{receiver sensitivity}
\end{equation*}
\begin{equation*}
\Rightarrow MAPL = P_{Tx} + G_{System} - L_{System} - M - \mbox{receiver sensitivity}
\end{equation*}

- The maximum allowable distance between a transmitter and a receiver (cell range) depends on the $MAPL$ and the channel model

<!--
### Enhanced Network Capacity
\begin{itemize}
  \item LoRa employs orthogonal spreading factors which enables multiple spread signals to be transmitted at the same time and on the same channel
  \item Modulated signals at different spreading factors appear as noise to the target receiver
  \item The equivalent capacity of a single 125 kHz LoRa channel is:
  \item[] $\mbox{    }SF12 + SF11 + SF10 + SF9 + SF8 + SF7 + SF6$
  \item[] $= 293 + 537 + 976 + 1757 + 3125 + 5468 + 9375$
  \item[] $= 21 531$ b/s $= 21.321$ kb/s
\end{itemize}
-->

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
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |

<!--
Spreading factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|-----------|-------------|-------------|-------------|-------------|-------------|
Coverage (\%)                |40.50      | 11.10       | 10.00       | 8.80        | 7.30        | 8.40        |
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |
-->

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
