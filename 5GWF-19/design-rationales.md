# Design Principles

### NB-IoT Characteristics
- Main characteristics to meet the mMTC 5G Requirements:
    - Low device complexity and cost
    - Reliability under extreme coverage conditions
    - Low power consumption: long battery lifetime
    - High capacity: support for massive number of low-rate devices
    - Simplified network topology and deployment

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
- Improve CE and consequently $G_p$ through averaging the channel estimates over multiple consecutive subframes (very slowly time-variant channel): \textit{Cross-subframe CE}

<!--
CE quality is limited by the number of pilot symbols and the radio conditions
The radio channel is very slowly time-variant, as NB-IoT UE are stationary or have little mobility
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
    - monitor paging channels

### Battery Lifetime
- Battery lifetime is increased through:
    - optimizing device reachability: 
        - \small Devices monitor paging channels periodically, or only after a mobile- originated data transfer (for a short period of time)
    - reducing signaling messages when a device needs to transmit data

## Device Reachability

### extended Discontinuous Reception (eDRX)
- An eDRX cycle is the time period between two paging occasions a device needs to monitor (up to 2 h, 54 min, and 46 s)
- In between these two occasions, the device is assumed to be in deep sleep mode
- The eDRX cycle is negotiated on a per-device basis

```{=latex}
\begin{figure}
	\centering
	\includegraphics[scale=0.33]{./images/eDRX.pdf}
    \vspace{-2mm}
	\caption*{Two possible eDRX cycle configurations}
\end{figure}
```

### Power-Saving Mode (PSM)
- In PSM, idle devices do not monitor paging channels $\Rightarrow$ unreachability
- A device leaves PSM to send application data or a periodic tracking area update message
\vspace{-2mm}
```{=latex}
\begin{figure}
	\centering
	\includegraphics[scale=0.33]{./images/PSM.pdf}
    \vspace{-2mm}
	\caption*{Operation in PSM including periodic TAU}
\end{figure}
```

### Power-Saving Mode (PSM)
- After data transfer, the device monitors paging occasions until  an active timer expires
- When the active timer expires, the device re-enters PSM and is unreachable until the next mobile-originated event
- The tracking area update period is configurable on a per-device basis (up to a year)

## Data Transmission

### Cell Access
- From idle to connected mode:

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/cell-access.pdf}
\end{figure}

<!--
R15: Semi-Persistent Scheduling:
In general, SPS is comprised of persistent scheduling for initial transmissions and dynamic scheduling for retransmissions (to enable better support of voice messages). 
The base station assigns specific resource units to be used for NB-IoT UE voice messages with specific interval (regular configured periodicity) to save control plane overhead and hence optimize the radio resource usage. 
-->

### Data Transmission Optimization
- Signaling messages, that are required before a device transmits data, are reduced:
    - User Plane Cellular IoT (CIoT) Evolved Packet System (EPS) optimization procedure
        - \small Suspend/resume RRC connection (rather than release/re-establish RRC connection)
        - The device context is maintained at the UE, eNB, and MME during idle mode
    - Control Plane CIoT EPS optimization procedure
        - \small Transfer data over non-radio signaling (DoNAS, Data over Non-Access Stratum)
        - The IP packets are encapsulated in non-radio signaling messages and are sent to the MME
        - The MME extracts the IP packets and forwards them to the S-GW

### Non-IP Data Delivery (NIDD)
- To further reduce device power consumption, non-IP data transfer is also supported
- Non-IP data is transferred over non-radio signaling:
    - Non-IP data is encapsulated in non-radio signaling messages and is sent to the MME
    - The MME extracts the data and forwards it to the SCEF (Service Capability Exposure Function)

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/SCEF.pdf}
\end{figure}

### Service Capability Exposure Function (SCEF)
- SCEF is defined in Release 13
- SCEF provides APIs for small data transfers and control messaging
- The APIs securely expose network capabilities and services. They enable many use cases:
    - Device trigger delivery: wake up and notify a UE to connect to the AS
    - UE reachability and monitoring: check if a UE is currently reachable. If not, send back a notification when it becomes reachable.
    - Network configuration and parameters: set the PSM and eDRX parameters

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
	\includegraphics[scale=0.37]{./images/NB-IoT-architecture+SCEF.pdf}
\end{figure}
