# Technical Specification

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
    - LoRaWAN 1.1 specification in 2018

## LoRaWAN Radio Interface

### Wireless Coverage and Maximum Coupling Loss
- Coverage targets are usually specified in terms of $MCL$ or Maximum Coupling Loss
- $MCL$ defines the maximum loss the system can cope with between a transmitter and a receiver:
$$MCL \mbox{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\log_{10}(B) + NF)}_{\mbox{Receiver sensitivity}}$$
    - $P_{Tx}$ is the transmit power
    - $SNR_{threshold}$ is the required signal to noise ratio for a given bit error rate
    - $B$ is the signal bandwidth
    - $NF$ is the noise figure caused by RF components

### How to Improve Coverage?
$$MCL \mbox{ (dB) }= P_{Tx} - \underbrace{(SNR_{threshold} -174 + 10\log_{10}(B) + NF)}_{\mbox{Receiver sensitivity}}$$

- Improving coverage can be achieved by:
    - Increasing $P_{Tx}$, or lowering $NF$, leads to higher device complexity and cost $\Rightarrow$ inadequate solutions
    - Reducing $B$ leads to lower network capacity $\Rightarrow$ inadequate solution
    - Reducing $SNR_{threshold}$ through optimized radio modulation that uses spread spectrum $\Rightarrow$ LoRa

## Chirp Spread Spectrum in LoRaWAN

### What is Spread Spectrum?
- Spread-spectrum techniques deliberately spread a signal in the frequency domain, resulting in a signal with a wider bandwidth
<!--
- Direct-sequence SS (DSSS), frequency-hopping SS (FHSS), time-hopping SS (THSS), and chirp SS (CSS) are forms of spread spectrum
..., and combinations of these techniques are forms of SS.
THSS: the transmission time is changed randomly by varying the period and duty cycle of the pulse (within the transmission window) using a pseudo-random sequence.
- Spreading process in DSSS systems: at the transmitter, the input data $S(t)$ is multiplied with a spreading code $C(t)$
-->
\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/spreading-process.pdf}
\end{figure}

<!--
### What is Spread Spectrum?
- De-spreading process in DSSS systems: at the receiver, $S(t)$ is re-covered by re-multiplying with the same spreading code $C(t)$

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/de-spreading-process.pdf}
\end{figure}
-->
### Why Spread Spectrum?
- Spread spectrum compensates for the $SNR$ degradation
\begin{equation*}
SNR_{threshold} = \left( \frac{E_b}{N_0}\right)_{threshold} - G_p
\end{equation*}

    - $E_b$ is the energy per bit
    - $N_0$ is the noise power spectral density
    - $G_p$ is the processing gain given by: $$G_p = 10\log_{10}(T_bB)$$

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

<!--
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
-->
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

<!--
### What is Chirp Spread Spectrum?
- Chirp Spread Spectrum (CSS) is a spread spectrum technique that uses wideband linear frequency modulated chirps to encode information
- Encoding information using only one chirp waveform with Pulse-Position Modulation (PPM):
    - $M$ bits are encoded by transmitting a single $chirp$ in one of $2^M$ possible time shifts $\Rightarrow$ bit-rate = $M/T$ in b/s
    - Chirps are not transmitted in equidistant time steps
- At the receiver, the signal is re-covered through de-chirping
-->
<!--
### Example: Binary Orthogonal Keying (BOK) Schemes

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/bok.pdf}
    \vspace{-5mm}
	\caption*{a) BOK using $up$- and $down$- chirps b) BOK using PPM}
\end{figure}
-->
<!--
### Advantages of CSS

- CSS is robust to interference, multipath fading, and Doppler effect

- Time and frequency offsets between transmitter and receiver are equivalent, greatly reducing the complexity of the receiver design
-->
<!--
Unlike the DSSS, the CSS does not add any pseudo-random elements to the signal, instead relying on the linear nature of the chirp pulse
-->
<!--
#### Why CSS?
CSS provides a low-complexity, low-cost, low-power, yet robust alternative to the traditional SS techniques
-->
### What is LoRa?

\begin{block}{Definition of LoRa}
LoRa is a wireless modulation technique that uses Chirp Spread Spectrum (CSS) in combination with Pulse-Position Modulation (PPM)
\end{block}

- Processing gain given by $g_p = BT$
- Variable number of bits encoded in a symbol

$$R_b = \frac{\log_2 (g_p)}{T} = \log_2 (g_p) \cdot \frac{B}{g_p}$$

- Spreading factor $SF$ given by $\log_2 (g_p)$

$$R_b = SF \cdot \frac{B}{2^{SF}}$$

### LoRa Symbols
- $\log_2 (g_p)$ bits are encoded by transmitting a single $chirp$ in $g_p$ possible cyclic time shifts
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

### LoRa Physical Layer
- LoRa transmission consists of:
    - 8 preamble ($up$-$chirp$) symbols
    - 2 synchronization ($down$-$chirp$) symbols
    - 5 modulated symbols (payload)

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

<!--
### ETSI Limitations

- Restrictions on the maximum time the transmitter can be on or the maximum time a transmitter can transmit per hour
- Choice between
    - Duty-cycle limitation
    - Listen Before Talk Adaptive Frequency Agility (LBT AFA) transmissions management
- The current LoRaWAN specification exclusively uses duty-cycled limited transmissions to comply with the ETSI regulations
-->
### Duty Cycle Limitation
- The LoRaWAN enforces a per sub-band duty-cycle limitation (ETSI regulation)

    - Each time a frame is transmitted in a given sub-band, the time of emission and the on-air duration of the frame are recorded for this sub-band
    - The same sub-band cannot be used again during the next $T_{off}$ seconds where: $$T_{off} = \frac{TimeOnAir}{DutyCyleSubband}- TimeOnAir$$
    - During the unavailable time of a given sub-band, the device may still be able to transmit on another sub-band
    - The device adapts its channel hopping sequence according to the sub-band availability

#### Example

A device just transmitted a 0.5 s long frame on one default channel. This channel is in a sub-band allowing 1% duty-cycle. Therefore this whole sub-band (868 – 868.6) will be unavailable for 49.5 s

### How LoRaWAN Supports Massive Number of Low-Rate Devices
- Trading off data rate for coverage
    -  Higher spreading factors lead to lower sensitivity and larger coverage
    -  Lower spreading factors lead to higher data rates
- How to increase network capacity?
    - LoRaWAN uses multiple orthogonal spreading factors simultaneously on the same channel

### How LoRa Enables Low Device Complexity and Cost?
- Reduce baseband processing complexity through:
    - limiting message size: maximum application payload size between 51 and 222 bytes, depending on the spreading factor
    - using simple channel codes: Hamming code
    - simple modulation: LoRa
    - supporting only half-duplex operation: no simultaneous transmission and reception
- Reduce RF processing complexity and cost through:
    - using one transmit-and-receive antenna
    - not using a duplexer (since only half-duplex operation is supported)
    - on-chip integrating power amplifier $\Rightarrow$ single-chip modem implementation (since transmit power is limited)

## LoRaWAN Physical Architecture

### LoRaWAN General Architecture
- LoRaWAN network architecture is typically laid out in a star-of-stars topology
    - End-devices
    - Gateways
    - Network server  
- LoRaWAN has a simple network architecture and operates in license-free bands $\Rightarrow$ low-cost deployment

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

## LoRaWAN Protocol Architecture

### How LoRaWAN Saves Power?
- Most of the IoT applications require infrequent transmission of small data volumes
- Idle devices may enter a deep sleep mode and shut down their transceiver
- Devices wake up from deep sleep mode to:
    - transmit data
    - open receive windows
- Battery lifetime is increased through:
    - optimizing device reachability
    - reducing signaling messages when a device needs to transmit data

### Uplink transmission
- Uncoordinated data transmission
    - Devices transmit without any coordination on a randomly chosen channel
    - Regulated maximum transmit duty cycle
    - Regulated maximum transmit duration (or dwell time)
- Collisions occur in LoRaWAN
    - Simultaneous transmissions on the same channel and spreading factor collide
- Two types of messages: unconfirmed and confirmed

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

<!--
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

### ACK in Frame Control for Confirmed Mode
- If the ACK (demanding acknowledge) sender is an end-device
    - The network will send the acknowledgement using one of the receive windows opened by the end-device after the send operation
- If the sender is a NS
    - The end-device transmits an acknowledgment at its own discretion, possibly piggybacked with the next Data message
- A message is retransmitted (predefined number of times) if an ACK is not received
-->
<!--
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
-->

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
