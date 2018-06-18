# Design Rationale

### Revisiting LPWAN Requirements
- Low device complexity and cost
- Reliability under extreme coverage conditions
- Low power consumption: long battery lifetime
- High capacity: support for massive number of low-rate devices
- Simplified network topology and deployment

#### Objectives and Approaches
\begin{itemize}
\item Develop a \textit{clean-slate} technology that meets the LPWAN requirements
\vspace{-1mm}
\item[] $\Rightarrow$ LoRaWAN
\item Adapt and leverage existing 4G technology to meet the LPWAN requirements
\vspace{-1mm}
\item[] $\Rightarrow$ NB-IoT
\end{itemize}

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
        - \small LoRaWAN: maximum application payload size between 51 and 222 bytes, depending on the spreading factor
        - NB-IoT: Downlink (DL) Transport Block Size (TBS) = 680 bits (R13), or 2536 bits (R14); Uplink (UL) TBS = 1000 bits (R13), or 2536 bits (R14)
    - using simple channel codes:
        - \small LoRaWAN: Hamming code
        - NB-IoT: LTE tail-biting convolution code (TBCC) in the DL; LTE turbo code, or repetition code in the UL
    - not using higher-order modulations or multiple-input multiple-output (MIMO) transmissions
        - \small LoRaWAN: LoRa
        - NB-IoT: QPSK in the DL; QPSK in the UL multi-tone; $\pi$/4-QPSK, or $\pi$/2- BPSK in the UL single-tone
    - supporting only half-duplex operation: no simultaneous transmission and reception

### RF Processing
- Reduce RF processing complexity and cost through:
    - using one transmit-and-receive antenna
    - not using a duplexer (since only half-duplex operation is supported)
    - on-chip integrating power amplifier (since transmit power is limited)

## Reliability under extreme coverage conditions

### Radio Quality
- Reliability $\Rightarrow$ bit error rate ($BER$) $\leq$ target $BER$
- The energy per bit to noise power spectral density ratio ($E_ b/N_0$) is defined as the ratio of the energy per bit ($E_b$) to the noise power spectral density ($N_0$)
\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.43]{./images/qpsk-perf-1.pdf}
	\includegraphics<2>[scale=0.43]{./images/qpsk-perf-2.pdf}
\end{figure}

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
\item Reducing $SNR_{threshold}$
\begin{itemize}
\item LoRaWAN: optimised radio modulation that uses spread spectrum $\Rightarrow$ LoRa
\item NB-IoT: repetitions and efficient HARQ retransmissions
\end{itemize}
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

## Repetitions in NB-IoT

### Signal Combination
- Users in extreme coverage conditions blindly repeat information (without any feedback from the receiver)
- The receiver accumulates the blindly transmitted signals and combines all the repetitions
- Repetitions compensate for the $SNR$ degradation

\begin{equation*}
\left(SNR\right)_N \mbox{ (dB)} = \underbrace{10\log_{10}(N)}_{\mbox{$G_p$}} + \left(SNR\right)_1
\end{equation*}

\begin{itemize}
\item[] where $(SNR)_N$ is the ideal $SNR$ after combining $N$ transmissions and $(SNR)_1$ is the $SNR$ of a single transmission.
\end{itemize}

\begin{equation*}
\left(SNR\right)_N \geq SNR_{threshold} \Rightarrow (SNR)_1 \geq  \underbrace{SNR_{threshold} - 10\log_{10}(N)}_{\mbox{Reduced $SNR_{threshold}$}}
\end{equation*}

### Real vs. Ideal Processing Gain
- In practice, combining two signals is rarely perfect: signal impairments will result in a lower overall processing gain
- For $N$ between 2 and 16, the ideal gain can be achieved without any visible degradation\footnote{Simulations have been carried out for EC-GSM-IoT in O. Liberg et al., \textit{Cellular Internet of Things - Technologies, Standards, and Performance}. Cambridge, MA, USA: American Press, 2017.}

## Low power consumption

### Battery Lifetime
\begin{itemize}
\item As most of the IoT applications require infrequent transmission of small data volumes, battery lifetime is increased through:

\begin{itemize}
    \item optimizing device reachability:

    \begin{itemize}
        \item \small LoRaWAN: Class A devices open two short DL receive windows only after an uplink transmission.
        \item[] Class B devices extend Class A by adding scheduled receive windows.
\vspace{2mm}

        \item NB-IoT: devices monitor paging channels either periodically, or only after a mobile-originated data transfer (for a short period of time).
        \item[] \textit{extended Discontinuous Reception (eDRX)} and \textit{Power-Saving Mode (PSM)} support these operations.
    \end{itemize}
\end{itemize}
\end{itemize}

### Battery Lifetime

\begin{itemize}
\item[]
\begin{itemize}
\item reducing signaling messages when a device needs to transmit data
\begin{itemize}
\item \small LoRaWAN: uncoordinated data transmission
\item NB-IoT: the device context is maintained during power-saving states, avoiding unnecessary signaling
\end{itemize}
\end{itemize}
\end{itemize}

- Idle devices enter in deep sleep mode. They:
    - shut down their transceiver
    - keep track of time and scheduled events via a low-power oscillator (that is kept running)
- Devices wake up from deep sleep to:
    - transmit data
    - open receive windows, or monitor paging channels

## High capacity

### Support for Massive Number of Low-Rate Devices
- Trading off data rate for coverage
- How to increase network capacity?
    - LoRaWAN uses multiple orthogonal spreading factors simultaneously on the same channel
    - NB-IoT uses single-tone transmissions in the UL when coupling loss is high

### Why Single-Tone Transmissions?
- The channel capacity $C$ is given by:

\begin{equation*}
C = B\log_2 (1+\frac{S}{N}) = B\log_2 (1+\frac{S}{N_0B})
\end{equation*}

- When coupling loss is high, $\frac{S}{N_0B} \ll 1 \Rightarrow \ln(1 + \frac{S}{N_0B}) \approx \frac{S}{N_0B}$.

\begin{equation*}
\Rightarrow C = \frac{S}{N_0}\log_2(e)
\end{equation*}

\begin{itemize}
\item[] $C$ no longer depends on $B$
\item[] $\Rightarrow$ allocate a single tone (subcarrier) for devices in bad coverage to avoid resource wastage
\end{itemize}

## Simplified Network Topology and Deployment

### Network Topology and Deployment
- LoRaWAN has a simple network architecture and operates in license-free bands $\Rightarrow$ low-cost deployment
- NB-IoT reuses LTE frequency bands and infrastructure (through software upgrade) $\Rightarrow$ fast time-to-market
