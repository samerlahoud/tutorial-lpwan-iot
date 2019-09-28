# NB-IoT Design Principles

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

<!--
- Enhanced coverage while maintaining energy consumption is an indispensable characteristic of NB-IoT. 
- To achieve this goal, NB-IoT adopts a new radio access design built from existing LTE.
-->

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
    - limiting message size: Downlink (DL) Transport Block Size (TBS) = 680 bits (R13), or 2536 bits (R14); Uplink (UL) TBS = 1000 bits (R13), or 2536 bits (R14)
    - using simple channel codes: LTE tail-biting convolution code (TBCC) in the DL; LTE turbo code, or repetition code in the UL
    - not using complex modulations or multiple-input multiple-output (MIMO) transmissions: QPSK in the DL; QPSK in the UL multi-tone; $\pi$/4-QPSK, or $\pi$/2- BPSK in the UL single-tone
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
\item Reducing $SNR_{threshold}$ through repetitions and efficient HARQ retransmissions
\end{itemize}

## Repetitions in NB-IoT

### Signal Combination
- Users in extreme coverage conditions blindly repeat information (without any feedback from the receiver)
- The receiver accumulates the blindly transmitted signals and combines all the repetitions
- Repetitions compensate for the $SNR$ degradation

\begin{equation*}
\left(SNR\right)_R \mbox{ (dB)} = \underbrace{10\log_{10}(R)}_{\mbox{$G_p$}} + \left(SNR\right)_1
\end{equation*}

\begin{itemize}
\item[] where $(SNR)_R$ is the ideal $SNR$ after combining $R$ transmissions and $(SNR)_1$ is the $SNR$ of a single transmission.
\end{itemize}

\begin{equation*}
\left(SNR\right)_R \geq SNR_{threshold} \Rightarrow (SNR)_1 \geq  \underbrace{SNR_{threshold} - 10\log_{10}(R)}_{\mbox{Reduced $SNR_{threshold}$}}
\end{equation*}

### Real vs. Ideal Processing Gain
- In practice, channel estimation (CE) is rarely perfect: CE quality is limited by the number of pilot symbols and the radio conditions
- CE errors result in a lower overall processing gain: Real $G_p < 10\log_{10}(R)$
- How to improve $G_p$ in practice?
    - NB-IoT UE are stationary or have little mobility $\Rightarrow$ The NB-IoT channel is very slowly time-variant
    - Average the channel estimates over multiple consecutive subframes, thus improving CE $\Rightarrow$ \textit{cross-subframe CE}

## Low Power Consumption

### Deep Sleep Mode
- Most of the IoT applications require infrequent transmission of small data volumes
- Idle devices may enter a deep sleep mode. They:
    - shut down their transceiver
    - keep track of time and scheduled events via a low-power oscillator (that is kept running)
- Devices wake up from deep sleep mode to:
    - transmit data
    - open receive windows, or monitor paging channels

### Battery Lifetime
\begin{itemize}
\item Battery lifetime is increased through:

    \begin{itemize}
    \item optimizing device reachability: devices monitor paging channels either periodically, or only after a mobile-originated data transfer (for a short period of time).
    \item[] \textit{extended Discontinuous Reception (eDRX)} and \textit{Power-Saving Mode (PSM)} support these operations.
\vspace{2mm}
    \item reducing signaling messages when a device needs to transmit data: suspend/resume (rather than release/re-establish) user plane connection, or transfer data over non-radio signaling
    \end{itemize}
\end{itemize}

## High Capacity

### Support for Massive Number of Low-Rate Devices
- Trading off data rate for coverage
- How to increase network capacity?
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
\item[] $\Rightarrow$ allocate a single tone (subcarrier) for devices in bad coverage to increase network capacity without loss of performance
\end{itemize}

<!--
Moreover, allocating a single tone boosts the uplink power spectral density (concentrates the transmit power on a narrower bandwidth, thus enhancing the received $SNR$.
-->


## Simplified Network Topology and Deployment

### Network Topology and Deployment
- NB-IoT reuses LTE frequency bands and infrastructure (through software upgrade) $\Rightarrow$ fast time-to-market

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/lpwa-architecture.eps}
\end{figure}
<!--
Star of stars topology
-->
