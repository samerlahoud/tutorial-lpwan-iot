# Performance Evaluation
## Link Budget

### Enhanced Network Capacity
\begin{itemize}
  \item LoRa employs orthogonal spreading factors which enables multiple spread signals to be transmitted at the same time and on the same channel
  \item Modulated signals at different spreading factors appear as noise to the target receiver
  \item The equivalent capacity of a single 125 kHz LoRa channel is:
  \item[] $\mbox{    }SF12 + SF11 + SF10 + SF9 + SF8 + SF7 + SF6$
  \item[] $= 293 + 537 + 976 + 1757 + 3125 + 5468 + 9375$
  \item[] $= 21 531$ b/s $= 21.321$ kb/s
\end{itemize}

### Link Budget
- The link budget is a measure of all the gains and losses from the transmitter, through the propagation channel, to the target receiver
- The link budget of a network wireless link can be expressed as:

\begin{equation*}
P_{Rx} = P_{Tx} + G_{System} - L_{System} - L_{Channel} - M
\end{equation*}
\begin{itemize}
  \item[] where:
  \item[] $P_{Rx}$ = the expected received power
  \item[] $P_{Tx}$ = the transmitted power
  \item[] $G_{System}$ = system gains such as antenna gains
  \item[] $L_{System}$ = system losses such as feed-line losses
  \item[] $L_{Channel}$ = losses due to the propagation channel
  \item[] $M$ = fading margin and protection margin
\end{itemize}

## Coverage of LoRaWAN

### Scenario of Study
- Geographic area
    - Square area of 16.000 sqm
    - 1000 end-devices uniformly distributed
- Link budget  
    - Transmit power: 14 dBm
    - Okumura-Hata pathloss in urban area
    - Shadow fading: $\mathcal{N}(0,8dB)$
    - Gateway height: 30 m
    - End-device height: 1.5 m
    - Bandwidth: 125 kHz
    - Antenna gains: 3 dBi

### SNR-SF Mapping
if SNR_margin(i) <= -20
       node_SF(i) = 0;
   elseif SNR_margin(i) <= -17.5
       node_SF(i) = 12;
   elseif SNR_margin(i) <= -15
       node_SF(i) = 11;
   elseif SNR_margin(i) <= -12.5
       node_SF(i) = 10;
   elseif SNR_margin(i) <= -10
       node_SF(i) = 9;
   elseif SNR_margin(i) <= -7.5
       node_SF(i) = 8;
   elseif SNR_margin(i) <= +Inf
       node_SF(i) = 7;
   end

### Coverage Study
\begin{figure}
	\centering
	\includegraphics<1>[scale=0.4]{./images/coverage-sf7.eps}
  \includegraphics<2>[scale=0.4]{./images/coverage-sf78.eps}
  \includegraphics<3>[scale=0.4]{./images/coverage-sf789.eps}
  \includegraphics<4>[scale=0.4]{./images/coverage-sf78910.eps}
  \includegraphics<5>[scale=0.4]{./images/coverage-sf7891011.eps}
  \includegraphics<6>[scale=0.4]{./images/coverage-sf789101112.eps}
  \includegraphics<7>[scale=0.4]{./images/coverage-sf789101112u.eps}
\end{figure}

Spreading Factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|:---------:|:-----------:|:-----------:|:-----------:|:-----------:|:-----------:|
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |

<!--
Spreading factor             | 7         | 8           | 9           | 10          | 11          | 12          |
-----------------------------|-----------|-------------|-------------|-------------|-------------|-------------|
Coverage (\%)                |40.50      | 11.10       | 10.00       | 8.80        | 7.30        | 8.40        |
Cumulative coverage (\%)     |40.50      | 51.60       | 61.60       | 70.40       | 77.70       | 86.10       |
-->

### Spreading Factor and Time on Air
\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/timeonair.eps}
\end{figure}

### Energy
### Multiple Gateways



## Capacity of LoRaWAN
### ALOHA Model
- ALOHA with duty cycle
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau})$$
- ALOHA with multiple receivers and perfect packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{1}{n})^r))$$
- ALOHA with multiple receivers and realistic packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{K^{n-1}}{n})^r))$$
with $$K = \frac{1}{2}10^{-\frac{\Delta}{10 \alpha}}$$
