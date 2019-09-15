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

### To Do
- Compute the receiver sensitivity:
    - Cell edge $\Rightarrow$ $R_b$ = 160 b/s, single-tone, subcarrier spacing = 3.75 kHz, and $R$ = 128
    - Determine the required $SNR$: $SNR_{threshold} = SNR_{req}$
    - Determine the receiver sensitivity
- Our channel models\footnote{R. El Chall, S. Lahoud and M. El Helou, "LoRaWAN Network: Radio Propagation Models and Performance Evaluation in Various Environments in Lebanon," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 2, pp. 2366-2378, April 2019.}: limitations of well-known models
- Give an numerical example of the cell range

## Coverage of NB-IoT

### Introduction

- The goal is to cover devices in areas previously inaccessible
by cellular networks due to penetration losses or remote locations.
- To solve this, NB-IoT utilizes bandwidth reduction and repetitions:
    - Bandwidth reduction concentrates the limited power on a narrower bandwidth at the UE $\Rightarrow$ it boosts the uplink power spectral density.
    - The successive repetitions can be incrementally soft combined at the receiver before decoding to raise error correction.
- In uplink, the transmission can be repeated {1, 2, 4, 8, 16,
32, 64, 128} times, using the same transmission power on each
repetition.
- In downlink, the number of repetitions are {1, 2, 4, 8, 16, 32, 64, 128, 192, 256, 384, 512, 768, 1024, 1536, 2048}.
- Each repetition is self-decodable, and all repetitions are confirmed just once.
- The arrangement of the repetitions depends on the number of
tones, subcarrier spacing, and the radio conditions.

### Channel Estimation
- To allow for coherent demodulation of the uplink and downlink
channels, NB-IoT has two reference signals: 
    1. Demodulation reference signal (DMRS) in uplink
    2. Narrowband reference signal (NRS) in downlink
- Reference symbols, also known as pilot symbols, are inserted in the time-frequency resource grid to allow channel estimation (CE)
- In downlink, NRS is included in all subframes that may be used for broadcast or downlink transmission using specific resource elements of the resource grid
- In uplink, DMRS is only multiplexed with the data. Depending on the uplink transmission, DMRS is included in either one or three SC-FDMA symbols per slot
- From these known transmitted pilot symbols, the receiver
can estimate the channel response
- Note that the quality of the estimation is limited by the number of pilot symbols and the received SNR

### Channel Estimation
- Under the targeted low range of SNR, an accurate CE becomes a dominant issue that limits the coverage improvement
- Since most of the NB-IoT UEs are stationary or have little mobility, the channel can be considered very slowly time-variant $\Rightarrow$ the CE could be improved using multiple consecutive subframes for the estimation, also known as \textit{cross-subframe CE}
- This improvement would be constrained by the coherence time of
the channel $\Rightarrow$ The length of the time-domain filter
of the cross-subframe CE has to be carefully chosen to avoid
performance degradation.

### System Model\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}
- While the UE is camping on the cell, it transfers data to the network periodically
- To save battery, after the end of the communication with the eNB and a period of NPDCCH monitoring, the UE stays in PSM
- Prior uplink data, the UE needs to reestablish the radio resource control (RRC) connection between the UE and the eNB. To do that, we assume the UE performs an RRC Resume procedure. 
- The analysis presented here focuses on the study of the uplink transmission, although the analysis is reciprocal for downlink considering subframes instead of RUs, and the specific parameters of downlink.
- We assume a very slowly time-variant channel and low
Doppler frequency (1 Hz)
- We only consider channel losses because of path loss, denoted as $L$, then MCL = $L$. To compensate channel losses, the UE adjusts its transmission power $P_{tx}$ up to a maximum allowed value $P_{max}$

### System Model
\begin{itemize}
\item Consequently, the SNR, denoted as $S/N$, can be calculated as:

\begin{equation*}
\frac{S}{N} = \frac{P_{tx}}{L \cdot F \cdot N_0 \cdot BW}
\end{equation*}

\item[] where $N_0$ is the thermal noise density, $F$ is the receiver noise figure, $BW = SCS \cdot N_T$ is the allocated bandwidth, $SCS$ is the subcarrier spacing, and $N_T$ is the number of tones

\item When the eNB configures the UE’s data transmission, we
consider four parameters:
\begin{enumerate}
    \item number of RUs
    \item MCS level
    \item the bandwidth allocated
    \item the number of repetitions
\end{enumerate}
\item For downlink receptions, we consider three parameters:
\begin{enumerate}
    \item number of subframes
    \item MCS level
    \item number of repetitions
\end{enumerate}
\end{itemize}

### System Model
\begin{itemize}
\item For both downlink and uplink, we assume the same information is included in each repetition and combined at the receptor using chase combining.
\item We consider QPSK modulation. The combination of the MCS, number of RUs, and allocated bandwidth determine the data rate of the transmission, derived as:

\begin{equation*}
R_b = \frac{b+ CRC}{RU \cdot T}
\end{equation*}

\item[] where $R_b$ is measured in bits/s, $b$ is the size of the data packet in bits, $CRC$ is the size in bits of the cyclic redundancy check code, $RU$ is the number of RUs allocated to the UE, and $T$ is the duration in seconds of an RU.
\end{itemize}

### System Model
- The selected configuration of the transmission parameters determines the $S/N$ at the UE's receiver
- We define $SNR_{req}$ as the minimum $S/N$ to successfully decode the uplink transmission $\Rightarrow S/N \geq SNR_{req}$
- When applying repetitions or bandwidth reduction, the values of $SNR_{req}$ and $S/N$ can be modified
- Specifically for uplink repetitions, the same data is repeatedly transmitted $R$ times
- The received transmission’s copies at the eNB can be combined to raise error correction. The resulting $SNR$ after the coherent combining of the copies is defined as effective $SNR$, denoted as $SNR_e$
- For ideal CE, the $SNR_e$ can be expressed as:
\begin{equation*}
SNR_e = \sum^{R} SNR_{req} = R \cdot SNR_{req}
\end{equation*}

### System Model
- For realistic CE, there is an estimation error, denoted as
$\sigma$
- This CE error will impact the system’s performance and limit the gain from repetitions.
- The approximated $SNR_e$ can be rewritten as\footnote{Y. D. Beyene, R. Jantti, K. Ruttik and S. Iraji, "On the Performance of Narrow-Band Internet of Things (NB-IoT)," in \textit{2017 IEEE Wireless Communications and Networking Conference (WCNC)}, San Francisco, CA, 2017.}:

\begin{equation*}
SNR_e = \frac{R \cdot (\sigma + SNR_{req})}{(\sigma + 1 + \frac{\sigma}{SNR_{req}}) \cdot (1+ \frac{\sigma}{2 \cdot SNR_{req}})}
\end{equation*}

### Analysis
- The aim is to estimate the $SNR_{req}$ of the UE considering the new concerns of NB-IoT, such as coverage enhancement approaches and CE errors at low SNR range
- The transmit power can be rewritten as:

\begin{equation*}
P_{tx} = SNR_{req} \cdot L \cdot F \cdot N_0 \cdot BW
\end{equation*}

### Baseline Analysis\footnote{P. Andres-Maldonado \textit{et al.}, “Analytic Analysis of Narrowband IoT Coverage Enhancement Approaches,” in Proc. \textit{2018 Global Internet of Things Summit (GIoTS)}, Bilbao, Spain, 2018.}: Ideal CE

- Based on the Shannon theorem, the $SNR$ at the eNB, denoted as $SNR_e$, can be derived as:

\begin{equation*}
SNR_e = 2^{R_b/BW} - 1 = 2^{\frac{b+CRC}{BW \cdot RU \cdot T}}-1
\end{equation*}

- The required SNR at the eNB can be expressed as:

\begin{equation*}
SNR_{req} = \frac{2^{R_b/BW} - 1}{R} = \frac{2^{\frac{b+CRC}{BW \cdot RU \cdot T}} - 1}{R}
\end{equation*}

- The bandwidth utilization $\gamma$ can be obtained as:

\begin{equation*}
\gamma = \frac{R_b}{R \cdot BW} = \frac{b+CRC}{R \cdot BW \cdot RU \cdot T}
\end{equation*}

### Detailed Analysis\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}: Realistic CE

\begin{itemize}
\item A modified Shannon capacity formula is used, as for LTE:

\begin{equation*}
C = BW \cdot BW_{eff} \cdot \log_2(1+ \frac{SNR_e}{SNR_{eff}})
\end{equation*}

\item[] where $C$ is the capacity of the channel measured in bits/s, $BW_{eff}$ is the bandwidth efficiency of the used technology (i.e., NB-IoT), and $SNR_{eff}$ is the efficiency of the SNR in NB-IoT.

\item Consequently, the $SNR_e$ can be expressed as:

\begin{equation*}
SNR_e = (2^{\frac{R_b}{BW \cdot BW_{eff}}}-1) \cdot SNR_{eff}
\end{equation*}
\end{itemize}

### Detailed Analysis: Realistic CE
\begin{itemize}
\item The approximated $SNR_{req}$ can be obtained as:

\begin{equation*}
(2^{\frac{R_b}{BW \cdot BW_{eff}}}-1) \cdot SNR_{eff} = \frac{R \cdot (\sigma + SNR_{req})}{(\sigma + 1 + \frac{\sigma}{SNR_{req}}) \cdot (1+ \frac{\sigma}{2 \cdot SNR_{req}})}
\end{equation*}

\item Unlike the baseline analysis, there is not a simple solution when solving $SNR_{req}$ $\Rightarrow$ $SNR_{req}$ is obtained through an iterative method
\item $\sigma$ depends on $SNR_{req}$. This is due to the quality of the CE depends on the amplitude of the received pilot symbols, and therefore, the $SNR_{req}$
\item After conducted simulations, the dependency between $\sigma$ and $SNR_{req}$ can be expressed in dB as a linear dependency:

\begin{equation*}
\sigma_{dB} = c_1 \cdot SNR_{req, dB} + c_2
\end{equation*}

\item[] where $SNR_{req,dB}$ and $\sigma_{dB}$ are measured in dB, and $c_1$ and $c_2$ are constants that depend on the cross-subframe window used in the CE and the modulation technique.
\end{itemize}

### Detailed Analysis: Realistic CE
- To minimize the effects of noise on the realistic CE, the channel estimates are averaged
- Under the hypothesis of slowly time-variant channel, the utilization of cross-subframe CE can produce a substantial noise reduction
- The value of $W_{cs}$ denotes the number of resources to be considered in the cross-subframe CE
    - For uplink, these resources are the number of RUs
    - For downlink, they are the number of subframes
- The simulation of different values of $W_{cs}$ provides a set of $c_1$ and $c_2$ values

### Numerical Results
- Three different scenarios:
    - ideal: Ideal CE
    - wcs: Realistic CE with cross-subframe
    - nocs: Realistic CE without cross-subframe technique
- Evaluation framework:
    1. $SNR_{req}$ estimation
    2. Configure the link adaptation of the signaling packet transfers required prior to the uplink data transmission.
    3. Estimation of the NB-IoT performance using an energy consumption model\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz, and J. M. Lopez-Soler, “Narrowband IoT Data Transmission Procedures for Massive Machine-Type Communications,” in \textit{IEEE Network}, vol. 31, no. 6, pp. 8–15, Nov./Dec. 2017.}

### Parameter Settings
- The correction values for Shannon formula are derived through curve fitting to the 3GPP’s link-level simulation results for NPUSCH and NPDSCH:

|  Parameter  | NPUSCH Multi-tone | NPUSCH Single-tone | NPDSCH |
|:-----------:|:-----------------:|:------------------:|:------:|
|  $BW_{eff}$ |        0.35       |        0.35        |  0.58  |
| $SNR_{eff}$ |         1         |        0.60        |  1.90  |

- The dependency between $\sigma_{dB}$ and $SNR_{req, dB}$ are obtained through simulation of $\sigma$ for NPUSCH and NPDSCH pilots:

| $W_{cs}$ | SC-FDMA $c_1$ | SC-FDMA $c_2$ | OFDMA $c_1$ | OFDMA $c_2$ |
|:------:|:-----------:|:-----------:|:---------:|:---------:|
|    1   |   -0.4896   |    4.4971   |  -0.4998  |  14.5262  |
|    2   |   -0.4844   |    3.0252   |  -0.4995  |  13.0035  |
|    4   |   -0.4780   |    1.5869   |  -0.4990  |  11.5017  |
|    8   |   -0.4725   |    0.1239   |  -0.4992  |   9.9952  |
|   16   |   -0.4475   |   -1.1335   |  -0.4969  |   8.5077  |

### Parameter Settings
\begin{itemize}
\item In uplink, $W_{cs}$ is derived as:

\begin{equation*}
W_{cs} = min(W_{cs}^{max}, 2^{\left\lfloor \log_2(RU \cdot R \cdot \eta_p)\right\rfloor})
\end{equation*}

\item[] where $W_{cs}^{max}$ is the maximum cross-subframe window considered and and $\eta_p$ is a correction factor: $\eta_p = 1$ for multi-tone configurations and $\eta_p = 0.6667$ for single-tone configurations.
\end{itemize}

### Results
- Estimate the $SNR_{req}$ in different configurations of number of RUs, MCS, BW, and R.
- Spectral efficiency as a function of MCL (dB)
- (A reproduire?) $SNR_{req}$ and $\gamma$ (bps/Hz) as a function of TBS size, for ideal, wcs, and nocs.... 1 RU and 8 RU
- (A reproduire) Example of degradation of the SNR gain in wcs and nocs scenarios compared with ideal scenario when a higher number of repetitions is used in uplink: $SNR_{req}$ as a function of the number of repetitions for ideal, nocs, and wcs
    - TBS = 1000 bits, 8 RU?

### Parameters
- TB: Application data (20 bytes), CoAP (4 bytes), DTLS (13 bytes), UDP (8 bytes), IP (40 bytes), PDCP (5 bytes), RLC (2 bytes), and MAC (2 bytes) => total: 94 bytes
- A 3-byte CRC is calculated and attached to a TB

<!-- 
- Multi-tone transmissions: $I_{TBS} = 0...13$; $I_{MCS} = I_{TBS}; QPSK (UL)
- Single-tone transmissions: $I_{TBS} = 0...10$; $I_{MCS} = I_{TBS}; BPSK for $I_{TBS} = 0$, or 2, and QPSK for all other values
- For NPUSCH transmissions, for every 256 ms continuous transmission, a 40 ms gap is introduced.
- A datarate of 160 bps is required at the MCL of 164 dB.

*1 RU, 5 RU, and 10 RU*

Maximum throughput => 1 RU = 1 ms * 12 subcarriers
1 RU => 224 k; 2 RU => 244 k; 3 RU => 248 k; 4 RU => 282 k; 5 RU => 251.2 k; 6 RU => 257.3 k; 8 RU => 253 k; 10 RU => 253.6 k

Minimum throughput => 1 RU = 32 ms * 1 subcarrier
1 RU => 500; 2 RU => 500; 3 RU => 583; 4 RU => 687.5; 5 RU => 750; 6 RU => 791.6; 8 RU => 812.5; 10 RU => 800

- Consider TBS = 1000 bits (8-ms cross-subframe CE?)
    - (A reproduire) Instantaneous data rate as a function of CL for 12 tones, 6 tones, 3 tones, 1 tone | 15 kHz, and 1 tone | 3.75 kHz
        - CL -> SNR ...?
    - (A reproduire?) RU = 1 ms, how many RU are needed to transmit this TB with R repetions? Modify R. Who can transmit this TB over x RU with R repetition?
-->

### Simulation Scenarios
- Mise au point
- $R_b$? as a function of $BW$, $RU$, and $T$
- Simulation scenarios








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