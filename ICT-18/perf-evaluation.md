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

test

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

### Capacity of LoRaWAN
- ALOHA with duty cycle
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau})$$
- ALOHA with multiple receivers and perfect packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{1}{n})^r))$$
- ALOHA with multiple receivers and realistic packet capture
$$\frac{\delta}{\tau} N \exp(-2 N \frac{\delta}{\tau}) (1+\sum_{n=2}^{N} \frac{(2 N \frac{\delta}{\tau})^n}{n!} (1-(1-\frac{K^{n-1}}{n})^r))$$
with $$K = \frac{1}{2}10^{-\frac{\Delta}{10 \alpha}}$$
