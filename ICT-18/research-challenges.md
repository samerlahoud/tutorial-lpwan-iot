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

### Fair Assignment of Spreading Factors\footnote{Reynders, Brecht, Wannes Meert, and Sofie Pollin. "Power and spreading factor control in low power wide area networks." 2017 IEEE International Conference on Communications (ICC) (2017)}
- Fairness is achieved by minimizing the maximum collision on spreading factors: $\min \underset{s}{\max}\ p_{coll,s}$
    - The minimum is reached for a fraction $p_s$ of end-devices using spreading factor $s$ given by $p_s =\frac{s}{2^s}/\sum_{i=7}^{12} \frac{i}{2i}$
- Fairness does not hinder the data extraction rate DER (the ratio of received packets to transmitted packets over a period of time)

\begin{figure}
	\centering
  \includegraphics[scale=0.25]{./images/soa-fair-sf.png}
\end{figure}
<!--
### Joint Assignment of Transmit Power and Spreading Factors\footnote{Reynders, Brecht, Wannes Meert, and Sofie Pollin. "Power and spreading factor control in low power wide area networks." 2017 IEEE International Conference on Communications (ICC). IEEE, (2017)}\footnote{Abdelfadeel, Khaled Q., Victor Cionca, and Dirk Pesch. "Fair Adaptive Data Rate Allocation and Power Control in LoRaWAN." IEEE 19th International Symposium on A World of Wireless, Mobile and Multimedia Networks (WoWMoM), 2018.}

\begin{figure}
	\centering
  \includegraphics[scale=0.25]{./images/soa-power-ctrl.png}
	\hfill
	\includegraphics[scale=0.25]{./images/soa-power-ctrl-der.png}
\end{figure}
-->
### Impact of Confirmed Messages\footnote{Van den Abeele, Floris, et al. "Scalability analysis of large-scale LoRaWAN networks in ns-3." IEEE Internet of Things Journal 4.6 (2017)}
- Repeating unconfirmed messages or using confirmed mode increases the PDR only when the traffic load is very low
- For high traffic load, the PDR of confirmed mode is limited by the duty cycle and half-duplex transmission
\begin{figure}
	\centering
  \includegraphics[scale=0.65]{./images/soa-cnf-uncnf.png}
\end{figure}

### Measurement of the Capture Effect\footnote{Bor, Martin C., et al. "Do LoRa low-power wide-area networks scale?." Proceedings of the 19th ACM International Conference on Modeling, Analysis and Simulation of Wireless and Mobile Systems. ACM (2016)}
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

### Energy Model for LoRaWAN Devices\footnote{Casals, Lluís, et al. "Modeling the Energy Performance of LoRaWAN." Sensors 17.10 (2017)}
- Model the current consumption of different LoRaWAN end-devices
    - Identify the different states of the end-device, and measure the respective current consumption and duration (*e.g.,* wake up, transmission, receive window, sleep)
- Example of using the model: collisions increase the energy required per delivered payload bit especially for confirmed mode

\begin{figure}
	\centering
	\includegraphics[scale=0.35]{./images/soa-energy-cost.png}
\end{figure}

### Model for the Macro-Diversity Gain\footnote{Song, Qipeng, Xavier Lagrange, and Loutfi Nuaymi. "Evaluation of Macro Diversity Gain in Long Range ALOHA Networks." IEEE Communications Letters 21.11 (2017)}
- End-device and gateway positions form a stationary Poisson point process with spatial density $\lambda_m$ and $\lambda_b$, respectively
- The spatial density of end-devices that are transmitting a packet is $p\lambda_m$
- The transmit success probability is defined as
$$p_s = \mathbb{P} \{SINR = \frac{P_r}{I+N} \approx \frac{P_r}{I} \geq \theta\}$$
- With macro reception diversity, the transmission fails if and only if none of the gateways has received the packet
- Let $\gamma$ be the path-loss exponent, $H$ an exponentially distributed random variable with unit mean, $\chi$ a zero-mean Gaussian r.v. with variance $\sigma^2$, the network packet loss rate $P_f$ can be written as:
$$P_f = \exp\left( - \frac{\lambda_b}{A\theta^\frac{2}{\gamma} p \lambda_m} \right)$$

<!--
$$p_s(r) = \mathbb{E}_\chi \left[ \exp(-p \lambda_m \pi A\theta^{\frac{2}{\gamma}} e^{\frac{2\sigma^2}{\gamma^2}}r^2e^{-\frac{2}{\gamma}\chi})\right]$$
-->

### Evaluation of Macro-Diversity\footnote{Song, Qipeng, Xavier Lagrange, and Loutfi Nuaymi. "Evaluation of Macro Diversity Gain in Long Range ALOHA Networks." IEEE Communications Letters 21.11 (2017)}
- Macro diversity leads to lower packet loss rate than the cases where the end-device attaches to the nearest gateway or to the gateway corresponding to the strongest received power
\begin{figure}
	\centering
  \includegraphics[scale=0.3]{./images/soa-macro-diversity.png}
\end{figure}

### Model for the Coexistence of LoRa with Other Technologies\footnote{Qin, Zhijin, et al. "Modelling and analysis of low-power wide-area networks." IEEE International Conference on Communications (ICC) (2017)}
- Coexistence of LoRa and non-LoRa nodes
    - LoRa nodes position form a Matern cluster process (PPP cluster center is formed by LoRa gateways and the end-devices in each cluster form the children process)
    - Non-LoRa nodes are modelled as PPP
- In the SINR expression, interference is the sum of three terms: intra-cluster, inter-cluster, and coexistence

\begin{figure}
	\centering
  \includegraphics[scale=0.25]{./images/soa-coexistence-network.png}
\end{figure}

### Coverage of LoRa with Coexisting Technologies\footnote{Qin, Zhijin, et al. "Modelling and analysis of low-power wide-area networks." IEEE International Conference on Communications (ICC) (2017)}
- The coverage probability monotonically decreases with the density of gateways and non LoRa nodes

\begin{figure}
	\centering
  \includegraphics[scale=0.4]{./images/soa-coexistence-coverage.png}
\end{figure}

## Going Beyond LoRaWAN
### Disentangling Interfering Transmissions\footnote{Eletreby, Rashad, et al. "Empowering Low-Power Wide Area Networks in Urban Settings." Proceedings of the Conference of the ACM Special Interest Group on Data Communication (2017)}
- Exploit hardware imperfections in LoRa transmitters to resolve collisions
    - Signals from colliding transmitters are likely to experience a small frequency offset
- Decode useful data
    - Frequency offset remains constant over a packet between chirps but data does not
- Attribute data to users
    - Data bits occur on integer peak locations in the Fourier transform, while frequency offsets need not
- Results: decoding collisions and extending range of LoRa transmission  

### Scheduling for Improving Reliability\footnote{Reynders, Brecht, et al. "Improving Reliability and Scalability of LoRaWANs Through Lightweight Scheduling." IEEE Internet of Things Journal (2018)}
- Two-step lightweight scheduling
    - Gateway schedules nodes in a coarse-grained manner through dynamically specifying the allowed transmission powers and spreading factors on each channel
	- Based on the gateway scheduling information, am end-device determines its own transmission power, spreading factor, and when and on which channel to transmit
- Results: increase throughput and fairness for large scenarios
\begin{figure}
		\centering
	  \includegraphics[scale=0.25]{./images/soa-scheduling-frame.png}
\end{figure}

### Learning for Improving Latency\footnote{Bonnefoi, Rémi, Christophe Moy, and Jacques Palicot. "Improvement of the LPWAN AMI backhaul’s latency thanks to reinforcement learning algorithms." EURASIP Journal on Wireless Communications and Networking 2018.1 (2018)}
- Derive closed-form expressions for the probability of a successful transmission into one channel with a simple acknowledgement
- Derive the expression of the latency for different frequency access schemes
- Selection of the best channel requires the knowledge of the probability of collision in the channels
    - MAB problem (acknowledgement as a reward) with reinforcement learning algorithms
- Results: increase success probability and reduce latency with time

### Application Layer Coding for Data Recovery\footnote{Marcelis, Paul J., Vijay S. Rao, and R. Venkatesha Prasad. "DaRe: Data recovery through application layer coding for LoRaWAN.", IEEE/ACM Second International Conference on Internet-of-Things Design and Implementation (IoTDI) (2017)}
- Thorough characterization of losses in LoRaWAN: channel outage, burstiness $\Rightarrow$ Gilbert Elliot model for bursty erasure channels
- Spread the redundant information from the data in one frame across other frames
\begin{figure}
	\centering
  \includegraphics[scale=0.2]{./images/soa-dare-window.png}
\end{figure}
- Results: tuning the coding parameters and increasing data recovery ratio
