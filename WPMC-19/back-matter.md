# Conclusion
### Revisiting LPWAN Requirements
- How do LoRaWAN and NB-IoT meet the LPWAN requirements?
    - Complexity: short messages, simple channel codes, and low-complexity modulations
    - Coverage: low receiver sensitivity
    - Energy consumption: optimized device reachability and data transmission
    - Capacity: multiple transmissions on the same channel
    - Simplified network topology and deployment

### Typical Performance Results
- LoRaWAN shows coverage limitations, in comparison with NB-IoT, especially in indoor dense urban environments
- NB-IoT shows no coverage outage for a 4 km cell radius in indoor dense urban environments
- In order to maximize data rates, multi-tone transmissions are preferred for good radio conditions, while single-tone transmissions enable to combat harsh conditions
- Collisions hinder the performance of LoRaWAN in heavy loaded networks
- The capacity of an NB-IoT deployment can scale up to 200 000 devices sending 5 packets per hour
- NB-IoT requires more signaling messages than LoRaWAN, leading to higher energy consumption

### Challenges
- What are the challenges for optimizing the performance of LoRaWAN and NB-IoT?
    - Adaptation of the radio propagation models
    - Interference mitigation
    - Link adaptation and resource allocation
    - Support for quality of service such as delay-bounded transmissions
    - Energy efficiency maximization and power management

### Feedback and Tutorial Material
- We appreciate if you could take five minutes to complete the following evaluation form:
\begin{center}
\color{blue}
http://tiny.cc/lpwan-iot
\end{center}
- Your feedback is important to us in order to continually improve our tutorial
- We made the tutorial sources available under Creative Common license CC BY-NC-SA 4.0
\begin{center}
\color{blue}
https://github.com/samerlahoud/tutorial-lpwan-iot
\end{center}
- This is a human-readable summary of the license: 
\begin{center}
\color{blue}
https://creativecommons.org/licenses/by-nc-sa/4.0/
\end{center}