# Performance Evaluation

## Cell Range Estimation

### Link Budget
- The link budget is a measure of all the gains and losses from the transmitter, through the propagation channel, to the target receiver
- The link budget can be expressed as:

\begin{equation*}
P_{Rx} = P_{Tx} + G_{System} - L_{System} - L_{Channel} - M
\end{equation*}
\begin{itemize}
  \item[] where:
  \item[] $P_{Rx}$ = median received power
  \item[] $P_{Tx}$ = transmit power
  \item[] $G_{System}$ = system gains, \textit{e.g., } antenna, diversity, and amplifier gains
  \item[] $L_{System}$ = system losses, \textit{e.g., } cable and connector losses
  \item[] $L_{Channel}$ = median path loss
  \item[] $M$ = additional margins
\end{itemize}

### Additional Margins
- Fading margin
- Interference margin
- Penetration margin:
    - indoor penetration loss (first wall): $\sim 18$ dB (in dense urban environment), $\sim 15$ dB (in urban environment), and $\sim 10-12$ dB (in rural environment)
    - deep indoor penetration loss (second wall): +3 dB
- Body loss

### Maximum Allowable Path Loss and Cell Range
\begin{itemize}
\item The maximum allowable path loss ($MAPL$) is expressed as:
\begin{equation*}
MAPL = \max L_{Channel} \mbox{ } | \mbox{ } P_{Rx} \geq \mbox{receiver sensitivity}
\end{equation*}
\begin{equation*}
\Rightarrow MAPL = P_{Tx} + G_{System} - L_{System} - M - \mbox{receiver sensitivity}
\end{equation*}

\item The maximum allowable distance between the transmitter and the target receiver (cell range) depends on the $MAPL$ and the channel model\footnote{R. El Chall, S. Lahoud and M. El Helou, "LoRaWAN Network: Radio Propagation Models and Performance Evaluation in Various Environments in Lebanon," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 2, pp. 2366-2378, April 2019.}

\item Balanced links $\Rightarrow$ Uplink cell range = downlink cell range
\item[] \hspace{20.5mm} $\Rightarrow$ Uplink $MAPL$ = downlink $MAPL$
\end{itemize}

### Illustration: Uplink Link Budget Analysis

|     |                                                          |        |
|:---:|:--------------------------------------------------------:|:------:|
| $(a)$ |                Device $P_{Tx}$ (dBm)               |   23   |
| $(b)$ |              $G_{System} =$ base station antenna gain (dBi)             |   12   |
| $(c)$ |               $L_{System} =$ base station cable loss (dB)           |    3   |
| $(d)$ |                $M$ (dB)                  |   13   |
| $(e)$ |                  $B$ (Hz)                  |  3750  |
| $(f)$ |               Base station receiver $NF$ (dB)            |    3   |
| $(g)$ |Base station receiver $N$ (dBm) = $-174+ 10 \log_{10} (e)+ (f)$| -135.3 |
| $(h)$ |            Required SINR\footnote{Target instantaneous data rate = 160 b/s} at the base station (dB)        | -12.74 |
| $(i)$ |   Base station receiver sensitivity (dBm) =  $(g) + (h)$ |  -148  |
|       |         \textbf{Uplink \textit{MAPL} (dB)} = $(a)+(b)-(c)-(d)-(i)$  | \textbf{167} |
|       |     \textbf{Uplink cell range}\footnote{Okumura-Hata model: base station antenna height = 30 m, device antenna height = 1 m, carrier frequency = 862 MHz} \textbf{- urban environment (km)}         |   \textbf{13.45}    |

### Instantaneous Data Rate\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}

\begin{itemize}
\item The instantaneous data rate $R_b$ (b/s) can be expressed as:

\begin{equation*}
R_b = \frac{b+ CRC}{RU \cdot T}
\end{equation*}

\item[] where:
\item[] $b$ = transport block size (b)
\item[] $CRC$ = cyclic redundancy check code size (b)
\item[] $RU$ = number of allocated RUs
\item[] $T$ = RU duration (s)
\end{itemize}

### Spectral Efficiency
\begin{itemize}
\item The spectral efficiency $\gamma$ (b/s/Hz) can be written as:

\begin{equation*}
\gamma = \frac{R_b}{R \cdot BW} = \frac{b+CRC}{R \cdot BW \cdot RU \cdot T}
\end{equation*}

\item[] where:
\item[] $BW$ = allocated bandwidth (Hz)
\item[] $R$ = number of repetitions
\end{itemize}

### Modified Shannon Capacity\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}

\begin{itemize}
\item A modified Shannon capacity formula is used, as for LTE:

\begin{equation*}
C = BW \cdot BW_{eff} \cdot \log_2(1+ \frac{(SNR)_R}{SNR_{eff}})
\end{equation*}

\item[] where $C$ is the capacity of the channel measured in b/s, $BW_{eff}$ is the bandwidth efficiency of the used technology (i.e., NB-IoT), and $SNR_{eff}$ is the efficiency of the SNR in NB-IoT.

\item Consequently, the required $SNR$ after combining $R$ transmissions, $(SNR)_R$, can be expressed as:

\begin{equation*}
(SNR)_R = (2^{\frac{R_b}{BW \cdot BW_{eff}}}-1) \cdot SNR_{eff}
\end{equation*}
\end{itemize}

### Channel Estimation and Required $SNR$
\begin{itemize}
\item Ideal CE: The required $SNR$ of a single transmission, $(SNR)_1$, can be written as:

\begin{equation*}
(SNR)_1 = \frac{(SNR)_R}{R} = \frac{(2^{\frac{R_b}{BW \cdot BW_{eff}}}-1) \cdot SNR_{eff}}{R}
\end{equation*}

\item Realistic CE\footnote{Y. D. Beyene, R. Jantti, K. Ruttik and S. Iraji, "On the Performance of Narrow-Band Internet of Things (NB-IoT)," in \textit{2017 IEEE Wireless Communications and Networking Conference (WCNC)}, San Francisco, CA, 2017.}$^,$\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}:

\begin{equation*}
(2^{\frac{R_b}{BW \cdot BW_{eff}}}-1) \cdot SNR_{eff} = \frac{R \cdot (\sigma + (SNR)_{1})}{(\sigma + 1 + \frac{\sigma}{(SNR)_{1}}) \cdot (1+ \frac{\sigma}{2 \cdot (SNR)_{1}})}
\end{equation*}

\item[] where $\sigma$ denotes the estimation error
\end{itemize}

### Channel Estimation and Required $SNR$

\begin{itemize}
\item For realistic CE, $(SNR)_1$ is solved iteratively

\item $\sigma$ depends on $(SNR)_{1}$, as the CE quality depends on the amplitude of the received pilot symbols, and therefore, the $(SNR)_{1}$
\item After conducted simulations, the dependency between $\sigma$ and $(SNR)_{1}$ can be expressed in dB as a linear dependency:

\begin{equation*}
\sigma_{dB} = c_1 \cdot (SNR)_{1, dB} + c_2
\end{equation*}

\item[] where $(SNR)_{1,dB}$ and $\sigma_{dB}$ are measured in dB, and $c_1$ and $c_2$ are constants that depend on the cross-subframe window used in the CE and the modulation technique.
\item The simulation of different values of $W_{cs}$ provides a set of $c_1$ and $c_2$ values
\end{itemize}

### Parameter Settings
- The correction values for Shannon formula are derived through curve fitting to the 3GPP’s link-level simulation results for NPUSCH and NPDSCH:

|  Parameter  | NPUSCH Multi-tone | NPUSCH Single-tone | NPDSCH |
|:-----------:|:-----------------:|:------------------:|:------:|
|  $BW_{eff}$ |        0.35       |        0.35        |  0.58  |
| $SNR_{eff}$ |         1         |        0.60        |  1.90  |

- The dependency between $\sigma_{dB}$ and $SNR_{req, dB}$ are obtained through simulation of $\sigma$ for NPUSCH and NPDSCH pilots:

| $W_{cs}$ | SC-FDMA $c_1$ | SC-FDMA $c_2$ | OFDMA $c_1$ | OFDMA $c_2$ |
|:------:|:-----------:|:-----------:|:---------:|:---------:|
|    1   |   -0.4896   |    4.4971   |  -0.4998  |  14.5262  |
|    2   |   -0.4844   |    3.0252   |  -0.4995  |  13.0035  |
|    4   |   -0.4780   |    1.5869   |  -0.4990  |  11.5017  |
|    8   |   -0.4725   |    0.1239   |  -0.4992  |   9.9952  |
|   16   |   -0.4475   |   -1.1335   |  -0.4969  |   8.5077  |

### Results
- $SNR_{req}$ (dB) as a function of the number of repetitions, for ideal, wcs, and nocs CE.
    - TBS = 1000 bits with 4 RU and 10 RU
    - RU: 180 kHz over 1 ms
    - $W_{cs} = 8-ms
- $\gamma$ (b/s/Hz) as a function of the number of repetitions, for ideal, wcs, and nocs CE (should have no impact).
    - TBS = 1000 bits with 4 RU and 10 RU
    - RU: 180 kHz over 1 ms

### Result 1

\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/SNRthreshold.eps}
\end{figure}

### Result 2

\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/spectralEfficiency.eps}
\end{figure}

### Parameters
- TB: Application data (20 bytes), CoAP (4 bytes), DTLS (13 bytes), UDP (8 bytes), IP (40 bytes), PDCP (5 bytes), RLC (2 bytes), and MAC (2 bytes) => total: 94 bytes
- A 3-byte CRC is calculated and attached to a TB

<!-- 
- Multi-tone transmissions: $I_{TBS} = 0...13$; $I_{MCS} = I_{TBS}; QPSK (UL)
- Single-tone transmissions: $I_{TBS} = 0...10$; $I_{MCS} = I_{TBS}; BPSK for $I_{TBS} = 0$, or 2, and QPSK for all other values
- For NPUSCH transmissions, for every 256 ms continuous transmission, a 40 ms gap is introduced.
- A datarate of 160 bps is required at the MCL of 164 dB.
-->

### Results
- Instantaneous data rate ($R_b/R$ in kb/s) as a function of the coupling loss (CL, in dB), for 12 tones, 6 tones, 3 tones, 1 tone ($\Delta f = 15$ kHz), and 1 tone ($\Delta f = 3.75$ kHz)
    - TBS = 1000 bits (with 4 RU, 5 RU, 6 RU, 8 RU, and 10 RU for multi-tone transmissions; 6 RU, 8 RU, and 10 RU for single-tone transmissions)
    - Compute $R_b$ and $BW$
    - Deduce $SNR_e$
    - Compute the received $SNR$ as a function of the CL
    - Deduce the required number of transmissions $R$ (Realistic CE, $W_{cs} = 8$ ms)
    - Deduce $R_b/R$. If it depends on the number of RU, display the maximum $R_b/R$.

### Result 3

\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/instantaneousRate.eps}
\end{figure}

### Results
- Spectral efficiency/instantaneous physical rate, for multi-tone and single-tone transmissions
    - Multi-tone transmissions provide similar spectral efficiencies. Consequently, network capacity = maximum data rate $\Rightarrow$ RU = 180 kHz (12 subcarriers) over 1 ms
    - Single-tone transmissions provide similar spectral efficiencies. Consequently, maximum data rate $\Rightarrow$ RU = 15 kHz over 8 ms
    - Generate devices, compute their received SNR
    - Perform link adaptation: determine their MCS and number of repetitions
    - Deduce their instantaneous physical rate/spectral efficiency
    - Average user instantaneous physical rate/spectral efficiency $\rightarrow$ network capacity = average number of devices per cell = average user instantaneous rate/average user required rate

### Results
- Link adaptation
    - Objective: maximize the instantaneous physical rate
    - For each number of repetition $R$, identify the MCS that maximizes the instantaneous rate, subject to: received SNR $\geq SNR_{threshold}$ $\Rightarrow$ one MCS candidate for each $R$
    - Choose, from these candidates, the (MCS, $R$) couple that maximizes the instantaneous physical rate
- Results:
    - Average user instantaneous rate to compute the cell capacity
    - Percentage of users using each MCS, or each (MCS, $R$) couple if more relevant
