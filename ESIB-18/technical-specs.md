# Technical Specification
## LoRaWAN
### What is LoRa?

\begin{block}{Definition of LoRa}
LoRa is a wireless modulation technique that uses Chirp Spread Spectrum (CSS) in combination with Pulse-Position Modulation (PPM).
\end{block}

- Processing gain given by $g_p = BT$
- Spreading factor $SF$ given by $log_2 (g_p)$
- Considering a coding rate $CR$, the bit-rate is given by:
$$R_b = SF \cdot \frac{B}{2^{SF}} \cdot \frac{4}{4+CR}$$
$$\text{with } 1 \leq CR \leq 4$$


### LoRa Symbols
- $log_2 (g_p)$ bits are encoded by transmitting a single $chirp$ in $g_p$ possible cyclic time shifts
- Example: $g_p = 4$ $\Rightarrow$ 2 bits/symbol

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/lora-symbols.pdf}
\end{figure}

### LoRa Spreading Factors
- LoRa uses spreading factors from 7 to 12

\begin{figure}
	\centering
	\includegraphics[scale=0.25]{./images/sf-comparison.eps}
\end{figure}

<!--
### LoRa Bit-Rate
- LoRa includes a variable error correction scheme that improves the robustness of the transmitted signal at the expense of redundancy
- Given a coding rate $CR$, the bit-rate is given by:

\begin{equation*}
R_b = SF \cdot \frac{B}{2^{SF}} \cdot CR
\end{equation*}

- $R_b$ can also be written as:

\begin{equation*}
R_b = SF \cdot \frac{B}{2^{SF}} \cdot \frac{4}{4+CR}
\end{equation*}
$$\text{with } 1 \leq CR \leq 4,\text{and } 7 \leq SF \leq 12$$
-->

### LoRa Radio Optimization

| Spreading Factor  | Bit Rate (kb/s) |  Sensitivity (dBm) |
|:---:|:---:|:---:|
| 6 | 9.375 | -118 |
| 7 | 5.468 | -123 |
| 8 | 3.125 | -126 |
| 9 | 1.757 | -129 |
| 10 | 0.976 | -132 |
| 11 | 0.537 | -134.5 |
| 12 | 0.293 | -137 |

\vspace{-6mm}
\small
\begin{itemize}
  \item[] ($CR$ = 1 and $B$ = 125 kHz)
\end{itemize}

\normalsize

-  Higher spreading factors lead to lower sensitivity and larger coverage
-  Lower spreading factors lead to higher data rates

<!--
### LoRa Physical Layer
- LoRa transmission consists of:
    - 8 preamble ($up$-$chirp$) symbols
    - 2 synchronization ($down$-$chirp$) symbols
    - 5 modulated symbols (payload)

\begin{figure}
	\centering
	\includegraphics[scale=0.45]{./images/phy-layer.pdf}
\end{figure}
-->

### LoRa Channels

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

<!--
### ETSI Limitations

- Restrictions on the maximum time the transmitter can be on or the maximum time a transmitter can transmit per hour
- Choice between

    - Duty-cycle limitation

    - Listen Before Talk Adaptive Frequency Agility (LBT AFA) transmissions management
- The current LoRaWAN specification exclusively uses duty-cycled limited transmissions to comply with the ETSI regulations
-->
### Duty Cycle Limitation
- The LoRaWAN enforces a per sub-band duty-cycle limitation (ETSI)

    - Each time a frame is transmitted in a given sub-band, the time of emission and the on-air duration of the frame are recorded for this sub-band
    - The same sub-band cannot be used again during the next $T_{off}$ seconds where: $$T_{off} = \frac{TimeOnAir}{DutyCyleSubband}- TimeOnAir$$
    - During the unavailable time of a given sub-band, the device may still be able to transmit on another sub-band
    - The device adapts its channel hopping sequence according to the sub-band availability

#### Example

A device just transmitted a 0.5 s long frame on one default channel. This channel is in a sub-band allowing 1% duty-cycle. Therefore this whole sub-band (868 – 868.6) will be unavailable for 49.5 s


### From LoRa to LoRaWAN

- LoRa

    - Modulation technique for LPWAN
- LoRaWAN
    - Uses LoRa modulation on physical layer
    - Proposes a MAC layer for access control
    - Specified by LoRa Alliance (LoRaWAN specification 1.1)

<!--
### LoRaWAN Timeline

- Cycleo first introduced LoRa in 2009

    - M2M communications

    - Large coverage

- Semtech acquired Cycleo in 2012 for 5 M$!

    - Patents filed in 2014

- LoRa Alliance initiated in 2014
    - Actility, Cisco, Bouygues, IBM, Orange, SK Telecom, KPN, ZTE, Semtech, La Poste, SoftBank, Swisscom, etc.

    - LoRaWAN 1.0 specification in 2015
-->
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

### Uplink transmission
- Uncoordinated data transmission
    - Devices transmit without any coordination on a randomly chosen channel
    - Regulated maximum transmit duty cycle
    - Regulated maximum transmit duration (or dwell time)

#### LoRaWAN Access Method
LoRaWAN is an ALOHA-type protocol: transmission by the device is based on its own communication needs with a small variation based on a random time basis

### Device Classes
- Class A
    - Each uplink transmission is followed by two short downlink receive windows
    - Adapted for applications that only require downlink communication from the server shortly after the end-device has sent an uplink transmission

\begin{figure}
		\includegraphics[scale=0.5]{./images/class-a-lorawan.eps}
\end{figure}

- Class B
    - In addition to class A, receive windows are opened at scheduled times
    - A time synchronized Beacon is sent by the gateway
- Class C
    - Nearly always open receive windows (unless transmitting)

<!--
### Messages
- Uplink messages

    - Sent by devices to the NS

    - Relayed by one or multiple gateways

    - [Preamble, PHDR, PHDR_CRC, Payload, CRC]

- Downlink messages

    - Sent by the NS to only one device and is relayed by a single gateway

    - [Preamble, PHDR, PHDR_CRC, Payload]

### Receive Windows for Class A Devices
- First receive window

    - Same channel (and data rate) as the uplink
- Second receive window

    - Predefined channel and data rate, and possibility to modify it by MAC commands

\begin{figure}
\includegraphics[scale=0.5]{./images/lorawan-rx-window.png}
\end{figure}
-->
<!--
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


### ACK in Frame Control
- If the ACK (demanding acknowledge) sender is an end-device, the network will send the acknowledgement using one of the receive windows opened by the end-device after the send operation
- If the sender is a NS, the end-device transmits an acknowledgment at its own discretion, possibly piggybacked with the next Data message
- A message is retransmitted (predefined number of times) if an ACK is not received


### Frame Counter
- Each device has two frame counters

    - Uplink frames, incremented by the device

    - Downlink frames, incremented by the NS

-->
### MAC Commands
- Commands are exchanged between devices and NS, not visible to the application layer
- Examples

    - Indicate the quality of reception of the device
    - Indicate the battery level of a device
    - Request the device to change data rate, transmit power, repetition rate or channel
    - Sets the maximum aggregated transmit duty-cycle of a device
    - Change to the frequency and the data rate set for the second receive window (RX2) following each uplink

<!--
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
-->
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
### Adaptive Data Rate

- Objectives
    - Increase battery life
    - Maximize network capacity
- Data rate validation
    - A device periodically sets the ADR acknowledgment bit and waits for an acknowledgment from the network
    - If an ACK is not received, the device switches to the next lower data rate that provides a longer radio range

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

### What is NB-IoT?
- 3GPP radio technology standard: releases R13 and R14
- Reutilizes cellular telecommunication bands
    - Three possible operation modes: in-band, guard-band, or standalone
- Reutilizes cellular telecommunication infrastructure
- Shares common characteristics with LTE networks    
    - Modulation technique
    - Access method
    - Core network functions

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/nb-iot-freq-deployment.eps}
\end{figure}

### NB-IoT Characteristics
- Radio resource: 1 LTE Physical Resource Block (PRB)
    - Bandwidth: 180 kHz
    - Duration: 0.5 ms
- Multiple access: Downlink OFDMA, Uplink SC-FDMA
- Modulation scheme
    - Downlink: QPSK
    - Uplink: QPSK (multi-tone), $\pi$/4-QPSK, or $\pi$/2-BPSK (single-tone)
- Link budget: 164 dB
- Data rate: $\sim$ 250 kbps in the DL and $\sim$ 250 kbps in the UL (multi-tone)

### Leveraging LTE mechanisms in NB-IoT
- Communication channels
    - Broadcast channel
    - Shared control channels (uplink and downlink)
- Access method
    - Cell acquisition and registration
    - Random access procedure
    - Scheduling of uplink and downlink transmissions  
- Localization and mobility management (in idle mode)

#### NB-IoT Access Method
NB-IoT access is performed in two steps: random access then scheduled transmission

### Optimizing LTE mechanisms for NB-IoT

- Coverage extension
    - Repeating the same transmission several times, available on all channels
    - Achieves extra coverage (up to 20 dB compared to GPRS)

- Energy saving
    - Monitoring paging channels either periodically, or only after a mobile- originated data transfer (for a short period of time).
        - \small extended Discontinuous Reception (eDRX)
        - Power-Saving Mode (PSM)

### extended Discontinuous Reception (eDRX)
- How often an idle device monitors paging channels?
- An eDRX cycle is the time period between two paging occasions the device needs to monitor (up to 2 h, 54 min, and 46 s)
- In between these two occasions, the device is assumed to be in deep sleep mode
- eDRX cycle is negotiated on a per device basis

\begin{figure}
	\centering
	\includegraphics[scale=0.33]{./images/eDRX.pdf}
    \vspace{-2mm}
	\caption*{Two possible eDRX cycle configurations}
\end{figure}

### Power-Saving Mode (PSM)
- In PSM, an idle device does not monitor paging channels $\Rightarrow$ unreachability
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
- The tracking area update period is configurable (up to a year)
