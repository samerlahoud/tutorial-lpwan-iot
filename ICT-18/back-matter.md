### Conclusions (1/4)
- How do LPWAN complement traditional cellular and short-range wireless technologies?
    - LPWAN devices function for many years on a single battery charge
    - LPWAN devices communicate from locations where shadowing and path loss would limit the usefulness of more traditional cellular technologies
- What are the fundamental mechanisms that enable to meet the LPWAN requirements?
    - Short messages, low complexity codes and modulations
    - Low receiver sensitivity
    - Optimized reachability and low signaling
    - Multiple transmissions on the same channel
    - Simplified architecture

### Conclusions (2/4)
- What are the major design choices made in the LoRaWAN and NB-IoT specifications?

|                   |        LoRaWAN        |          NB-IoT          |
|-------------------|:---------------------:|:------------------------:|
| Reliability       |     CSS-based LoRa    |        Repetitions       |
| Power consumption | Short receive windows |      eDRX, PSM modes     |
| Capacity          |      Multiple SFs     | Single tone transmission |
| Deployment        |  Simple architecture  |    Architecture reuse    |

### Conclusions (3/4)
- How do we evaluate the performance of a LoRaWAN and NB-IoT deployment in terms of coverage and capacity?
    - Combination of simulation, mathematical modeling and measurement campaigns
    - Performance evaluations should take into account collisions and duty cycle in LoRaWAN, scheduling and signaling in NB-IoT

#### Global performance
- LoRaWAN shows coverage limitations compared to NB-IoT especially in indoor dense urban environments
- Collisions hinder the performance of LoRaWAN in heavy loaded networks

### Conclusions (4/4)
- What are the recent research directions for radio resource management in LoRaWAN and NB-IoT?
    - Adaptation of the radio propagation models
    - Interference mitigation and scheduling
    - Support for quality of service such as delay bounded transmission
    - Maximization of the energy efficiency
    - Providing IPv6 connectivity to the device (IETF lpwan working group)

### Feedback and Tutorial Material
- We appreciate if you could take five minutes to complete the following evaluation form:
\begin{center}
\color{blue}
https://goo.gl/Ex7mg9
\end{center}
- Your feedback is important to us in order to continually improve our tutorial
- We made the tutorial sources available under Creative Common license CC BY-NC-SA 4.0
\begin{center}
\color{blue}
https://github.com/samerlahoud/tutorial-lpwan-iot
\end{center}
- This is a human-readable summary of the license: https://creativecommons.org/licenses/by-nc-sa/4.0/
