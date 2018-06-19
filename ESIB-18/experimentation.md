# Experimentation
### LISA: Long-range IoT for Smart Agriculture

- Project launched at ESIB-USJ in Sept. 2016
- Scientific objectives cover networking and agriculture topics
    - Deploy and test LoRa for agriculture
    - Automate measurement process of microclimates under vines
    - Test and assess different pruning lengths
- Participation in the PoC with Libatel for OGERO
    - Deployment at Château Kefraya
- Participation in the FOSS4I international research project
    - Development of a smart irrigation module controlled via LoRa

### First LoRaWAN Pilot in Lebanon at ESIB

\begin{figure}
	\centering
	\includegraphics[scale=0.25]{./images/lora-pilot-architecture.eps}
\end{figure}

- Diversity of devices: Arduino + Dragino (HopeRF) LoRa shield, Sodaq autonomo with (Microchip) LoRabee, Pycom LoPy, Raspberry Pi based DIY gateway, Kerlink Wirnet gateway
- Diversity of usage: Course on IoT technologies, student projects, research studies  

### LoRa Campus Coverage (1/2)

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/RSSI-map-ESIB.eps}
\end{figure}

### LoRa Campus Coverage (2/2)

\begin{figure}
	\centering
	\includegraphics[scale=0.5]{./images/ploss-exp.png}
\end{figure}

### LoRa Drive Test

\begin{figure}
	\centering
	\includegraphics[scale=0.3]{./images/coverage-tp-map.eps}
\end{figure}

### LoRa Energy Consumption
- Sodaq with Microchip LoRaBee (SF=7) sending 30 bytes message every 10 minutes
    - Sensing temperature, moisture, and light
    - Lifetime is *one year* on a single charge 1200 mAh battery

\begin{figure}
	\centering
	\includegraphics[scale=0.25]{./images/battery-eguz.png}
\end{figure}

### LoRa Cool Services

- View the live dashboard
    - https://goo.gl/jksaJW
- Play with MQTT and receive LoRa messages
    - Install a MQTT app (MQTT Dashboard on Android)
    - Connect to 212.98.137.194 port 1883
    - Subscribe to topic #
- Connect with our plants
    - Twitter: @allo_laplante
    - Hangout: rt.laplante@gmail.com and type `/bot eguz`

\begin{figure}
	\centering
	\includegraphics[scale=0.05]{./images/eguz.jpg}
\end{figure}
