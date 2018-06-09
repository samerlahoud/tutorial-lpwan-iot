# General Framework

### A New Dimension in Communications
\begin{figure}
    \centering
    \includegraphics<1>[scale=0.7]{./images/iot-dimension-1}
    \includegraphics<2>[scale=0.7]{./images/iot-dimension-2}
    \caption{ITU Internet Reports (2005), The Internet of Things}
\end{figure}

- Current communications brought the ABC (Always Best Connected) paradigm
- The Internet of Things (IoT) explores a new dimension in communications

### IoT Settings
\begin{block}{Internet of Things}
The Internet of Things (IoT) generally refers to scenarios where network connectivity and computing capability extends to devices, sensors, and everyday items (ISOC IoT Overview, October 2015).
\end{block}

| Setting       | Example                                     |
| ------------- |:-------------------------------------------:|
| Human         | Wearables for health monitoring             |
| Home          | Heating, security automation                |
| Retail        | Self-checkout, inventory optimization       |
| Vehicles      | Condition-based maintenance                 |
| Cities        | Traffic control, environmental monitoring   |

### IoT Devices
- Components of an IoT device
   	- Physical world interface
  	- Computing capability
  	- Communication interface

\begin{figure}
	\includegraphics[scale=0.5]{./images/ericsson-connected-devices.pdf}
	\caption*{Source: Ericsson mobility report, June 2017}
\end{figure}

- The largest growth is expected for devices connected to a wide-area network

### End-to-End IoT Chain
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/iot-e2e-chain-1.eps}
	\includegraphics<2>[scale=0.35]{./images/iot-e2e-chain-2.eps}
	\includegraphics<3>[scale=0.35]{./images/iot-e2e-chain-3.eps}
	\includegraphics<4>[scale=0.35]{./images/iot-e2e-chain-4.eps}
	\includegraphics<5>[scale=0.35]{./images/iot-e2e-chain-5.eps}
\end{figure}

### IoT for Smart Agriculture
\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/smart-agri-4.eps}
\end{figure}

### Constraints on the Device and Network Layers
- Difficult physical accessibility and limited access to power sources
    - Wireless communications
    - Autonomy and long battery life operation
- Wide area coverage with a large number of communicating devices
    - Scalable deployment
    - Cost efficient devices
- Very loose bandwidth and latency constraints
    - Adaptive radio and access mechanisms

#### Challenge
Do existing wireless networking technologies satisfy these constraints?

### LPWAN Sweet Spot

\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/spider-graph-0.eps}
	\includegraphics<2>[scale=0.35]{./images/spider-graph-1.eps}
	\includegraphics<3>[scale=0.35]{./images/spider-graph-2.eps}
	\includegraphics<4>[scale=0.35]{./images/spider-graph-3.eps}
\end{figure}

### LPWAN Typical Use Cases

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/lpwa-use-cases.pdf}
	\caption*{Usman Raza {\it et al.}, Low Power Wide Area Networks: An Overview, IEEE Communications Surveys \& Tutorials, Issue 99, 2017}
\end{figure}

### LPWAN Architecture

\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/lpwa-architecture.eps}
\end{figure}

### Common Characteristics of LPWAN Technologies

- Optimised radio modulation
- Star topology
- Frame sizes in the order of tens of bytes
- Frames transmitted a few times per day at ultra-low speeds
- Mostly upstream transmission pattern
- Devices spend most of their time in low-energy deep-sleep mode

<!--
"NB-IoT will crush Sigfox and LoRa because it means there will be no need for them," Matt Beal, Vodafone's director of innovation and architecture

"Is Sigfox/LoRa the new WiMAX?", Stefan Kindt, Head of Technology Marketing at Nokia Networks
-->

#### LPWAN Technologies
Various technologies are currently candidating for LPWA: LoRaWAN, NB-IoT, Sigfox, Wi-SUN, Ingenu, etc.
