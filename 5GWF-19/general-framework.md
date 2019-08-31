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
- The largest growth is expected for cellular IoT devices

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

### Massive Machine Type Communications
\begin{block}{mMTC: Massive Machine Type Communications}
requiring low power consumption and low data rates for very large numbers of connected devices

Low power refers to the ability of an IoT device to function for many years on a single battery charge, while at the same time it is able to communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies (3GPP Low Power Wide Area Technologies, GSMA White Paper, 2016)
\end{block}

- Typical use cases for mMTC (Usman Raza *et al.*, Low Power Wide Area Networks: An Overview, IEEE Communications Surveys \& Tutorials, 2017)
  - Smart wearables
  - Smart metering

### mMTC Requirements

| Indicator                             | Requirement                                                         |
|---------------------------------------|---------------------------------------------------------------------|
| Coverage                              | 164 dB maximum coupling loss at a rate of 160 bps                   |
| Connection density                    | 1,000,000 device/km2                                                |  
| UE battery life                       | 10 years battery lifetime (15 years desirable) for a 5 Wh battery for a device sending daily 200 bytes uplink data followed by 20 bytes downlink data at a maximum coupling loss of 164 dB   |
| Latency for infrequent small packets  | 10 s for a 20 byte application packet in uplink at 164 dB maximum coupling loss and starting from the device being in the most “battery efficient” state                                      |

#### LPWAN Technologies
Various technologies are currently being designed to meet the mMTC requirements: LoRaWAN, NB-IoT, Sigfox, Wi-SUN, Ingenu, etc.
