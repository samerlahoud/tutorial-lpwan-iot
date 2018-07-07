# Design Rationale

### Revisiting LPWAN Requirements
- Low device complexity and cost
- Reliability under extreme coverage conditions
- Low power consumption: long battery lifetime
- High capacity: support for massive number of low-rate devices
- Simplified network topology and deployment

## Low Device Complexity and Cost

### Device Complexity and Cost
- Devices are mainly composed of:
    - a processing unit: usually a microcontroller with a limited amount of memory
    - a sensing unit: sensors and analog to digital converters
    - a radio unit: usually a transceiver capable of bidirectional communications

- The radio unit complexity and cost are primarily related to the complexity of:
    - digital baseband processing
    - radio-frequency (RF) analog processing

### Digital Baseband Processing
- Reduce baseband processing complexity through:
    - limiting message size:
    - using simple channel codes:
    - not using complex modulations or multiple-input multiple-output (MIMO) transmissions
    - supporting only half-duplex operation: no simultaneous transmission and reception

### RF Processing
- Reduce RF processing complexity and cost through:
    - using one transmit-and-receive antenna
    - not using a duplexer (since only half-duplex operation is supported)
    - on-chip integrating power amplifier $\Rightarrow$ single-chip modem implementation (since transmit power is limited)

## Reliability Under Extreme Coverage Conditions

### Radio Quality
- Reliability $\Rightarrow$ bit error rate ($BER$) $\leq$ target $BER$
- The energy per bit to noise power spectral density ratio ($E_ b/N_0$) is defined as the ratio of the energy per bit ($E_b$) to the noise power spectral density ($N_0$)

```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.43]{./images/qpsk-perf-1.pdf}
	\includegraphics<2>[scale=0.43]{./images/qpsk-perf-2.pdf}
\end{figure}
```

### Radio Quality
\begin{equation*}
\mbox{$BER \leq$ $BER_{target}$} \Leftrightarrow \frac{E_b}{N_0} \geq \left( \frac{E_b}{N_0}\right)_{threshold}
\end{equation*}

- $(E_b/N_0)_{threshold}$ does not depend on the signal bandwidth and bit-rate
- The $SNR$, or equivalently the carrier-to-noise ratio ($CNR$ or $C/N$), is defined as the ratio of the received signal power $C$ to the power of the noise $N$ within the bandwidth of the transmitted signal

\begin{equation*}
SNR = \frac{C}{N} = \frac{E_b/T_b}{N_0B} = \frac{E_b}{N_0}\frac{R_b}{B}
\end{equation*}
\begin{itemize}
  \item[] where $B$ is the signal bandwidth in Hz, and $R_b$ is the bit-rate in b/s.
\end{itemize}

### Receiver Sensitivity
\begin{table}
\centering
\begin{tabular}{c c c}
$BER$ $\leq$ $BER_{target}$& $\Leftrightarrow$ &$SNR$ $\geq \underbrace{\left(\frac{E_b}{N_0}\right)_{threshold} \frac{R_b}{B}}_{SNR_{threshold}}$ \\
&&\\
& $\Leftrightarrow$& $S$ (dBm) $\geq \underbrace{SNR_{threshold}\mbox{ (dB) } + N \mbox{ (dBm)}}_{\mbox{Receiver sensitivity}}$ \\
\end{tabular}
\end{table}

- $N$ (dBm) is the background noise power at the receiver $= TN$ (dBm) $+ NF$ (dB)
    - $TN$ is the thermal noise caused by thermal agitation of charge carriers: $-174 + 10\log_{10}(B)$
    - $NF$ is the noise figure caused by RF components

### Maximum Coupling Loss
- The Maximum Coupling Loss ($MCL$) defines the maximum loss the system can cope with between a transmitter and a receiver:

\begin{equation*}
MCL \mbox{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\log_{10}(B) + NF)}_{\mbox{Receiver sensitivity}}
\end{equation*}

\begin{itemize}
\item[] where $P_{Tx}$ is the transmit power in dBm.
\end{itemize}

\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.34]{./images/MCL.pdf}
\end{figure}

### How to Improve Coverage?
\begin{itemize}
\item Coverage targets are usually specified in terms of $MCL$
\item Increasing $P_{Tx}$, or lowering $NF$, leads to higher device complexity and cost
\item[] $\Rightarrow$ inadequate solutions
\item Reducing $B$ leads to lower network capacity $\Rightarrow$ inadequate solution
\item Reducing $SNR_{threshold}$ through optimized radio modulation that uses spread spectrum $\Rightarrow$ LoRa
\end{itemize}

## Chirp Spread Spectrum in LoRaWAN

### What is Spread Spectrum?
- Spread-spectrum techniques deliberately spread a signal in the frequency domain, resulting in a signal with a wider bandwidth
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
- Spread spectrum compensates for the $SNR$ degradation

\begin{equation*}
SNR = \frac{E_b}{N_0}\frac{R_b}{B} \Rightarrow \left( \frac{E_b}{N_0}\right)_{dB} = (SNR)_{dB} + G_p
\end{equation*}
\begin{itemize}
  \item[] where $G_p$ is the processing gain given by: $G_p = 10\log_{10}(T_bB)$
\end{itemize}

\begin{equation*}
SNR_{threshold} = \left( \frac{E_b}{N_0}\right)_{threshold} - G_p
\end{equation*}

- The higher $G_p$ is
    - the lower $SNR_{threshold}$ is $\Rightarrow$ larger radio coverage
    - the lower $R_b$ is

### Linear Chirp
- A linear chirp is a sinusoidal signal whose frequency linearly increases ($up$-$chirp$) or decreases ($down$-$chirp$) over time
\vspace{-3mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/chirp-1.pdf}
    \vspace{-5mm}
	\caption*{A sinusoidal linear up-chirp in the time domain}
\end{figure}

### Linear Chirp Theory
- A linear chirp waveform can be written as:

\begin{equation*}
x(t) = a(t)sin(2 \pi f_0 t + \pi \mu t^2 + \phi_0)
\end{equation*}
\begin{itemize}
  \item[] where $a(t)$ is the envelope of the chirp signal which is zero outside a time interval of length $T$, $f_0$ the initial frequency, $\mu$ the chirp rate, or chirpyness, and $\phi_0$ the initial phase.
\end{itemize}

- The instantaneous frequency $f(t)$ is defined as:

\begin{equation*}
f(t) = \frac{1}{2 \pi} \frac{d(2 \pi f_0 t + \pi \mu t^2 + \phi_0)}{dt} = f_0 + \mu t
\end{equation*}

- The chirp rate $\mu$ represents the rate of change of the instantanous frequency:

\begin{equation*}
\mu = \frac{df(t)}{dt}
\end{equation*}

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
    - $M$ bits are encoded by transmitting a single $chirp$ in one of $2^M$ possible time shifts $\Rightarrow$ bit-rate = $M/T$ in b/s
    - Chirps are not transmitted in equidistant time steps
- At the receiver, the wanted information is re-covered through de-chirping
<!--
multiply with the complexe conjugate of the chirp signal
-->

### Example: Binary Orthogonal Keying (BOK) Schemes

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

## Low Power Consumption

### Deep Sleep Mode
- Most of the IoT applications require infrequent transmission of small data volumes
- Idle devices may enter a deep sleep mode and shut down their transceiver
- Devices wake up from deep sleep mode to:
    - transmit data
    - open receive windows
- Battery lifetime is increased through:
    - optimizing device reachability
    - reducing signaling messages when a device needs to transmit data

## High Capacity

### Support for Massive Number of Low-Rate Devices
- Trading off data rate for coverage
- How to increase network capacity?
    - LoRaWAN uses multiple orthogonal spreading factors simultaneously on the same channel

## Simplified Network Topology and Deployment

### Network Topology and Deployment
- LoRaWAN has a simple network architecture and operates in license-free bands $\Rightarrow$ low-cost deployment

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/lpwa-architecture.eps}
\end{figure}
