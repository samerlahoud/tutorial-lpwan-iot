---
author:
- Samer Lahoud
- Melhem El Helou
title: Low Power Wide Area Networks for the Internet of Things
subtitle: Framework, Performance Evaluation, and Challenges of LoRaWAN and NB-IoT
date: ICT 2018, Saint-Malo, France
institute: ESIB, Saint Joseph University of Beirut, Lebanon
...

# Introduction
## Definition of the Internet of Things
\begin{block}{Internet of Things}
The Internet of Things (IoT) generally refers to scenarios where network connectivity and computing capability extends to devices, sensors, and everyday items (ISOC IoT Overview, October 2015).
\end{block}

- IoT devices are also called smart objects or connected objects
   	- Physical world interface
  	- Computing capability
  	- Communication interface

- IoT is referred to as Smart Object Networking (IETF)

## Characteristics of the Devices in IoT

\begin{block}{IoT Devices}
Everyday devices can become IoT devices: cars, HVAC, pollution sensors, street lighting, etc.
\end{block}

- IoT devices are connected to the Internet
     - Implement Internet protocols
     - Require addressing, naming, and routing functions

- IoT devices have stringent constraints on power, memory, bandwidth, and computing capability
     - Limited transmission capacity
     - Limited processing power

## Recent Enablers of IoT

- Ubiquitous connectivity
    - Pervasive wireless connectivity
    - Widespread adoption of IP-based networking
- Computing economics
    - Moore's law
    - Miniaturisation
- Advances in data analytics
    - Data mining
    - Rise of cloud computing

## End-to-End IoT Chain

\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/iot-e2e-chain-1.eps}
	\includegraphics<2>[scale=0.35]{./images/iot-e2e-chain-2.eps}
	\includegraphics<3>[scale=0.35]{./images/iot-e2e-chain-3.eps}
	\includegraphics<4>[scale=0.35]{./images/iot-e2e-chain-4.eps}
	\includegraphics<5>[scale=0.35]{./images/iot-e2e-chain-5.eps}
\end{figure}

## IoT for Smart Agriculture

\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/smart-agri-1.eps}
	\includegraphics<2>[scale=0.35]{./images/smart-agri-2.eps}
	\includegraphics<3>[scale=0.35]{./images/smart-agri-3.eps}
	\includegraphics<4>[scale=0.35]{./images/smart-agri-4.eps}
\end{figure}

# LPWA

## Constraints on the Device and Network Layers

- Difficult physical accessibility and limited access to power sources
    - Wireless communications
    - Autonomy and long battery life operation
- Wide area coverage with a large number of communicating devices
    - Scalable deployment
    - Cost efficient devices
- Very loose bandwidth and latency constraints
    - Adaptive radio and access mechanisms

### Challenge
Do existing wireless networking technologies satisfy these constraints?

## LPWA Sweet Spot

\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/spider-graph-0.eps}
	\includegraphics<2>[scale=0.35]{./images/spider-graph-1.eps}
	\includegraphics<3>[scale=0.35]{./images/spider-graph-2.eps}
	\includegraphics<4>[scale=0.35]{./images/spider-graph-3.eps}
\end{figure}

## LPWA Typical Use Cases

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/lpwa-use-cases.pdf}
	\caption*{Usman Raza {\it et al.}, Low Power Wide Area Networks: An Overview, IEEE Communications Surveys \& Tutorials, Issue 99, 2017}
\end{figure}

## LPWA Architecture

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/lpwa-architecture.eps}
\end{figure}

## Common Characteristics of LPWA Technologies

- Optimised radio modulation
- Star topology
- Frame sizes in the order of tens of bytes
- Frames transmitted a few times per day at ultra-low speeds
- Mostly upstream transmission pattern
- Devices spend most of their time in low-energy deep-sleep mode

### LPWA Technologies
Various technologies are currently candidating for LPWA: LoRaWAN, NB-IoT, Sigfox, Wi-SUN, Ingenu, etc.

# LoRaWAN

## What is LoRa?

\begin{figure}
	\centering
	\includegraphics[scale=0.25]{./images/LoRa-modulation.png}
\end{figure}

- Wireless modulation technology
    - Variation of Chirp Spread Spectrum (CSS)
    - Robust to interference, multipath, and fading

<!--
        - SS artificially increases the spectrum of a signal
        - The signal goes beyond the noise level
        - The inverse operation enables to easily extract the signal   
-->

## LoRa Characteristics

- Operates in license-free bands all around the world
    - 433, 868 (EU), 915 MHz
- Spectrum regulation for EU (including Lebanon)
    - Transmit power is limited to 14 dBm (25 mW)
    - 1% per sub-band duty-cycle limitation (per hour)
- Receiver sensitivity: -142 dBm
- Link budget: 156 dB
- Uses Spreading Factors to set the modulation rate (SF7 to SF12)

## LoRa Radio Optimization

| Spreading Factor  | Bit Rate (kb/s) |  Sensitivity (dBm) |
|---|---|---|
| 7 | 5.468 | -123 |
| 8 | 3.125 | -126 |
| 9 | 1.757 | -129 |
| 10 | 0.976 | -132 |
| 11 | 0.537 | -134.5 |
| 12 | 0.293 | -137 |

-  Higher spreading factors lead to better sensitivity and larger coverage
-  Lower spreading factors lead to higher data rates

## What is LoRaWAN?
- Communication protocol and architecture that utilizes the LoRa physical layer
- Data rates ranging from 300 bps to 5.5 kbps
    - Two high-speed channels at 11 kbps and 50 kbps (FSK modulation)
    - Eight channels: bandwidth 125 kHz or 250 kHz
    - Support for adaptive data rate (power and spreading factor control)
- Secure bi-directional communication, mobility, and localization
    - Device authentication, message encryption, and frame counter
- Uncoordinated data transmission
    - Devices transmit without any coordination on a randomly chosen channel

### LoRaWAN Access Method
LoRaWAN is an ALOHA-type protocol: transmission by the device is based on its own communication needs with a small variation based on a random time basis.

## LoRaWAN Device Classes

- Class A: Each device's uplink transmission is followed by two short downlink receive windows.

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/class-a-lorawan.eps}
\end{figure}

- Class B: In addition to the Class A functionality, Class B devices open extra receive windows at scheduled times.  
- Class C: These devices have a continuous open receive widow, except when transmitting.

# NB-IoT

## What is NB-IoT?

- Radio technology standard by 3GPP
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

## NB-IoT Characteristics

- LTE FDD frequency bands
- Bandwidth: 180 kHz
    - 12 subcarriers separated by 15 kHz
- Duration: 1 slot of 0.5 ms
- Multiple access: Downlink OFDMA, Uplink SC-FDMA
- Modulation scheme
    - Downlink: QPSK
    - Uplink: Single Tone: π/4-QPSK, π/2-BPSK, Multi Tone: QPSK
- Link budget: 164 dB
- Data rate: ~250 kbps in DL and ~250 kbps in UL (multi-tone)

## Leveraging LTE Mechanisms in NB-IoT

- Communication channels
    - Broadcast channel
    - Shared control channels (uplink and downlink)
- Access method
    - Cell acquisition and registration
    - Random access procedure
    - Scheduling of uplink and downlink transmissions  
- Localization and mobility management (idle mode)

### NB-IoT Access Method
NB-IoT access is performed in two steps: random access then scheduled transmission.

## Optimizing LTE Mechanisms for NB-IoT

- Energy saving
    - DRX (Discontinuous Reception) cycles extended from 2.56 seconds to 10.28 seconds in NB-IoT
    - Paging Time Window of 3 hours allowing longer paging cycles

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/nb-iot-edrx.eps}
\end{figure}

- Coverage extension
    - Repeating the same transmission several times, available on all channels
    - Achieves extra coverage (up to 20 dB compared to GPRS)

## NB-IoT vs LoRaWAN

|  | LoRaWAN |  NB-IoT |
|---|---|---|
| Spectrum | Licence-free | Licensed |
| Deployment | Private/Operator | Operator |
| Signalling | Very low | High |
| QoS | Delay insensitive | Delay bounded |
| Data Volume | Low | High |

<!--
LoRa for IoT is what WiFi is to femtocell
-->

# Research Challenges

## Comparison of LPWA Technologies

- Evaluation scenario
    - Dynamic device arrival/departure
    - Single and multiple cell deployment
    - Variable demand per node
    - Variable radio conditions
- Performance indicators
    - Network capacity and throughput
    - Collision/interference level
    - Power consumption
    - Transmission delay

### Research Project
Devise analytical models and simulation tools to assess and compare the performance of LoRaWAN and NB-IoT.

## Radio Resource Management in LPWA

- Adaptation of the radio propagation models
    - Antenna height
    - (Sub)Urban vs agriculture land
- Interference mitigation
    - Frequency allocation
- Scheduling for NB-IoT
    - Max-SNR vs energy efficient scheduling  
- Support for quality of service
    - Delay bounded transmission
- Maximisation of the energy efficiency
    - Power control
    - Rate adaptation

## Naming and Addressing in LPWA

- IoT devices are connected to the Internet
     - Implement Internet protocols
     - Require addressing, naming, and routing functions
- Current work by the IETF lpwan working group
    - Providing IPv6 connectivity to the devices
    - Proposing technologies to secure the operations and manage the devices and their gateways
- Proposed standard expected in July 2017
    - Compression and fragmentation of a CoAP/UDP/IPv6 packet over LPWA networks

# On-going Work

## LISA: Long-range IoT for Smart Agriculture

- Project launched at ESIB-USJ in Sept. 2016
- Scientific objectives cover networking and agriculture topics
    - Deploy and test LoRa for agriculture
    - Automate measurement process of microclimates under vines
    - Test and assess different pruning lengths
- LISA will deploy a LoRa based IoT network in Bekaa in 2018

## First LoRaWAN Pilot in Lebanon at ESIB

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/lora-pilot-architecture.eps}
\end{figure}

- Lab prototype: Arduino + Dragino (HopeRF) LoRa shield, Raspberry Pi based DIY gateway
- Deployment: Sodaq autonomo with (Microchip) LoRabee devices,
Kerlink Wirnet gateway

## LoRa Campus Coverage

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/RSSI-map-ESIB.eps}
\end{figure}

## LoRa Drive Test

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/coverage-tp-map.eps}
\end{figure}

## IoT Cool Services

- View the live dashboard
    - https://emoncms.org/dashboard/view&id=42658
- Play with MQTT and receive LoRa messages
    - Install a MQTT app (MQTT Dashboard on Android)
    - Connect to 212.98.137.194 port 1883
    - Subscribe to topic #
- Connect with our plants
    - Twitter: @allo_laplante
    - Hangout: rt.laplante@gmail.com and type `/bot eguz`

\begin{figure}
	\centering
	\includegraphics[scale=0.05]{./images/eguz.jpg}
\end{figure}

## LoRa Modulation Basics

\begin{block}{LoRa Modulation}
Wireless modulation technology that uses CSS in combination with Pulse-Position Modulation (PPM)
\end{block}

\begin{itemize}
  \item Chip rate: $R_c = B$
  \item[] Symbol rate: $R_s = 1/T$
  \item[] $\Rightarrow$ Processing gain $g_p = R_c/R_s = BT$
  \item Important aspect of LoRa related to PPM: the number of possible bits that can be encoded in a symbol is variable $= log_2 (g_p)$
\end{itemize}

\begin{equation*}
R_b = \frac{log_2 (g_p)}{T} = log_2 (g_p) \cdot R_s = log_2 (g_p) \cdot \frac{R_c}{g_p} = log_2 (g_p) \cdot \frac{B}{g_p}
\end{equation*}

- LoRa defines the spreading factor $SF$ as equal to $log_2 (g_p)$

\begin{equation*}
\Rightarrow R_b = SF \cdot \frac{B}{2^{SF}}
\end{equation*}

## LoRa Bit-Rate
- LoRa modulation includes a variable error correction scheme that improves the robustness of the transmitted signal at the expense of redundancy

\begin{equation*}
\Rightarrow R_b = SF \cdot \frac{B}{2^{SF}} \cdot CR
\end{equation*}
\begin{itemize}
  \item[] where $CR$ represents the coding rate
\end{itemize}

- $R_b$ can also be written as follows:

\begin{equation*}
\Rightarrow R_b = SF \cdot \frac{B}{2^{SF}} \cdot \frac{4}{4+CR}
\end{equation*}
\begin{itemize}
  \item[] where $1 \leq CR \leq 4$ and $7 \leq SF \leq 12$
\end{itemize}
