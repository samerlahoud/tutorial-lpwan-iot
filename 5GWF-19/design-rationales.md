# NB-IoT Design Principles

### Revisiting LPWAN Requirements
- Low device complexity and cost
- Reliability under extreme coverage conditions
- Low power consumption: long battery lifetime
- High capacity: support for massive number of low-rate devices
- Simplified network topology and deployment

#### NB-IoT Objective and Approach
Adapt and leverage existing 4G technology to meet the LPWAN requirements

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
    - limiting message size: 
        - \small Downlink (DL) Transport Block Size (TBS) = 680 bits (R13), or 2536 bits (R14); Uplink (UL) TBS = 1000 bits (R13), or 2536 bits (R14)
    - using simple channel codes: 
        - \small LTE tail-biting convolution code (TBCC) in the DL; LTE turbo code, or repetition code in the UL
    - not using complex modulations or multiple-input multiple-output (MIMO) transmissions:
        - \small QPSK in the DL; QPSK in the UL multi-tone; $\pi$/4-QPSK, or $\pi$/2- BPSK in the UL single-tone
    - supporting only half-duplex operation: no simultaneous transmission and reception

### RF Processing
- Reduce RF processing complexity and cost through:
    - using one transmit-and-receive antenna
    - not using a duplexer (since only half-duplex operation is supported)
    - on-chip integrating power amplifier $\Rightarrow$ single-chip modem implementation (since transmit power is limited)

## Reliability Under Extreme Coverage Conditions

### Radio Quality
- Reliability $\Rightarrow$ bit error rate ($BER$) $\leq$ target $BER$
- The $SNR$, or equivalently the carrier-to-noise ratio ($CNR$ or $C/N$), is defined as the ratio of the received signal power $C$ to the power of the noise $N$ within the bandwidth of the transmitted signal

```{=latex}
\vspace{-0.7cm}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.55]{./images/qpsk-perf-1-snr.pdf}
	\includegraphics<2>[scale=0.55]{./images/qpsk-perf-2-snr.pdf}
\end{figure}
```

### Receiver Sensitivity
\begin{table}
\centering
\begin{tabular}{c c l}
$BER$ $\leq$ $BER_{target}$ & $\Leftrightarrow$ & $SNR \geq SNR_{threshold}$ \\
&&\\
& $\Leftrightarrow$& $S$ (dBm) $\geq \underbrace{SNR_{threshold}\text{ (dB) } + N \text{ (dBm)}}_{\text{Receiver sensitivity}}$ \\
\end{tabular}
\end{table}

- $N$ (dBm) is the background noise power at the receiver $= TN$ (dBm) $+ NF$ (dB)
    - $TN$ is the thermal noise caused by thermal agitation of charge carriers: $-174 + 10\text{log}_{10}(B)$
    - $NF$ is the noise figure caused by RF components

### Maximum Coupling Loss
- The Maximum Coupling Loss ($MCL$) defines the maximum loss the system can cope with between a transmitter and a receiver: $$ MCL \text{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\text{log}_{10}(B) + NF)}_{\text{Receiver sensitivity}}$$
    - $P_{Tx}$ is the transmit power (dBm)

\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.34]{./images/MCL.pdf}
\end{figure}

### How to Improve Coverage?

- Coverage targets are usually specified in terms of $MCL$
- Increasing $P_{Tx}$, or lowering $NF$, leads to higher device complexity and cost
- Reducing $B$ leads to lower network capacity
- Improve coverage by reducing $SNR_{threshold}$ through repetitions and efficient HARQ retransmissions

## Repetitions

### Signal Combination
- Devices in extreme coverage conditions blindly repeat information (without any feedback from the receiver)
- The receiver accumulates the blindly transmitted signals and combines all the repetitions
- Repetitions compensate for the $SNR$ degradation
$$ \left(SNR\right)_R \text{ (dB)} = 10\text{log}_{10}(R) + \left(SNR\right)_1$$
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
- As NB-IoT UE are stationary or have little mobility, the radio channel is very slowly time-variant
- Improve CE and consequently $G_p$ through averaging the channel estimates over multiple consecutive subframes $\Rightarrow$ \textit{Cross-subframe CE}

<!--
CE quality is limited by the number of pilot symbols and the radio conditions
-->

## Low Power Consumption

### Deep Sleep Mode
- Most of the IoT applications require infrequent transmission of small data volumes
- Idle devices may enter a deep sleep mode. They:
    - shut down their transceiver
    - keep track of time and scheduled events via a low-power oscillator (that is kept running)
- Devices wake up from deep sleep mode to:
    - transmit data
    - monitor paging channels

### Battery Lifetime
- Battery lifetime is increased through:
    - optimizing device reachability: 
        - \small Devices monitor paging channels periodically, or only after a mobile- originated data transfer (for a short period of time)
        - \small \textit{extended Discontinuous Reception (eDRX)} and \textit{Power-Saving Mode (PSM)} support these operations
    - reducing signaling messages when a device needs to transmit data:
        - \small Suspend/resume user plane connection (instead of release/re-establish user plane connection), or transfer data over non-radio signaling

## High Capacity

### Support for Massive Number of Low-Rate Devices
- Trading off data rate for coverage
- Increase network capacity through using single-tone transmissions in the UL, when coupling loss is high

### Why Single-Tone Transmissions?
- The channel capacity $C$ is given by: $$C = B\text{log}_2 (1+\frac{S}{N}) = B\text{log}_2 (1+\frac{S}{N_0B})$$
- When coupling loss is high, $\frac{S}{N_0B} \ll 1 \Rightarrow \text{ln}(1 + \frac{S}{N_0B}) \approx \frac{S}{N_0B}$.
$$\Rightarrow C = \frac{S}{N_0}\text{log}_2(e)$$
- As $C$ no longer depends on $B$, allocating a single tone (subcarrier) for devices in bad coverage increases network capacity without loss of performance
- The uplink transmit power is concentrated on a narrower bandwidth, thus boosting the received SNR

## Simplified Network Topology and Deployment

### Network Topology and Deployment
- NB-IoT reuses LTE frequency bands and infrastructure (through software upgrade) $\Rightarrow$ fast time-to-market

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/lpwa-architecture.eps}
\end{figure}
