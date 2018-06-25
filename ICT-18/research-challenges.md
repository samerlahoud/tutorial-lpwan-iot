# Research Challenges
### Interest of the Scientific Community
\begin{figure}
	\centering
  \includegraphics[scale=0.35]{./images/gscholar-plot.png}
  \caption*{LoRa and NB-IoT in titles of scientific publications. Source: Google scholar, 2018}
\end{figure}

## Analyzing the Limits of LoRaWAN
### Research Approaches for Analyzing LoRaWAN
- The research studies analyze the performance of LoRaWAN networks considering different criteria:
    - Capacity
    - Coverage
    - Energy
    - Delay
    - Fairness
- The research studies use different methods to obtain the performance results:
    - Simulation
    - Mathematical modeling
    - Measurement campaigns

### Simulation of the LoRa Bit Error Rate\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}

- Implementation of the LoRa physical layer in ns-3
- Simulation of the Bit Error Rate (BER): $\log_{10}(BER(SNR)) = \alpha\exp(\beta SNR)$

\begin{figure}
	\centering
  \includegraphics[scale=0.5]{./images/soa-lora-phy-ns3.png}
\end{figure}
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-simul-snr-ber.png}
\end{figure}

### Basic Assignment of Spreading Factors\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}
- Assigning spreading factors based on a packet error ratio threshold gives the highest Packet Delivery Ratio (PDR)
- However, this basic assignment leads to unfairness between end-devices using different spreading factors
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-pdr-sf.png}
\end{figure}

### Fair Assignment of Spreading Factors\footnote{Reynders, Brecht, Wannes Meert, and Sofie Pollin. "Power and spreading factor control in low power wide area networks." 2017 IEEE International Conference on Communications (ICC). IEEE, (2017)}
- Fairness is achieved by minimizing the maximum collision on spreading factors: $\min \underset{s}{\max}\ p_{coll,s}$
    - The minimum is reached for a fraction $p_s$ of end-devices using spreading factor $s$ given by $p_s =\frac{s}{2^s}/\sum_{i=7}^{12} \frac{i}{2i}$
- Fairness does not hinder the data extraction rate DER (the ratio of received packets to transmitted packets over a period of time)

\begin{figure}
	\centering
  \includegraphics[scale=0.25]{./images/soa-fair-sf.png}
\end{figure}

### Joint Assignment of Transmit Power and Spreading Factors\footnote{Abdelfadeel, Khaled Q., Victor Cionca, and Dirk Pesch. "Fair Adaptive Data Rate Allocation and Power Control in LoRaWAN." IEEE 19th International Symposium on A World of Wireless, Mobile and Multimedia Networks (WoWMoM), 2018.}


### Impact of Confirmed Messages\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}
- Repeating the messages or using confirmed mode increases the PDR only when the traffic load is very low
- For high traffic load, the PDR of confirmed mode is limited by the duty cycle and half-duplex transmission
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-cnf-uncnf.png}
\end{figure}

### Measurement of the Capture Effect\footnote{Bor, Martin C., et al. "Do LoRa low-power wide-area networks scale?." Proceedings of the 19th ACM International Conference on Modeling, Analysis and Simulation of Wireless and Mobile Systems. ACM, 2016.}
- Experimentation (55.25 symbols packet length) shows the packet reception rate as function of transmission offset relative to the weak node in symbols
- A strong transmission can be successfully decoded when it arrives one packet time early up to at most 3 symbols late
- Capture model integrated in a discrete-event simulator (LoRaSim)

\begin{figure}
	\centering
  \includegraphics[scale=0.75]{./images/soa-capture-effect-exp.png}
\end{figure}

### Experimental Study of Coverage\footnote{Sanchez-Iborra, Ramon, et al. "Performance Evaluation of LoRa Considering Scenario Conditions." Sensors 18.3 (2018)}
- PDR in a nomadic test for urban (top) and suburban (bottom) scenarios near Murcia
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/soa-coverage-urban.png}\vfill
	\includegraphics[scale=0.55]{./images/soa-coverage-suburban.png}
\end{figure}

### Energy
- Modeling the Energy Performance of LoRaWAN

## Going Beyond LoRaWAN
### Research Approaches for Improving LoRaWAN
- physical Layer
- mac Layer : scheduling or learning
