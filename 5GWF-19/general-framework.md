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

### Massive Machine Type Communications
\begin{block}{mMTC: Massive Machine Type Communications}
mMTC requires improved network coverage, long device operational lifetime, and a high density of connections at low data rates
\end{block}

- Typical use cases for mMTC include:
  - Smart wearables
  - Smart cities
  - Smart agriculture

### mMTC Requirements\footnote{3GPP TR38.913, Study on Scenarios and Requirements for Next Generation Access Technologies (Release 14), 2017}

| Indicator                             | Requirement                                                         |
|---------------------------------------|---------------------------------------------------------------------|
| Coverage                              | 164 dB maximum coupling loss at 160 bps                             |
| Connection density                    | 1,000,000 devices per square kilometer                              |  
| UE battery life                       | 10 years battery lifetime (15 years desirable)\footnote{For a 5 Wh battery for a device sending daily 200 bytes uplink data followed by 20 bytes downlink data at a maximum coupling loss of 164 dB}                                                                                                                      |
| Latency                               | 10 s for a 20 byte application packet\footnote{In uplink at 164 dB maximum coupling loss and starting from the device being in the most battery efficient state}                         |

### Emergence of Low Power Wide Area Technologies

\begin{block}{Low Power Wide Area Networks}
Low power refers to the ability of an IoT device to function for many years on a single battery charge, while at the same time it is able to communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies (3GPP Low Power Wide Area Technologies, GSMA White Paper, 2016)
\end{block}

- Low Power Wide Area (LPWA) technologies enable to address the mMTC requirements
- A large number of candidate technologies:
  - LoRaWAN, Sigfox, Ingenu, NB-IoT, etc.
- Two main design choices: 
  - Adapt and leverage existing cellular technology (Cellular IoT)
  - Develop a clean-slate technology

### Plan
- Put statistics from ABI
- Go in depth in Cellular techno
- Give an example of non-cellular and lorawan
- Compare and conclude for cellular

### The Cellular Internet of Things
- mMTC requirements have led to the development and standardization of three 3GPP Cellular IoT technologies:
    - *Extended Coverage GSM for the Internet of Things (EC-GSM-IoT)*
    - *LTE for Machine-Type Communications (LTE-M)*
    - *Narrowband Internet of Things (NB-IoT)*
- Cellular IoT technologies share some common specifications 
  - Designed to operate in licensed frequency bands
  - Reuse or adapt concepts and components from existing cellular networks

<!--
### Extended requirements (including LPWA or CIoT)
CIoT (before 5G) is less stringent on density 
Third Generation Partnership Project, Technical Report 45.820 v13.0.0, Cellular System Support for Ultra-
low Complexity and Low Throughput Internet of Things, 2016
-->

<!--
### Cellular LPWA Technologies 

- EC-GSM-IoT
  - Fully backward compatible
  - Installed onto GSM networks
  - Bandwidth of 600 kHz

- LTE-M
  - Based on LTE
  - Stringent requirements on throughput and latency
  - Flexible bandwidth of 1.4 MHz and more

- NB-IoT
  - New radio access technology
  - Reuses components from LTE
  - Bandwidth starting from 200 kHz
-->

### Cellular IoT 3GPP Standards

|                    | EC-GSM-IoT                         | LTE-M     | NB-IoT                                |
|--------------------|------------------------------------|-----------|---------------------------------------|
| Spectrum           | GSM bands                          | LTE bands | LTE in-band, guard bands, SA          |
| Peak data rate     | 240 kbps \footnote{8PSK, 4 slots}  | 1 Mbps    | 50 kbps (UL multi-tone)               |
| Bandwidth          | 200KHz per ch.                     | 1.08MHz   | 180KHz                                |

### 5G Design for mMTC

- Continuation of Cellular IoT standards LTE-M and NB-IoT
  - LTE-M and NB-IoT fulfill the mMTC 5G requirements
  - No specification of NR mMTC solution in Release 15
  - In the future, NB-IoT and LTE-M may operate in-band within an NR carrier

- NB-IoT and LTE-M address complementary use cases
  - NB-IoT is ideal for supporting very low data rate applications in extremely challenging radio conditions
  - LTE-M achieves greater data rates, lower latency and more accurate device positioning capabilities

### Current Deployment of LTE-M and NB-IoT

\begin{figure}
	\includegraphics[scale=0.3]{./images/ciot-deployment-map}
	\caption*{Source: Mobile IoT Rollout Report, www.gsma.com}
\end{figure}

### LoRaWAN: An Example on (Non-Cellular) LPWA technology

- LoRaWAN is a clean slate LPWA technology 
- LoRaWAN uses a *new* robust modulation called LoRa
  - Variation of Chirp Spread Spectrum (CSS)
  - Uses Spreading Factors (SF) to increase the coverage
- LoRaWAN operates in license-free bands
  - Europe: 868 MHz
  - Transmit power limited to 14 dBm (25 mW)
  - 1% per sub-band duty-cycle limitation
- Coverage can reach tens of kilometers
- Data rates range from 300 bps to 5.5 kbps according to SF
- Other non-cellular LPWA are being specified
  - LoRaWAN, Sigfox, Ingenu, Wi-SUN, etc.

### Cellular versus Non-Cellular IoT

- Advantages of cellular technologies
  - Dedicated spectrum
  - Reusing infrastructure

- The largest growth is expected for cellular IoT devices

\begin{figure}
	\includegraphics[scale=0.5]{./images/ericsson-cellular-iot.pdf}
	\caption*{Source: Ericsson mobility report, 2019}
\end{figure}
