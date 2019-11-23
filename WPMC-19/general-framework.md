# General Framework

### A New Dimension in Communications
```{=latex}
\begin{figure}
    \centering
    \includegraphics<1>[scale=0.7]{./images/iot-dimension-1}
    \includegraphics<2>[scale=0.7]{./images/iot-dimension-2}
    \caption*{Source: The Internet of Things, ITU Internet Reports, 2005}
\end{figure}
```

- Current communications brought the ABC (Always Best Connected) paradigm
- The Internet of Things (IoT) explores a new dimension in communications

### IoT Scenarios
\begin{block}{Internet of Things}
The Internet of Things (IoT) generally refers to scenarios where network connectivity and computing capability extends to devices, sensors, and everyday items (ISOC IoT Overview, 2015).
\end{block}

| Scenario      | Example                                     |
| ------------- |:-------------------------------------------:|
| Human         | Wearables for health monitoring             |
| Home          | Heating, security automation                |
| Retail        | Self-checkout, inventory optimization       |
| Vehicles      | Condition-based maintenance                 |
| Cities        | Traffic control, environmental monitoring   |

### IoT Reference Model
```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.3]{./images/iot-e2e-chain-1.eps}
	\includegraphics<2>[scale=0.3]{./images/iot-e2e-chain-2.eps}
	\includegraphics<3>[scale=0.3]{./images/iot-e2e-chain-3.eps}
	\includegraphics<4>[scale=0.3]{./images/iot-e2e-chain-4.eps}
	\includegraphics<5>[scale=0.3]{./images/iot-e2e-chain-5.eps}
  \caption*{Source: Overview of the Internet of Things, ITU-T Y.2060, 2012}
\end{figure}
```

### Evolution of IoT Devices
- The number of IoT devices will exceed the number of PCs and mobile phones
\begin{figure}
	\includegraphics[scale=0.5]{./images/ericsson-connected-devices.pdf}
	\caption*{Source: Ericsson mobility report, 2019}
\end{figure}

### The Case of IoT for Smart Agriculture
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/smart-agri.eps}
\end{figure}
- Periodic sensing of microclimates in vineyards

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

### Capabilities of IMT-2020
```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.55]{./images/imt2020.png}
  \caption*{Source: IMT 2020 Vision - Framework and overall objectives of the future development of IMT for 2020 and beyond, ITU-R M.2083}
\end{figure}
```
<!--
URLLC is adapted for high-end IoT applications such as automated driving, industrial automation, and eHealth.
mMTC is LPWA IoT.
-->

<!--
### Massive Machine Type Communications
\begin{block}{mMTC: Massive Machine Type Communications}
mMTC requires improved network coverage, long device operational lifetime, and a high density of connections at low data rates
\end{block}

- Typical use cases for mMTC include:
  - Smart wearables
  - Smart cities
  - Smart agriculture
-->

### Emergence of Low Power Wide Area Technologies

\begin{block}{Low Power Wide Area Networks}
Low power refers to the ability of an IoT device to function for many years on a single battery charge, while at the same time it is able to communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies (3GPP Low Power Wide Area Technologies, GSMA White Paper, 2016)
\end{block}

- Low Power Wide Area (LPWA) technologies support mMTC
- Typical scenarios \footnote{Usman Raza {\it et al.}, Low Power Wide Area Networks: An Overview, IEEE Communications Surveys \& Tutorials, 2017} for LPWAN: 
    - Smart grid
    - Industrial asset monitoring
    - Critical infrastructure monitoring
    - Agriculture

<!--
### LPWAN Sweet Spot
```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.35]{./images/spider-graph-0.eps}
	\includegraphics<2>[scale=0.35]{./images/spider-graph-1.eps}
	\includegraphics<3>[scale=0.35]{./images/spider-graph-2.eps}
	\includegraphics<4>[scale=0.35]{./images/spider-graph-3.eps}
  \caption*{Source: Peter R. Egli, Low Power Wide Area Network, 2015}
\end{figure}
```

### LPWAN Scenarios
\begin{block}{Low Power Wide Area Networks}
Low power refers to the ability of an IoT device to function for many years on a single battery charge, while at the same time it is able to communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies (3GPP Low Power Wide Area Technologies, GSMA White Paper, 2016)
\end{block}

- Typical scenarios for LPWAN (Usman Raza *et al.*, Low Power Wide Area Networks: An Overview, IEEE Communications Surveys \& Tutorials, 2017)
    - Smart grid
    - Industrial asset monitoring
    - Critical infrastructure monitoring
    - Agriculture
-->

### LPWAN Requirements

| Indicator               | Requirement                                                |
|-------------------------|------------------------------------------------------------|
| Power consumption       | Devices operate for 10 years on a single charge            |
| Device unit cost        | Below $5 per module                                        |
| Dependability           | Completely unattended and resilient operation              |
| Coverage                | Improved outdoor and indoor penetration coverage           |
| Security                | Secure connectivity and strong authentication              |
| Data transfer           | Supports small, intermittent blocks of data                |
| Design complexity       | Simplified network topology and deployment                 |
| Network scalability     | Support of high density of devices                         |

### LPWAN Candidate Technologies

- A large number of candidate technologies:
  - LoRaWAN, Sigfox, Ingenu, NB-IoT, etc.
- Two main design choices: 
  - Adapt and leverage existing cellular technology (Cellular IoT)
  - Develop a clean-slate technology

\begin{figure}
	\includegraphics[scale=0.5]{./images/lpwa-forecast}
	\caption*{LPWAN connections forecast. Source: ABI Research, 2019}
\end{figure}

<!--
### LPWAN Architecture
\begin{figure}
	\centering
	\includegraphics[scale=0.4]{./images/lpwa-architecture.eps}
\end{figure}

### Common Characteristics of LPWAN Technologies
- Optimized radio modulation
- Star topology
- Frame sizes in the order of tens of bytes
- Frames transmitted a few times per day at ultra-low speeds
- Mostly upstream transmission pattern
- Devices spend most of their time in low-energy deep-sleep mode
-->

<!--
"NB-IoT will crush Sigfox and LoRa because it means there will be no need for them," Matt Beal, Vodafone's director of innovation and architecture

"Is Sigfox/LoRa the new WiMAX?", Stefan Kindt, Head of Technology Marketing at Nokia Networks
-->
