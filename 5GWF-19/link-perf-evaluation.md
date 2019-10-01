# Performance Evaluation

## Cell Range Estimation

### Link Budget
- The link budget is a measure of all the gains and losses from the transmitter, through the propagation channel, to the target receiver
- The link budget can be expressed as: $$P_{Rx} = P_{Tx} + G_{System} - L_{System} - L_{Channel} - M$$
    - $P_{Rx}$ = median received power
    - $P_{Tx}$ = transmit power
    - $G_{System}$ = system gains (\textit{e.g., } antenna, diversity, and amplifier gains)
    - $L_{System}$ = system losses (\textit{e.g., } cable and connector losses)
    - $L_{Channel}$ = median path loss
    - $M$ = additional margins

### Additional Margins
- Fading margin
- Interference margin
- Penetration margin:
    - indoor penetration loss (first wall): $\sim 18$ dB (in dense urban environment), $\sim 15$ dB (in urban environment), and $\sim 10-12$ dB (in rural environment)
    - deep indoor penetration loss (second wall): +3 dB
- Body loss

### Maximum Allowable Path Loss and Cell Range

- The maximum allowable path loss ($MAPL$) is expressed as:
$$MAPL = \text{max } L_{Channel} \mbox{ } | \mbox{ } P_{Rx} \geq \text{receiver sensitivity}$$
$$\Rightarrow MAPL = P_{Tx} + G_{System} - L_{System} - M - \text{receiver sensitivity}$$
- The maximum allowable distance between the transmitter and the target receiver (cell range) depends on the $MAPL$ and the channel model\footnote{R. El Chall, S. Lahoud, and M. El Helou, "LoRaWAN Network: Radio Propagation Models and Performance Evaluation in Various Environments in Lebanon," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 2, pp. 2366-2378, April 2019.}
- Transmission and reception parameters are determined so as to achieve balanced links (\textit{i.e.,} uplink $MAPL$ = downlink $MAPL$)

### Illustration: Uplink Link Budget Analysis

|     |                                                          |        |
|:---:|:--------------------------------------------------------:|:------:|
| $(a)$ |                $P_{Tx}$ (dBm)               |   23   |
| $(b)$ |              $G_{System} =$ base station antenna gain (dBi)             |   12   |
| $(c)$ |               $L_{System} =$ base station cable loss (dB)           |    3   |
| $(d)$ |                $M$ (dB)                  |   16   |
| $(e)$ |                  $B$ (Hz)                  |  3750  |
| $(f)$ |               Receiver $NF$ (dB)            |    3   |
| $(g)$ |              Receiver $N$ (dBm) = $-174+ 10 \text{log}_{10} (e)+ (f)$| -135.3 |
| $(h)$ |            Required SINR\footnote{Target transmission data rate = 160 b/s} at the receiver (dB)        | -12.74 |
| $(i)$ |   Receiver sensitivity (dBm) =  $(g) + (h)$ |  -148  |
|       |         \textbf{Uplink \textit{MAPL} (dB)} = $(a)+(b)-(c)-(d)-(i)$  | \textbf{164} |
|       |     \textbf{Uplink cell range}\footnote{Okumura-Hata model: base station antenna height = 30 m, device antenna height = 1 m, carrier frequency = 862 MHz} \textbf{- urban environment (km)}         |   \textbf{11}    |

## Link-Level Performance Evaluation

### Channel Capacity

- The channel capacity $C$ is given by: $$C = B \cdot B_{eff} \cdot \text{log}_2 \left(1+ \frac{SNR}{SNR_{eff}}\right)$$
    - $B_{eff}$ = NB-IoT bandwidth efficiency
    - $SNR_{eff}$ = NB-IoT SNR efficiency

- $B_{eff}$ and $SNR_{eff}$ are obtained through curve fitting to the 3GPP link-level simulation results\footnote{"Consideration on Uplink Data Transmission for NB-IoT," 3GPP, Report R1-160480, 2016.}$^,$\footnote{"Further Considerations on NB-PDSCH Design for NB-IoT," 3GPP, Report R1-161860, 2016.}:

|    | UL (multi-tone) | UL (single-tone) | DL |
|:-----------:|:-----------------:|:------------------:|:------:|
|  $B_{eff}$ |        0.35       |        0.35        |  0.58  |
| $SNR_{eff}$ |         1         |        0.60        |  1.90  |

### Transmission Data Rate and $SNR_{threshold}$

- The transmission data rate $R_b$ (b/s) can be expressed as: $$R_b = \frac{TBS+ CRC}{N_{RU} \cdot T_{RU}}$$
    - $TBS$ = transport block size (bits)
    - $CRC$ = cyclic redundancy check code size (bits)
    - $N_{RU}$ = number of allocated RUs
    - $T_{RU}$ = RU duration (s)
- As the receiver combines $R$ transmissions (repetitions), reliability requires: $$(SNR)_R \geq \underbrace{\left(2^{\frac{R_b}{B \cdot B_{eff}}}-1\right) \cdot SNR_{eff}}_{SNR_{threshold}}$$

### Ideal vs. Realistic Processing Gain
- Ideal CE $\Rightarrow (SNR)_R = R \cdot (SNR)_1$
\vspace{-3mm}
$$(SNR)_{1,\text{ }threshold} = \frac{\left(2^{\frac{R_b}{B \cdot B_{eff}}}-1\right) \cdot SNR_{eff}}{R} \vspace{-1mm}$$
    - $(SNR)_{1,\text{ }threshold}$ = SNR threshold of a single transmission
\vspace{1mm}
- Realistic CE\footnote{Y. D. Beyene, R. Jantti, K. Ruttik and S. Iraji, "On the Performance of Narrow-Band Internet of Things (NB-IoT)," in \textit{2017 IEEE Wireless Communications and Networking Conference (WCNC)}, San Francisco, CA, 2017.}$^,$\footnote{P. Andres-Maldonado, P. Ameigeiras, J. Prados-Garzon, J. Navarro-Ortiz and J. M. Lopez-Soler, "An Analytical Performance Evaluation Framework for NB-IoT," in \textit{IEEE Internet of Things Journal}, vol. 6, no. 4, pp. 7232-7240, Aug. 2019.}:
\vspace{-1mm}
$$\left(2^{\frac{R_b}{BW \cdot BW_{eff}}}-1\right) \cdot SNR_{eff} = \frac{R \cdot (\sigma + (SNR)_{1,\text{ }threshold})}{\left(\sigma + 1 + \frac{\sigma}{(SNR)_{1,\text{ }threshold}}\right) \cdot \left(1+ \frac{\sigma}{2 \cdot (SNR)_{1,\text{ }threshold}}\right)}$$
    - $\sigma$ = estimation error
    - $(SNR)_{1,\text{ }threshold}$ is solved iteratively

### Estimation Error
- $\sigma$ is obtained through link-level simulations and can be expressed (in dB) as: $$\sigma_{dB} = c_1 \cdot (SNR)_{1,\text{ }threshold,\text{ }dB} + c_2$$
    - $(SNR)_{1,\text{ }threshold,\text{ }dB}$ = SNR threshold of a single transmission (dB)
    - $c_1$ and $c_2$ are constants that depend on the cross-subframe window 

| Cross-subframe window (ms) | $c_1$ (UL) | $c_2$ (UL) | $c_1$ (DL) | $c_2$ (DL) |
|:------:|:-----------:|:-----------:|:---------:|:---------:|
|    1   |   -0.4896   |    4.4971   |  -0.4998  |  14.5262  |
|    2   |   -0.4844   |    3.0252   |  -0.4995  |  13.0035  |
|    4   |   -0.4780   |    1.5869   |  -0.4990  |  11.5017  |
|    8   |   -0.4725   |    0.1239   |  -0.4992  |   9.9952  |
|   16   |   -0.4475   |   -1.1335   |  -0.4969  |   8.5077  |

### Spectral Efficiency
- Using $R$ repetitions, the useful data rate is $D = R_b/R$
- The spectral efficiency $\gamma$ (b/s/Hz) can be defined as: $$\gamma = \frac{D}{B} = \frac{TBS+CRC}{R \cdot B \cdot N_{RU} \cdot T_{RU}}$$
- The higher $R$ is
    - the lower $(SNR)_{1,\text{ }threshold}$ is $\Rightarrow$ larger radio coverage
    - the lower $D$ is

### $(SNR)_{1}$ Threshold
- Cross-subframe CE improves realistic $G_p$ and decreases $(SNR)_{1,\text{ }threshold}$
- As $R$ is higher, $(SNR)_{1,\text{ }threshold}$ decreases leading to an increase in $\sigma$
- As $N_{RU}$ is higher, the channel coding rate decreases leading to a decrease in $(SNR)_{1,\text{ }threshold}$

```{=latex}
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.55]{./images/SNRthreshold-4.eps}
	\includegraphics<2>[scale=0.55]{./images/SNRthreshold.eps}
\end{figure}
```

### Spectral Efficiency
- Ideal CE achieves similar spectral efficiency with lower $(SNR)_{1,\text{ }threshold}$
- As $N_{RU}$ is higher, the channel coding rate decreases leading to a decrease in $\gamma$

```{=latex}
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/spectralEfficiency.eps}
  \caption*{$TBS$ = 1000 bits, $CRC$ = 24 bits, $T_{RU}$ = 1, and $B$ = 180 kHz}
\end{figure}
```

<!-- 
- TB: Application data (20 bytes), CoAP (4 bytes), DTLS (13 bytes), UDP (8 bytes), IP (40 bytes), PDCP (5 bytes), RLC (2 bytes), and MAC (2 bytes) => total: 94 bytes
- A 3-byte CRC is calculated and attached to a TB

- Multi-tone transmissions: $I_{TBS} = 0...13$; $I_{MCS} = I_{TBS}; QPSK (UL)
- Single-tone transmissions: $I_{TBS} = 0...10$; $I_{MCS} = I_{TBS}; BPSK for $I_{TBS} = 0$, or 2, and QPSK for all other values
- For NPUSCH transmissions, for every 256 ms continuous transmission, a 40 ms gap is introduced.
-->

### Useful Data Rate
- When coupling loss is low, multi-tone transmission provides higher data rate
- When coupling loss is high, all transmission formats provide similar data rate
- When coupling loss is very high, only single-tone transmission is possible

```{=latex}
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/instantaneousRate.eps}
  \vspace{-1mm}
  \caption*{$TBS$ = 1000 bits, $CRC$ = 24 bits, 8-ms cross-subframe CE}
\end{figure}
```
