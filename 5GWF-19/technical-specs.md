# Technical Specifications

### NB-IoT and LTE
- NB-IoT is part of the 3GPP specifications: Releases 13, 14, and 15
- NB-IoT adapts and leverages the LTE ecosystem:
    - it reuses many LTE design principles:
        - \small Transmission schemes
        - Protocol architecture
        - Bearer management
        - Security management
        - Mobility management
    - it reuses LTE infrastructure through software upgrade

<!--
- Mobility management is limited to idle mode and is performed through cell reselection (with tracking area updates)
- Handover management is not supported, as NB-IoT is designed for infrequent and short messages
    - Connected devices do not perform mobility measurements
    - In case of connection loss (persistent link-layer failures), they switch to idle mode
    - In idle mode, they initiate cell reselection and then switch back to connected mode
-->

### Deployment Flexibility
- NB-IoT supports three operation modes: in-band (LTE), guard-band (LTE), and standalone ($e.g.,$ refarm the GSM carrier)

\begin{figure}
	\centering
	\includegraphics[scale=0.18]{./images/NB-IoT-operation-modes.pdf}
\end{figure}

- NB-IoT supports frequency division duplex (FDD) and time division duplex (TDD) modes

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

### Radio Interface
- Maximum Transport Block Size (TBS):
    - 680 bits (R13), or 2536 bits (R14), mapped over up to 10 subframes (10 ms) in the DL
    - 1000 bits (R13), or 2536 bits (R14), mapped over up to 10 RUs in the UL
- Modulations:
    - QPSK in the DL
    - QPSK (for multi-tone transmission), $\pi$/4-QPSK, or $\pi$/2-BPSK (for single-tone transmission) in the UL
- Channel codes:
    - LTE tail-biting convolution code (TBCC) in the DL
    - LTE turbo code (for data transfer) and repetition code (for HARQ feedback) in the UL
- Repetitions for coverage enhancement:
    - up to 2048 repetitions in the DL and up to 128 repetitions in the UL
    - 20 dB coverage enhancement over GPRS $\Rightarrow$ sevenfold increase in coverage area (in an open environment), or (deep) indoor penetration
    - Transmission gaps can be configured to avoid long transmissions

<!--
### Mobility Management
- Mobility management is limited to idle mode and is performed through cell reselection (with tracking area updates)
%%%
- Idle devices wake up at the end of each eDRX cycle to perform cell reselection measurements
%%%
- Handover management is not supported, as NB-IoT is designed for infrequent and short messages
    - Connected devices do not perform mobility measurements
    - In case of connection loss (persistent link-layer failures), they switch to idle mode
    - In idle mode, they initiate cell reselection and then switch back to connected mode
-->

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

<!--
- For both uplink and downlink, there are five physical channels:
    - Narrowband Physical Broadcast Channel (NPBCH): Master information for system access.
    - Narrowband Physical Downlink Control Channel (NPDCCH): Scheduling information.
    - Narrowband Physical Downlink Shared Channel (NPDSCH): Downlink dedicated and common data.
    - Narrowband Physical Random Access Channel (NPRACH): Random access.
    - Narrowband Physical Uplink Shared Channel (NPUSCH): Uplink data.
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
- Closed-loop power control requires constant feedback and measurements, and is consequently power consuming
    -  Open-loop power control is supported
- Power control for UL data channels:
    - If the number of repetitions is greater than 2, the transmit power $P$ is the maximum device power: $P = P_{max}$
        - \small R13 defined two device power classes: $P_{max} =$ 20 and 23 dBm
        - R14 introduced one additional device power class: $P_{max} =$ 14 dBm
    - If the number of repetitions is 1 or 2, the transmit power is determined by:
$$ P \mbox{ (dBm)} = \text{max} \left\{ P_{max}, P_{target} + \alpha L + 10 \text{log}_{10} (M)\right\}$$
        - \small $P_{target}$ is the target received power
        - $L$ is the estimated path loss
        - $\alpha$ is a path loss adjustment factor
        - $M$ is a bandwidth adjustment factor

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
