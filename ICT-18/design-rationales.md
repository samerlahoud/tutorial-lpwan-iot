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

- $N$ (dBm) is the background noise power at the receiver $= NT$ (dBm) $+ NF$ (dB)
    - $NT$ is the thermal noise caused by thermal agitation of charge carriers: $-174 + 10\log_{10}(B)$
    - $NF$ is the noise figure caused by RF components

### Maximum Coupling Loss
- The Maximum Coupling Loss ($MCL$) defines the maximum loss the system can cope with between a transmitter and a receiver:

\begin{equation*}
MCL \mbox{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\log_{10}(B) + NF)}_{\mbox{Receiver sensitivity}}
\end{equation*}

\begin{itemize}
\item[] where $P_{Tx}$ is the transmit power in dBm.
\end{itemize}

- Coverage targets are usually specified in terms of $MCL$
- How to improve coverage?

### How to Improve Coverage?
- Increasing $P_{Tx}$, or lowering $NF$ leads to higher device complexity and cost
- Reducing $B$ leads to lower network capacity
- Reducing $SNR_{threshold}$
    - LoRaWAN: optimised radio modulation that uses spread spectrum $\Rightarrow$ LoRa
    - NB-IoT: repetitions and efficient HARQ retransmissions

### What is Spread Spectrum?

\begin{block}{Spread Spectrum (SS)}
Spread-spectrum techniques deliberately spread a signal in the frequency domain, resulting in a signal with a wider bandwidth
\end{block}

- Frequency-hopping SS (FHSS), direct-sequence SS (DSSS), time-hopping SS (THSS), and chirp SS (CSS) are forms of spread spectrum

<!--
..., and combinations of these techniques are forms of SS.
THSS: the transmission time is changed randomly by varying the period and duty cycle of the pulse (within the transmission window) using a pseudo-random sequence.
-->

\begin{figure}
	\centering
	\includegraphics[scale=0.1]{./images/spreading-process.png}
	\caption{Spreading process in DSSS systems}
\end{figure}

### What is Spread Spectrum?

\begin{figure}
	\centering
	\includegraphics[scale=0.11]{./images/de-spreading-process.png}
	\caption{De-spreading process in DSSS systems}
\end{figure}

##### Direct Sequence Spread Spectrum

- At the transmitter, the wanted signal is multiplied with a spreading code
- At the receiver, the wanted signal is re-covered by re-multiplying with the same spreading code

### Radio Quality Indicators

- The $SNR$, or equivalently the carrier-to-noise ratio ($CNR$ or $C/N$), is defined as the ratio of the received signal power $C$ to the power of the noise $N$ within the bandwidth of the transmitted signal  
- The energy per bit to noise power spectral density ratio ($E_ b/N_0$) is defined as the ratio of the energy per bit ($E_b$) to the noise power spectral density ($N_0$)
- $E_b/N_0$ is a normalized $SNR$ measure, also known as the "$SNR$ per bit"
- The $E_b/N_0$ (or $SNR$) needs to be greater than the $E_b/N_0$ (or $SNR$) threshold for acceptable transmission quality (bit error rate ($BER) \leq$ target $BER$)

\begin{equation*}
\frac{E_b}{N_0} \geq \left( \frac{E_b}{N_0}\right)_{threshold} \Rightarrow \mbox{$BER \leq$ $BER_{target}$}
\end{equation*}

##### $SNR$ threshold vs. $E_b/N_0$ threshold
Unlike the $SNR$ threshold, the $E_b/N_0$ threshold does not depend on the signal bandwidth and bit-rate (including any use of spread spectrum)

### Why Spread Spectrum?

\begin{equation*}
SNR = \frac{C}{N} = \frac{E_b/T_b}{N_0B} = \frac{E_b}{N_0}\frac{R_b}{R_c}
\end{equation*}
\begin{itemize}
  \item[] where $B$ is the signal bandwidth in Hz, $R_b$ the bit-rate in b/s, and $R_c$ the chip rate in chip/second
\end{itemize}

\begin{equation*}
\Rightarrow \left( \frac{E_b}{N_0}\right)_{dB} = (SNR)_{dB} + G_p
\end{equation*}
\begin{itemize}
  \item[] where $G_p$ is the processing gain given by: $G_p = 10log_{10}(BT_b) = 10log_{10}(\frac{R_c}{R_b})$
\end{itemize}

- Spread spectrum compensates for the $SNR$ degradation

##### The higher the processing gain is...
- the lower the $SNR$ threshold is $\Rightarrow$ lower receiver sensitivity $\Rightarrow$ larger radio coverage (assuming a fixed transmit signal power)
- the lower $R_b$ is (assuming a fixed $W$)

### $G_p$ and Receiver Sensitivity

- The receiver sensitivity is given by:

\begin{equation*}
S = SNR_{threshold} + \nu
\end{equation*}
\begin{itemize}
  \item[] where $\nu$ is the background noise power at the receiver: sum of the thermal noise (generated by the thermal agitation of charge carriers) and the noise figure (caused by RF components)
\end{itemize}

\setbeamercovered{invisible}

\begin{longtable}[c]{@{}ccc@{}}
\toprule
$R_c/R_b$ & $G_p$ & Receiver sensitivity (dBm) \tabularnewline
\midrule
\endhead
128 & 21.0721 & \uncover<+->{-121} \tabularnewline
256 & 24.0824 & \uncover<+->{-124} \tabularnewline
512 & 27.0927 & \uncover<+->{-127} \tabularnewline
1024 & 30.1030 & \uncover<+->{-130} \tabularnewline
2048 & 33.1133 & \uncover<+->{-133} \tabularnewline
4096 & 36.1236 & \uncover<+->{-136} \tabularnewline
\bottomrule
\end{longtable}

## Chirp Spread Spectrum

### Linear Chirp

\begin{block}{Linear Chirp}
Sinusoidal signal whose frequency linearly increases ($up$-$chirp$) or decreases ($down$-$chirp$) over time
\end{block}

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/chirp.png}
	\caption{A sinusoidal linear up-chirp in the time domain}
\end{figure}

### Linear Chirp Theory

- A linear chirp waveform can be written as:

\begin{equation*}
x(t) = a(t)sin(2 \pi f_0 t + \pi \mu t^2 + \phi_0)
\end{equation*}
\begin{itemize}
  \item[] where $a(t)$ is the envelope of the chirp signal which is zero outside a time interval of length $T$, $f_0$ the initial frequency, $\mu$ the chirp rate, or chirpyness, and $\phi_0$ the initial phase
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
    \includegraphics[scale=0.3]{./images/spectrograms.png}
    \caption{Spectrograms of linear $up$-$chirp$ (top) and  $down$-$chirp$ (bottom)}
\end{figure}

### Bandwidth Spreading

- The bandwidth $B$ is defined as the range of the instantaneous frequency: $B = |\mu| T$
- The processing gain is given by the time-bandwidth product $TB$

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/definitions.png}
\end{figure}

### What is Chirp Spread Spectrum?

\begin{block}{Chirp Spread Spectrum (CSS)}
Spread spectrum technique that uses wideband linear frequency modulated chirps to encode information
\end{block}

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
	\includegraphics[scale=0.37]{./images/bok.pdf}
	\caption{a) BOK using $up$- and $down$- chirps b) BOK using PPM}
\end{figure}

### Advantages of CSS

- CSS is robust to interference, multipath fading, and Doppler effect

- Time and frequency offsets between transmitter and receiver are equivalent, greatly reducing the complexity of the receiver design

<!--
Unlike the DSSS, the CSS does not add any pseudo-random elements to the signal, instead relying on the linear nature of the chirp pulse
-->

#### Why CSS?
CSS provides a low-complexity, low-cost, low-power, yet robust alternative to the traditional SS techniques
