# NB-IoT Technical Specifications

### What is NB-IoT?
- NB-IoT is part of the 3GPP LTE specifications: Releases 13 and 14
- NB-IoT adapts and leverages the LTE ecosystem:
    - it reuses many LTE design principles:
        - \small Transmission schemes
        - Protocol architecture
        - Bearer management
        - Security management
        - Mobility management
    - it reuses LTE infrastructure through software upgrade

### Deployment Flexibility
- NB-IoT supports three operation modes: in-band (LTE), guard-band (LTE), and standalone ($e.g.,$ refarm the GSM carrier)

\begin{figure}
	\centering
	\includegraphics[scale=0.18]{./images/NB-IoT-operation-modes.pdf}
\end{figure}

### Radio Interface
- Channel bandwidth: 180 kHz $\equiv$ 1 LTE Physical Resource Block (PRB) in the frequency domain
- Transmission schemes:
    - OFDMA (subcarrier spacing $\Delta f = 15$ kHz) in the DL
    - SC-FDMA ($\Delta f = 15$ kHz or 3.75 kHz) in the UL
- Smallest schedulable unit:
    - 1 PRB = 180 kHz (12 subcarriers) over 1 ms (1 subframe) in the DL
    - 1 Resource Unit (RU) in the UL
        - \small 180 kHz (12 subcarriers) over 1 ms
        - 90 kHz (6 subcarriers) over 2 ms
        - 45 kHz (3 subcarriers) over 4 ms
        - 15 kHz (1 subcarrier) over 8 ms
        - 3.75 kHz (1 subcarrier) over 32 ms
- Maximum Transport Block Size (TBS):
    - 680 bits (R13), or 2536 bits (R14), mapped over up to 10 subframes (10 ms) in the DL

### Radio Interface
\begin{itemize}
\item[]
\begin{itemize}
    \item 1000 bits (R13), or 2536 bits (R14), mapped over up to 10 RUs in the UL
\end{itemize}
\item Modulations:
\begin{itemize}
    \item QPSK in the DL
    \item QPSK (for multi-tone transmission), $\pi$/4-QPSK, or $\pi$/2-BPSK (for single-tone transmission) in the UL
\end{itemize}
\item Channel codes:
\begin{itemize}
    \item LTE tail-biting convolution code (TBCC) in the DL
    \item LTE turbo code (for data transfer) and repetition code (for HARQ feedback) in the UL
\end {itemize}
\item Repetitions for coverage enhancement:
\begin{itemize}
    \item up to 2048 repetitions in the DL and up to 128 repetitions in the UL
    \item 20 dB coverage enhancement over GPRS $\Rightarrow$ sevenfold increase in coverage area (in an open environment), or (deep) indoor penetration
    \item Transmission gaps can be configured to avoid long transmissions
\end {itemize}
\end {itemize}

### Device Reachability
- To reduce device power consumption, devices that have had no traffic for a predefined period of time (inactivity timer) are switched to idle mode
- Idle devices monitor paging channels either periodically, or only after a mobile-originated data transfer (for a short period of time)
    - extended Discontinuous Reception (eDRX)
    - Power-Saving Mode (PSM)

### extended Discontinuous Reception (eDRX)
- An eDRX cycle is the time period between two paging occasions a device needs to monitor (up to 2 h, 54 min, and 46 s)
- In between these two occasions, the device is assumed to be in deep sleep mode
- The eDRX cycle is negotiated on a per-device basis

\begin{figure}
	\centering
	\includegraphics[scale=0.33]{./images/eDRX.pdf}
    \vspace{-2mm}
	\caption*{Two possible eDRX cycle configurations}
\end{figure}

### Power-Saving Mode (PSM)
- In PSM, idle devices do not monitor paging channels $\Rightarrow$ unreachability
- A device leaves PSM to send application data or a periodic tracking area update message
\vspace{-2mm}
\begin{figure}
	\centering
	\includegraphics[scale=0.33]{./images/PSM.pdf}
    \vspace{-2mm}
	\caption*{Operation in PSM including periodic TAU}
\end{figure}

### Power-Saving Mode (PSM)
- After data transfer, the device monitors paging occasions until  an active timer expires
- When the active timer expires, the device re-enters PSM and is unreachable until the next mobile-originated event
- The tracking area update period is configurable on a per-device basis (up to a year)

### Cell Access
- From idle to connected mode:

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/cell-access.pdf}
\end{figure}

### Data Transport
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

### Physical Architecture
\begin{figure}
	\centering
	\includegraphics[scale=0.37]{./images/NB-IoT-architecture+SCEF.pdf}
\end{figure}

### Mobility Management
- Mobility management is limited to idle mode and is performed through cell reselection (with tracking area updates)
<!--
- Idle devices wake up at the end of each eDRX cycle to perform cell reselection measurements
-->
- Handover management is not supported, as NB-IoT is designed for infrequent and short messages
    - Connected devices do not perform mobility measurements
    - In case of connection loss (persistent link-layer failures), they switch to idle mode
    - In idle mode, they initiate cell reselection and then switch back to connected mode

### Uplink Scheduling
- Scheduling information is transmitted in the Downlink Control Information (DCI) message
- UL scheduling information includes:
    - resource allocation (in time and frequency domains): subcarrier indication and number of RUs
    - Modulation and Coding Scheme (MCS)
    - number of repetitions
    - scheduling delay: time gap between the last DCI and the first scheduled UL subframe ($\geq$ 8 ms)
- A TB can be mapped over multiple RUs, allowing more redundancy bits for channel coding
- The scheduling delay allows the device to decode the DCI message, switch to transmission mode, and prepare for the UL transmission
- After data transmission, the device has at least 3 ms to switch to reception mode and monitor the next DCI message

<!--
- The modulation format is determined based on the MCS index
- The TBS and the code rate are based on the MCS index and the number of RUs
-->

### Uplink Scheduling
- An uplink scheduling example\footnote{O. Liberg et al., \textit{Cellular Internet of Things - Technologies, Standards, and Performance}. Cambridge, MA, USA: American Press, 2017.}:

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/UL-scheduling.pdf}
\end{figure}

### Downlink Scheduling
- The general aspects of DL scheduling are similar to those of UL scheduling
- DL scheduling information includes:
    - resource allocation: number of subframes per repetition
    - MCS
    - number of repetitions
    - scheduling delay ($\geq$ 4 ms)
    - HARQ-Ack resource: subcarrier index and time offset
- Resources for HARQ feedback are also scheduled
- After HARQ feedback transmission, the device has at least 3 ms to switch to reception mode and monitor the next DCI message

### Power Control
\begin{itemize}
\item Closed-loop power control requires constant feedback and measurements, and is consequently power consuming
\item[] $\Rightarrow$ open-loop power control is supported
\item Power control for UL data channels:

\begin{itemize}

    \item If the number of repetitions is greater than 2, the transmit power $P$ is the maximum device power: $P = P_{max}$

    \begin{itemize}
        \item \small R13 defined two device power classes: $P_{max} =$ 20 and 23 dBm
        \item R14 introduced one additional device power class: $P_{max} =$ 14 dBm
    \end{itemize}

    \item If the number of repetitions is 1 or 2, the transmit power is determined by:
\end{itemize}
\end{itemize}
\begin{equation*}
P \mbox{ (dBm)} = \max \left\{ P_{max}, P_{target} + \alpha L + 10 \log_{10} (M)\right\}
\end{equation*}

\begin{itemize}
\item[]
\begin{itemize}

\item[] where $P_{target}$ is the target received power, $L$ is the estimated path loss, $\alpha$ is a path loss adjustment factor, and $M$ is a bandwidth adjustment factor
\end{itemize}
\end{itemize}

### Power Control
- $M$ relates $P_{target}$ to target $SNR$

| Bandwidth (kHz) | $M$ |
|:-----------:|:------:|
| 3.75 | 1/4 |
| 15 | 1 |
| 45 | 3 |
| 90 | 6 |
| 180 | 12 |

- $P_{max}$, $P_{target}$, and $\alpha$ are provided by higher-layer configuration signaling
