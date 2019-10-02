### Conclusions (1/3)
<!--
- What are the requirements and characteristics of mMTC in 5G?
    - Devices function for many years on a single battery charge
    - Devices communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies
    - High density of connections at low data rates?
    - Latency?
-->
- How does NB-IoT meet the 5G mMTC requirements?
    - Complexity: short messages, low complexity codes and modulations
    - Energy: Optimized reachability and reduced signaling
    - Coverage: Low receiver sensitivity
    - Capacity: Multi-tone and single-tone transmissions
    - Cost: Reuse 4G architecture

### Conclusions (2/3) 
- How do we evaluate the performance of an NB-IoT deployment in terms of coverage and capacity?
    - Link-level evaluation shows the impact of the radio parameters (repetitions, MCS, and transmission formats) on the the performance of the communication
    - System-level evaluation shows the impact of the user load and distribution on the network performance (cell planning, deployment optimization, etc.)

#### Typical performance of NB-IoT
- In order to maximize data rates, multi-tone transmissions are preferred for good radio conditions, while single-tone enable to combat harsh conditions 
- No coverage outage is observed for a cell radius of 4 km in an indoor dense urban environment
- The capacity of a deployment can scale up to 200 000 devices sending 5 packets per hour

### Conclusions (3/3)
- What are the challenges for optimizing the performance of NB-IoT?
    - Adaptation of the radio propagation models
    - Interference mitigation
    - Link adaptation and resource allocation
    - Support for quality of service such as delay bounded transmission
    - Energy efficiency maximization and power management

### Feedback and Tutorial Material
- We appreciate if you could take five minutes to complete the following evaluation form:
\begin{center}
\color{blue}
http://tiny.cc/iot5g
\end{center}
- Your feedback is important to us in order to continually improve our tutorial
- We made the tutorial sources available under Creative Common license CC BY-NC-SA 4.0
\begin{center}
\color{blue}
https://github.com/samerlahoud/tutorial-lpwan-iot
\end{center}
- This is a human-readable summary of the license: https://creativecommons.org/licenses/by-nc-sa/4.0/
