# Performance Evaluation
## Link Budget

### Enhanced Network Capacity
\begin{itemize}
  \item LoRa employs orthogonal spreading factors which enables multiple spread signals to be transmitted at the same time and on the same channel
  \item Modulated signals at different spreading factors appear as noise to the target receiver
  \item The equivalent capacity of a single 125 kHz LoRa channel is:
  \item[] $\mbox{    }SF12 + SF11 + SF10 + SF9 + SF8 + SF7 + SF6$
  \item[] $= 293 + 537 + 976 + 1757 + 3125 + 5468 + 9375$
  \item[] $= 21 531$ b/s $= 21.321$ kb/s
\end{itemize}

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
  \item[] $L_{Channel}$ = losses due to the propagation channel
  \item[] $M$ = fading margin and protection margin
\end{itemize}

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
    - Antenna gains: 3 dBi
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
    - Sum of antenna gains: $G_{System} = 6$ dBi
    - Fading and protection margin: $M = 10$ dB
    - Noise floor: $N= -153$ dBm

- We can now compute the received power $P_{RX}(i)$ and $\text{SNR}(i)$ for end-device $i$:
$$P_{Rx}(i) = P_{Tx} + G_{System} - L_{Channel}(i) - M$$
$$\text{SNR}(i) = P_{Rx}(i) - N$$

### Spreading Factor Selection
- The spreading factor for each end-device is selected using the following matching table:

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
- The total number of successfully received packets during $D$ is obtained by:
$$\frac{D}{T_a(l,s)}\times S$$


### Test

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/total-received-packets-nb-users-aloha.eps}
\end{figure}

- Deduce the number of nodes
- Deduce the arrival rate
- Put all results for SF7
- Compare two SF
- Conclude

### Introduce Multiple Gateways
### ALOHA Model
- ALOHA with duty cycle
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau})$$
- ALOHA with multiple receivers and perfect packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{1}{n})^r))$$
- ALOHA with multiple receivers and realistic packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{K^{n-1}}{n})^r))$$
with $$K = \frac{1}{2}10^{-\frac{\Delta}{10 \alpha}}$$
