# Technical Specifications
## LoRaWAN

### From LoRa to LoRaWAN
- LoRa
    - Modulation technique for LPWAN
- LoRaWAN
    - Uses LoRa modulation on physical layer
    - Proposes a MAC layer for access control
    - Specified by LoRa Alliance

### LoRaWAN Timeline
- Cycleo first introduced LoRa in 2009
    - M2M communications
    - Large coverage
- Semtech acquired Cycleo in 2012
    - Patents filed in 2014
- LoRa Alliance initiated in 2014
    - Actility, Cisco, Bouygues, IBM, Orange, SK Telecom, KPN, ZTE, Semtech, La Poste, SoftBank, Swisscom, etc.
    - LoRaWAN 1.0.3 specification in 2018

## Radio Interface

### What is LoRa?

\begin{block}{Definition of LoRa}
LoRa is a wireless modulation technique that uses Chirp Spread Spectrum (CSS) in combination with Pulse-Position Modulation (PPM)
\end{block}

- Processing gain given by $g_p = BT$
- Variable number of bits encoded in a symbol

$$R_b = \frac{\text{log}_2 (g_p)}{T} = \text{log}_2 (g_p) \cdot \frac{B}{g_p}$$

- Spreading factor $SF$ given by $\text{log}_2 (g_p)$

$$R_b = SF \cdot \frac{B}{2^{SF}}$$

### LoRa Symbols
- $\text{log}_2 (g_p)$ bits are encoded by transmitting a single $chirp$ in $g_p$ possible cyclic time shifts
- Example: $g_p = 4$ $\Rightarrow$ 2 bits/symbol

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/lora-symbols.pdf}
\end{figure}

### LoRa Bit-Rate
- LoRa includes a variable error correction scheme based on Hamming code
    - Improve the robustness of the transmitted signal at the expense of redundancy
- Given a coding rate $CR$, the bit-rate is given by:

\begin{equation*}
R_b = SF \cdot \frac{B}{2^{SF}} \cdot CR
\end{equation*}

- $R_b$ can also be written as:

\begin{equation*}
R_b = SF \cdot \frac{B}{2^{SF}} \cdot \frac{4}{4+CR}
\end{equation*}
$$\text{with } 1 \leq CR \leq 4,\text{and } 6 \leq SF \leq 12$$

### LoRa Spreading Factors
- LoRa uses spreading factors from 6 to 12 (6 is not used in LoRaWAN)

\begin{figure}
	\centering
	\includegraphics[scale=0.25]{./images/sf-comparison.eps}
\end{figure}

### LoRa Radio Performance

| Spreading Factor  | Bit Rate\footnote{$CR$ = 1 and $B$ = 125 kHz} (kb/s) |  Sensitivity (dBm) |
|:---:|:---:|:---:|
| 6\footnote{Spreading factor 6 is not used in LoRaWAN} | 9.375 | -118 |
| 7 | 5.468 | -123 |
| 8 | 3.125 | -126 |
| 9 | 1.757 | -129 |
| 10 | 0.976 | -132 |
| 11 | 0.537 | -134.5 |
| 12 | 0.293 | -137 |

-  Higher spreading factors lead to lower sensitivity and larger coverage
-  Lower spreading factors lead to higher data rates

### Spreading Factor and Time on Air
- The Time on Air is defined as the time required to transmit a packet in a sub-band
- The selection of the spreading factor impacts the Time on Air and consequently determines the duty cycle limitation

\begin{figure}
	\centering
  \includegraphics[scale=0.35]{./images/timeonair.eps}
\end{figure}

### LoRa Physical Layer
- LoRa transmission consists of:
    - 8 preamble ($up$-$chirp$) symbols
    - 2 synchronization ($down$-$chirp$) symbols
    - 5 modulated symbols (payload)
    - Up to 255 bytes of payload

\begin{figure}
	\centering
	\includegraphics[scale=0.45]{./images/phy-layer.pdf}
\end{figure}

### LoRaWAN Data Rates

| Data rate |    Configuration    | Indicative Physical Bit Rate |
|:---------:|:-------------------:|:-----------------:|
|     0     | LoRa SF12 / 125 kHz |        250        |
|     1     | LoRa SF11 / 125 kHz |        440        |
|     2     | LoRa SF10 / 125 kHz |        980        |
|     3     |  LoRa SF9 / 125 kHz |        1760       |
|     4     |  LoRa SF8 / 125 kHz |        3125       |
|     5     |  LoRa SF7 / 125 kHz |        5470       |
|     6     |  LoRa SF7 / 250 kHz |       11000       |
|     7     |     FSK: 50 kbps    |       50000       |
|   8...14  |         RFU         |                   |
|     15    |  Defined in LoRaWAN |                   |

### Data Rates and Energy Consumption
\begin{figure}
	\centering
  \includegraphics[scale=0.2]{./images/energy-sf-lorawan.png}
  \caption*{Source: Lluís Casals {\it et al.}, Modeling the Energy Performance of LoRaWAN, Sensors, 2017}
\end{figure}

- For an end-device sending packets every 100 minutes, changing the spreading factor from 12 (DR0) to 7 (DR6) increases its lifetime by almost 1.5 years

### LoRaWAN Channels

- Operates in license-free bands all around the world
    - 433, 868 (EU), 915 MHz
- EU 863-870MHz ISM Band
    - Default radiated transmit output power by devices: 14 dBm
    - Minimum set of three channels, maximum of 16 channels

|Modulation | Bw [kHz] | Freq [MHz] | Data Rate | Nb Channels | Duty cycle
|-------|-------|---------|--------|---------|--------------------
|LoRa | 125 | 868.10  | DR0 to DR5   | 3 | <1%
|        |        | 868.30  | 0.3-5 kbps      |    |
|        |        | 868.50  |                        |    |


### ETSI Limitations

- Restrictions on the maximum time the transmitter can be on or the maximum time a transmitter can transmit per hour
- Choice between
    - Duty-cycle limitation
    - Listen Before Talk Adaptive Frequency Agility (LBT AFA) transmissions management
- The current LoRaWAN specification exclusively uses duty-cycled limited transmissions to comply with the ETSI regulations

### Duty Cycle Limitation
- The LoRaWAN enforces a per sub-band duty-cycle limitation

    - Each time a frame is transmitted in a given sub-band, the time of emission and the on-air duration of the frame are recorded for this sub-band
    - The same sub-band cannot be used again during the next $T_{off}$ seconds where: $$T_{off} = \frac{TimeOnAir}{DutyCyleSubband}- TimeOnAir$$
    - During the unavailable time of a given sub-band, the device may still be able to transmit on another sub-band
    - The device adapts its channel hopping sequence according to the sub-band availability

#### Example

A device just transmitted a 0.5 s long frame on one default channel. This channel is in a sub-band allowing 1% duty-cycle. Therefore this whole sub-band (868 – 868.6) will be unavailable for 49.5 s

## Physical Architecture

### LoRaWAN General Architecture
- LoRaWAN network architecture is typically laid out in a star-of-stars topology
    - End-devices
    - Gateways
    - Network server  

\begin{figure}
		\includegraphics[scale=0.5]{./images/lorawan-archi.eps}
\end{figure}

### End-Devices
\begin{figure}
\includegraphics[scale=0.5]{./images/lorawan-archi.eps}
\end{figure}

- End-devices are also called motes or devices
    - Communicate to one or more gateways via a wireless interface using single hop LoRa or FSK

### Gateways
\begin{figure}
\includegraphics[scale=0.5]{./images/lorawan-archi.eps}
\end{figure}
- Gateways are also called concentrators or base stations
    - Forward Frames between devices and network server
    - Connected to the network server via IP interfaces

### Network Server
\begin{figure}
\includegraphics[scale=0.5]{./images/lorawan-archi.eps}
\end{figure}
- Network server is a central server located at the backend
    - Provides mobility, frame control, and security functions
    - Adapts data transmission rates

<!--
### LoRaWAN General Characteristics
- LoRaWAN network architecture is typically laid out in a star-of-stars topology
- All end-point communication is generally bi-directional
    - Uplink communications are predominant
- Data rates ranging from 300 bps to 5.5 kbps
    - Two high-speed channels at 11 kbps and 50 kbps (FSK modulation)
    - Eight channels: bandwidth 125 kHz or 250 kHz
    - Support for adaptive data rate (power and spreading factor control)
- Secure bi-directional communication, mobility, and localization
    - Device authentication, message encryption, and frame counter
-->

## Protocol Architecture
### Uplink transmission
- Uncoordinated data transmission
    - Devices transmit without any coordination on a randomly chosen channel
    - Regulated maximum transmit duty cycle
    - Regulated maximum transmit duration (or dwell time)
- Collisions occur in LoRaWAN
    - Simultaneous transmissions on the same channel and spreading factor collide

#### LoRaWAN Access Method
LoRaWAN is an ALOHA-type protocol: transmission by the device is based on its own communication needs with a small variation based on a random time basis

### Device Classes
- Class A
    - Each uplink transmission is followed by two short downlink receive windows
    - Adapted for applications that only require downlink communication from the server shortly after the end-device has sent an uplink transmission

- Class B
    - In addition to class A, receive windows are opened at scheduled times
    - A time synchronized Beacon is sent by the gateway

- Class C
    - Nearly always open receive windows (unless transmitting)

### Receive Windows for Class A Devices
- First receive window
    - Same channel (and data rate) as the uplink
- Second receive window
    - Predefined channel and data rate, and possibility to modify it by MAC commands

\begin{figure}
  \includegraphics[scale=0.5]{./images/class-a-lorawan.eps}
\end{figure}

### Messages
- Uplink messages
    - Sent by devices to the NS
    - Relayed by one or multiple gateways
    - [Preamble, PHDR, PHDR_CRC, Payload, CRC]

- Downlink messages
    - Sent by the NS to only one device and is relayed by a single gateway
    - [Preamble, PHDR, PHDR_CRC, Payload]

- Each device has two frame counters
    - Uplink frames, incremented by the device
    - Downlink frames, incremented by the NS

### MAC Header
- Format
    - [ MAC type, …, Device Address, Frame Control, Frame Counter, Frame Options, Frame Port, Payload]
- Message Types
    - Join Request
    - Join Accept
    - Unconfirmed Data Up
    - Unconfirmed Data Down
    - Confirmed Data Up
    - Confirmed Data Down
    - RFU
    - Proprietary

### ACK in Frame Control for Confirmed Mode
- If the ACK (demanding acknowledge) sender is an end-device
    - The network will send the acknowledgement using one of the receive windows opened by the end-device after the send operation
- If the sender is a NS
    - The end-device transmits an acknowledgment at its own discretion, possibly piggybacked with the next Data message
- A message is retransmitted (predefined number of times) if an ACK is not received

### MAC Commands
- Commands are exchanged between devices and NS, not visible to the application layer
- Examples
    - Indicate the quality of reception of the device
    - Indicate the battery level of a device
    - Request the device to change data rate, transmit power, repetition rate or channel
    - Sets the maximum aggregated transmit duty-cycle of a device
    - Change to the frequency and the data rate set for the second receive window (RX2) following each uplink

### Data Stored in Each device
- Device address
    - 7 bit network identifier
    - 25 bit network address arbitrarily assigned by the admin
-  Application Identifier
    -  64 bits that uniquely identify the owner of the device (EUI-64)
-  Session key
    -  Used for integrity check and encryption/decryption of MAC only messages
- Application Session key
    - Used for integrity check and encryption/decryption of application data messages

### Two Ways of Activation
- Over the air activation
    - Necessitates a globally unique end-device identifier (DevEUI), the application identifier (AppEUI), and an AES-128 key (AppKey)
    - Two MAC messages between NS and devices: Join and Accept
- Activation by Personalization
    - No MAC messages
    - The DevAddr and the two session keys NwkSKey and AppSKey are directly stored into the end-device

### Adaptive Data Rate
- Objectives
    - Increase battery life
    - Maximize network capacity
- Data rate validation
    - A device periodically sets the ADR acknowledgment bit and waits for an acknowledgment from the network
    - If an ACK is not received, the device switches to the next lower data rate that provides a longer radio range

<!--
### EU 433MHz ISM Band
- The LoRaWAN can be used in the ETSI 433-434 MHz band as long as the radio device EIRP is less than 10 mW (or 10 dBm).
-->

<!--
# Class B Devices

### General Characteristics
- Devices open receive windows at fixed time intervals
- Enabling server initiated messages
- Synchronized reception window on devices
- Solve the Aloha limitations of Class A devices
- Class B devices are available on a predictable time in addition to the reception window similar to Class A following an uplink transmission
- The gateway sends a beacon on a regular basis to synchronize devices
- A device can switch from Class A to B

### Synchronous Network Initiated Downlink
- All gateways must synchronously broadcast a beacon providing a timing reference to the devices
    - Devices open receive windows or ping slots
    - The gateway chosen to initiate this downlink communication is selected by the network server based on the signal quality indicators of the last uplink of the device
    - If an end-device moves and detects a change in the identity advertised in the received beacon, it must send an uplink to the network server so that the server can update the downlink routing path database.
    - All end-devices start and join the network as Class A
- Based on the beacon strength and the battery life constraints, the end-device application selects a ping slot data rate and periodicity, this is then requested them from the LoRaWAN layer

### Class B Example

- Given the beacon period is 128 s, the device also opens a ping reception slot every 32 s.
- Most of the time this ping slot is not used by the server and therefore the end-device reception window is closed as soon as the radio transceiver has assessed that no preamble is present.
- If a preamble is detected the radio transceiver will stay on until the downlink frame is demodulated. The MAC layer will then process the frame, check that its address field matches the end-device address and that the Message Integrity Check is valid before forwarding it to the application layer.

\begin{figure}
\includegraphics[scale=0.5]{./images/lorawan-class-B.png}
\end{figure}

### Class B Operations
- Class B operation is maintained for 2 hours in the case of beacon loss
The beacon window interval or usable time for Class B slots is divided into 212 = 4096 ping slots of 30 ms each numbered from 0 to 4095
- An end-device using the slot number N must turn on its receiver exactly Ton seconds after the start of the beacon where:
$$T_{on} = BeaconReserved + N \times 30 ms$$
- To avoid systematic collisions or over-hearing problems the slot index is randomized and changed at every beacon period

### Class B MAC Command Examples
- The device communicates the ping unicast slot data rate and periodicity to the network server
- The network server sets the unicast ping channel of a device

### Beaconing
- All gateways participate in providing a time-synchronization mechanism by sending beacons (10 unmodulated symbols) at regular fixed intervals configurable per network
- Beacon is transmitted with SF9 spreading factor, with 125 kHz BW, on 869.525 MHz
- A beacon contains
    - Network ID
    - Timestamp
    - Longitude and Latitude of gateway

### Route Updates
- The network transmits the downlink from the gateway which was closest to the end-device when the last uplink was received
- Two strategies to keep location updated
    - Systematic periodic uplink (for stationary devices)
    - Uplink on cell change that requires demodulating the gateway specific part of the beacon
-->
<!--
### LoRa Radio Optimization

| Spreading Factor  | Bit Rate (kb/s) |  Sensitivity (dBm) |
|---|---|---|
| 7 | 5.468 | -123 |
| 8 | 3.125 | -126 |
| 9 | 1.757 | -129 |
| 10 | 0.976 | -132 |
| 11 | 0.537 | -134.5 |
| 12 | 0.293 | -137 |

\vspace{-6mm}
\small
\begin{itemize}
  \item[] ($RC$ = 1 and $B$ = 125 kHz)
\end{itemize}

\normalsize

-  Higher spreading factors lead to better sensitivity and larger coverage
-  Lower spreading factors lead to higher data rates
-->

<!--
### Wrap-up Example (1/3)
\begin{figure}
\includegraphics[scale=0.65]{./images/lorawan-ex1.png}
\end{figure}

### Wrap-up Example (2/3)

\begin{figure}
\includegraphics[scale=0.65]{./images/lorawan-ex2.png}
\end{figure}

### Wrap-up Example (3/3)

\begin{figure}
\includegraphics[scale=0.65]{./images/lorawan-ex3.png}
\end{figure}
-->
<!--
## Security
### Online Video Tutorial on Security
- [https://www.youtube.com/watch?v=Nu_yZelDMZI]()
-->

## NB-IoT

### NB-IoT and LTE
- NB-IoT is part of the 3GPP specifications: Releases 13, 14, and 15
    - NB-IoT fulfills the 5G mMTC requirements
- NB-IoT adapts and leverages the LTE ecosystem:
    - it reuses many LTE design principles:
        - \small Transmission schemes
        - Protocol architecture
        - Bearer management
        - Security management
        - Mobility management
    - it reuses LTE infrastructure through software upgrade

<!--
- Bearer management: establishment, maintenance, and release of the bearers
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

### Transmission Formats
- When coupling loss is low, multi-tone transmissions provide higher data rates
- When coupling loss is high, all transmission formats provide similar data rates
- When coupling loss is very high, only single-tone transmissions are possible

```{=latex}
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/instantaneousRate.eps}
  \vspace{-1mm}
  \caption*{$TBS$ = 1000 bits, $CRC$ = 24 bits, 8-ms cross-subframe CE}
\end{figure}
```

### Repetitions: Ideal vs. Realistic Processing Gain
- Cross-subframe CE improves realistic $G_p$ and decreases $(SNR)_{1,\text{ }threshold}$
- As $R$ is higher, $(SNR)_{1,\text{ }threshold}$ decreases leading to an increase in the CE error
- As $N_{RU}$ is higher, the channel coding rate decreases leading to a decrease in $(SNR)_{1,\text{ }threshold}$

```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.5]{./images/SNRthreshold-4.eps}
	\includegraphics<2>[scale=0.5]{./images/SNRthreshold.eps}
    \vspace{-2mm}
	\caption*{$TBS$ = 1000 bits, $CRC$ = 24 bits, $T_{RU}$ = 1 ms, and $B$ = 180 kHz}
\end{figure}
```

### Spectral Efficiency $\gamma$
- Ideal CE achieves similar spectral efficiency with lower $(SNR)_{1,\text{ }threshold}$
- As $N_{RU}$ is higher, the channel coding rate decreases leading to a decrease in $\gamma$
\vspace{3mm}
```{=latex}
\begin{figure}
	\centering
  \includegraphics[scale=0.5]{./images/spectralEfficiency.eps}
  \caption*{$TBS$ = 1000 bits, $CRC$ = 24 bits, $T_{RU}$ = 1 ms, and $B$ = 180 kHz}
\end{figure}
```

<!-- 
- TB: Application data (20 bytes), CoAP (4 bytes), DTLS (13 bytes), UDP (8 bytes), IP (40 bytes), PDCP (5 bytes), RLC (2 bytes), and MAC (2 bytes) => total: 94 bytes
- A 3-byte CRC is calculated and attached to a TB

- Multi-tone transmissions: $I_{TBS} = 0...13$; $I_{MCS} = I_{TBS}; QPSK (UL)
- Single-tone transmissions: $I_{TBS} = 0...10$; $I_{MCS} = I_{TBS}; BPSK for $I_{TBS} = 0$, or 2, and QPSK for all other values
- For NPUSCH transmissions, for every 256 ms continuous transmission, a 40 ms gap is introduced.
-->

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
Persistent scheduling for initial transmissions and dynamic scheduling for retransmissions (to enable better support of voice messages)
Periodic resource allocation to save control plane overhead
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
