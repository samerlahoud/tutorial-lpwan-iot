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

### Assignment of Spreading Factors\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}
- Assigning spreading factors based on a packet error ratio threshold gives the highest Packet Delivery Ratio (PDR)
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-pdr-sf.png}
\end{figure}

### Impact of Confirmed Messages\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}
- Repeating the messages or using confirmed mode increases the PDR only when the traffic load is very low
- For high traffic load, the PDR of confirmed mode is limited by the duty cycle and half-duplex transmission
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-cnf-uncnf.png}
\end{figure}

### Capture Effect
- Do LoRa Low-Power Wide-Area Networks Scale
- Go to capture effect
- Look at findings

\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-capture-effect-exp.png}
\end{figure}

### Experimental Study of Coverage\footnote{Sanchez-Iborra, Ramon, et al. "Performance Evaluation of LoRa Considering Scenario Conditions." Sensors 18.3 (2018)}
- PDR in a nomadic test for urban (top) and suburban (bottom) scenarios near Murcia
\begin{figure}
	\centering
  \includegraphics[scale=0.55]{./images/soa-coverage-urban.png}\vfill
	\includegraphics[scale=0.55]{./images/soa-coverage-suburban.png}
\end{figure}

### Doppler Effect
- Performance Evaluation of LoRa Considering Scenario Conditions

### Fairness
- Fair Adaptive Data Rate Allocation and Power Control in LoRaWAN

### Delay
- Analysis of the delay of confirmed downlink frames in Class B of LoRaWAN

### Energy
- Modeling the Energy Performance of LoRaWAN

## Going Beyond LoRaWAN
### Research Approaches for Improving LoRaWAN
- physical Layer
- mac Layer : scheduling or learning
