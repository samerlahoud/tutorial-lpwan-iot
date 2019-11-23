# Design Principles

## Low Device Complexity and Cost
### Device Complexity and Cost
- Devices are mainly composed of:
    - a processing unit: usually a microcontroller with a limited amount of memory
    - a sensing unit: sensors and analog to digital converters
    - a radio unit: usually a transceiver capable of bidirectional communications

- The radio unit complexity and cost are primarily related to the complexity of:
    - digital baseband processing
    - radio-frequency (RF) analog processing

<!--
Support mass production and deployment
-->

### Digital Baseband Processing
- Reduce baseband processing complexity through:
    - limiting message size
    - using simple channel codes
    - not using complex modulations or multiple-input multiple-output (MIMO) transmissions
    - supporting only half-duplex operation: no simultaneous transmission and reception

### RF Processing
- Reduce RF processing complexity and cost through:
    - using one transmit-and-receive antenna
    - not using a duplexer (since only half-duplex operation is supported)
    - on-chip integrating power amplifier $\Rightarrow$ single-chip modem implementation (since transmit power is limited)

## Reliability Under Extreme Coverage Conditions
### Reliability and Radio Quality
- Reliability $\Rightarrow$ bit error rate ($BER$) $\leq$ target $BER$
- The energy per bit to noise power spectral density ratio ($E_ b/N_0$) is defined as the ratio of the energy per bit ($E_b$) to the noise power spectral density ($N_0$)
\vspace{-2mm}
```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.43]{./images/qpsk-perf-1.pdf}
	\includegraphics<2>[scale=0.43]{./images/qpsk-perf-2.pdf}
\end{figure}
```

<!--
- Cover areas traditional cellular technologies can not cover (deep indoor areas, for example)
-->

### Reliability and Radio Quality
\begin{equation*}
\text{$BER \leq$ $BER_{target}$} \Leftrightarrow \frac{E_b}{N_0} \geq \left( \frac{E_b}{N_0}\right)_{threshold}
\end{equation*}

- $(E_b/N_0)_{threshold}$ does not depend on the signal bandwidth and data rate
- The $SNR$, or equivalently the carrier-to-noise ratio ($CNR$ or $C/N$), is defined as the ratio of the received signal power $C$ to the power of the noise $N$ within the bandwidth of the transmitted signal $$ SNR = \frac{C}{N} = \frac{E_b/T_b}{N_0B} = \frac{E_b}{N_0}\frac{R_b}{B}$$
    - $B$ is the signal bandwidth in Hz
    - $R_b$ is the data rate (or bit rate) in b/s.

### Receiver Sensitivity
\begin{table}
\centering
\begin{tabular}{c c c}
$BER$ $\leq$ $BER_{target}$& $\Leftrightarrow$ &$SNR$ $\geq \underbrace{\left(\frac{E_b}{N_0}\right)_{threshold} \frac{R_b}{B}}_{SNR_{threshold}}$ \\
&&\\
& $\Leftrightarrow$& $S$ (dBm) $\geq \underbrace{SNR_{threshold}\text{ (dB) } + N \text{ (dBm)}}_{\text{Receiver sensitivity}}$ \\
\end{tabular}
\end{table}

- $N$ (dBm) is the background noise power at the receiver $= TN$ (dBm) $+ NF$ (dB)
    - $TN$ is the thermal noise caused by thermal agitation of charge carriers: $-174 + 10\text{log}_{10}(B)$
    - $NF$ is the noise figure caused by RF components

### Maximum Coupling Loss
- The Maximum Coupling Loss ($MCL$) defines the maximum loss the system can cope with between a transmitter and a receiver: $$ 
MCL \text{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\text{log}_{10}(B) + NF)}_{\text{Receiver sensitivity}}$$
    - $P_{Tx}$ is the transmit power in dBm.

\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.34]{./images/MCL.pdf}
\end{figure}

### How to Improve Coverage?
- Coverage targets are usually specified in terms of $MCL$
- Increasing $P_{Tx}$, or lowering $NF$, leads to higher device complexity and cost
- Reducing $B$ leads to lower network capacity
- Improve coverage by reducing $SNR_{threshold}$ through:
    - Spread spectrum techniques (LoRaWAN)
    - Repetitions and efficient HARQ retransmissions (NB-IoT)

## Chirp Spread Spectrum in LoRaWAN
### What is Spread Spectrum?
- Spread spectrum techniques deliberately spread a signal in the frequency domain, resulting in a signal with a wider bandwidth
- Direct-sequence SS (DSSS), frequency-hopping SS (FHSS), time-hopping SS (THSS), and chirp SS (CSS) are forms of spread spectrum
<!--
..., and combinations of these techniques are forms of SS.
THSS: the transmission time is changed randomly by varying the period and duty cycle of the pulse (within the transmission window) using a pseudo-random sequence.
-->
- Spreading process in DSSS systems: at the transmitter, the input data $S(t)$ is multiplied with a spreading code $C(t)$

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/spreading-process.pdf}
\end{figure}

### What is Spread Spectrum?
- De-spreading process in DSSS systems: at the receiver, $S(t)$ is re-covered by re-multiplying with the same spreading code $C(t)$

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/de-spreading-process.pdf}
\end{figure}

### Why Spread Spectrum?
- Spread spectrum compensates for the $SNR$ degradation $$ SNR = \frac{E_b}{N_0}\frac{R_b}{B} \Rightarrow SNR_{threshold} = \left( \frac{E_b}{N_0}\right)_{threshold} - \underbrace{10\text{log}_{10}\left( \frac{B}{R_b}\right)}_{\text{$G_p$}}$$
    - $G_p = 10\text{log}_{10}\left( \frac{B}{R_b}\right) = 10\text{log}_{10}(T_bB)$ is the processing gain

- The higher $G_p$ is
    - the lower $SNR_{threshold}$ is $\Rightarrow$ larger radio coverage
    - the lower $R_b$ is (for a constant $B$)

### Linear Chirp
- A linear chirp is a sinusoidal signal whose frequency linearly increases ($up$- $chirp$) or decreases ($down$-$chirp$) over time
\vspace{-1mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/chirp-1.pdf}
    \vspace{-5mm}
	\caption*{A sinusoidal linear up-chirp in the time domain}
\end{figure}

### Linear Chirp Theory
- A linear chirp waveform can be written as: $$ x(t) = a(t)sin(2 \pi f_0 t + \pi \mu t^2 + \phi_0) $$
    - $a(t)$ is the chirp envelope which is zero outside a time interval of length $T$
    - $f_0$ is the initial frequency
    - $\mu$ is the chirp rate, or chirpyness
    - $\phi_0$ is the initial phase.

- The instantaneous frequency $f(t)$ is defined as: $$ f(t) = \frac{1}{2 \pi} \frac{d(2 \pi f_0 t + \pi \mu t^2 + \phi_0)}{dt} = f_0 + \mu t $$

- The chirp rate $\mu$ represents the rate of change of the instantanous frequency: $$\mu = \frac{df(t)}{dt}$$

### Spectrograms of Linear Chirps
- $\mu > 0 \Rightarrow up$-$chirps$, $\mu < 0 \Rightarrow down$-$chirps$

\begin{figure}
	\centering
    \includegraphics[scale=0.4]{./images/spectrograms.pdf}
    \caption*{Spectrograms of linear $up$-$chirp$ (a) and  $down$-$chirp$ (b)}
\end{figure}

### Bandwidth Spreading
- The bandwidth $B$ is defined as the range of the instantaneous frequency: $B = |\mu| T$
- The processing gain is given by the time-bandwidth product $TB$

\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.45]{./images/definitions.pdf}
\end{figure}

### What is Chirp Spread Spectrum?
- Chirp Spread Spectrum (CSS) is a spread spectrum technique that uses wideband linear frequency modulated chirps to encode information
- Encoding information using $up$-$chirp$ and $down$-$chirp$ signals:
    - Example: "1" $\Rightarrow$ transmit an $up$-$chirp$, "0" $\Rightarrow$ transmit a $down$-$chirp$
    - Chirps are transmitted in equidistant time steps
- Encoding information using only one chirp waveform with Pulse-Position Modulation (PPM):
    - $M$ bits are encoded by transmitting a single $chirp$ in one of $2^M$ possible time shifts $\Rightarrow$ data rate = $M/T$ in b/s
    - Chirps are not transmitted in equidistant time steps
- At the receiver, the wanted information is re-covered through de-chirping

<!--
Multiply with the complexe conjugate of the chirp signal
-->

### Example: Binary Orthogonal Keying (BOK) Schemes
\vspace{2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/bok.pdf}
    \vspace{-5mm}
	\caption*{a) BOK using $up$- and $down$- chirps b) BOK using PPM}
\end{figure}

### Advantages of CSS
- CSS is robust to interference, multipath fading, and Doppler effect
- Time and frequency offsets between transmitter and receiver are equivalent, greatly reducing the complexity of the receiver design

<!--
Unlike the DSSS, the CSS does not add any pseudo-random elements to the signal, instead relying on the linear nature of the chirp pulse
-->

#### Why CSS?
CSS provides a low-complexity, low-cost, low-power, yet robust alternative to the traditional SS techniques

## Repetitions in NB-IoT
### Signal Combination
- Devices in extreme coverage conditions blindly repeat information (without any feedback from the receiver)
- The receiver accumulates the blindly transmitted signals and combines all the repetitions
- Repetitions compensate for the $SNR$ degradation $$ \left(SNR\right)_R \text{ (dB)} = \underbrace{10\text{log}_{10}(R)}_{\text{$G_p$}} + \left(SNR\right)_1 $$
    - $(SNR)_R$ is the ideal $SNR$ after combining $R$ transmissions
    - $(SNR)_1$ is the $SNR$ of a single transmission
    - $G_p = 10\text{log}_{10}(R)$ is the processing gain

$$ \left(SNR\right)_R \geq SNR_{threshold} \Rightarrow (SNR)_1 \geq  \underbrace{SNR_{threshold} - 10\text{log}_{10}(R)}_{\text{Reduced $SNR_{threshold}$}}$$

### Processing Gain
- The higher $G_p$ is
    - the lower the SNR threshold of a single transmission is $\Rightarrow$ larger radio coverage
    - the lower the useful data rate is
- In practice, channel estimation (CE) is rarely perfect
- CE errors result in lower processing gain: realistic $G_p < 10\text{log}_{10}(R)$
- Improve CE and consequently $G_p$ through averaging the channel estimates over multiple consecutive subframes (very slowly time-variant channel): \textit{Cross-subframe CE}

<!--
CE quality is limited by the number of pilot symbols and the radio conditions
NB-IoT UE are stationary or have little mobility => the radio channel is very slowly time-variant
-->

## Low Power Consumption
### Deep Sleep Mode
- Most of the IoT applications require infrequent transmission of small data volumes
<!--
- Devices that have had no traffic for a predefined period of time (inactivity timer) are switched to idle mode
-->
- Idle devices may enter a deep sleep mode. They:
    - shut down their transceiver
    - keep track of time and scheduled events via a low-power oscillator (that is kept running)
- Devices wake up from deep sleep mode to:
    - transmit data
    - open receive windows, or monitor paging channels

### Battery Lifetime
- Battery lifetime is further increased through:
    - optimizing data transmission:
        - \small No signaling is required/exchanged when a device needs to transmit data (LoRaWAN)
        - Signaling messages are reduced, in comparison with existing cellular technologies, when a device needs to transmit data (NB-IoT)
    - optimizing device reachability: devices are reachable either periodically, or only after a device-originated data transfer (for a short period of time)

## High Capacity
### Support for Massive Number of Low-Rate Devices
- Trading off data rate for coverage
- How to increase network capacity?
    - LoRaWAN uses multiple orthogonal spreading factors simultaneously on the same frequency channel
    - NB-IoT uses single-tone transmissions in the UL, when coupling loss is high

### Why Single-Tone Transmissions?
- The channel capacity $C$ is given by: $$C = B\text{log}_2 (1+\frac{S}{N}) = B\text{log}_2 (1+\frac{S}{N_0B})$$
    - $N_0$ is the noise power spectral density
- When coupling loss is high, $\frac{S}{N_0B} \ll 1 \Rightarrow \text{ln}(1 + \frac{S}{N_0B}) \approx \frac{S}{N_0B}$.
$$\Rightarrow C = \frac{S}{N_0}\text{log}_2(e)$$
- As $C$ no longer depends on $B$, allocating a single tone (subcarrier) for devices in bad coverage increases network capacity without loss of performance
- The uplink transmit power is concentrated on a narrower bandwidth, thus boosting the received SNR

## Simplified Network Topology and Deployment
### Network Topology and Deployment
- LoRaWAN has a simple network architecture and operates in license-free bands $\Rightarrow$ low-cost deployment
- NB-IoT reuses LTE frequency bands and infrastructure (through software upgrade) $\Rightarrow$ fast time-to-market
\vspace{2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/lpwa-architecture.eps}
\end{figure}
<!--
Star of stars topology
-->
