# SimEngineBenchmark

## Introduction
Research on fault diagnosis and fault isolation on highly nonlinear dynamic systems such as the engine of a vehicle has garnered huge interest in recent years, especially with the automotive industry heading towards autonomous operations and big data. This simulation benchmark model of a single turbocharged petrol engine engine system is designed and developed for testing and evaluation of residuals generation and fault diagnosis methods. 

This benchmark model will serve as an excellent platform to demonstrate the effectiveness in simulating and presenting results on the fault diagnostic of automotive systems for the development and comparison of current and future research methods as well as for teaching initiatives. The engine model used is based on the mean value engine model (MVEM) with a PI-based boost controller. The benchmark is programmed in the MATLAB/Simulink environment and it provides realistic simulations of the engine system with a selection of faults of interest and industrial-standard driving cycles via a GUI interface. The simulation kit is available free and as an open-source, and distribued under the [GNU license](https://en.wikipedia.org/wiki/GNU_General_Public_License). 

If you use this benchmark model in your research, please cite the following publication:
- K. Y. Ng, E. Frisk, M. Krysander, and L. Eriksson, "A Single Turbocharged Petrol Engine System as a
Simulation Benchmark Model for Fault Diagnosis", 2019.


## Modelling The Engine
The simulation environment uses a 1.8L 4-cylinder single turbocharged spark ignited (TCSI) petrol engine as the benchmark. It consists of the following subsystems: Air filter, Compressor, Intercooler, Throttle, Intake manifold, Engine block, Exhaust manifold, Turbine, Wastegate, and Exhaust system. The engine system is modelled using dynamical equations that describe the air flow through the subsystems in the engine. These equations are derived based on the mean value engine model (MVEM) for a single turbocharged petrol engine as reported by Eriksson in the following paper:
- [L. Eriksson. "Modeling and control of turbocharged SI and DI engines," *Oil & Gas Science and Technology-Revue de l'IFP*, 62(4), pp.523-538, 2007.](https://ogst.ifpenergiesnouvelles.fr/articles/ogst/abs/2007/04/ogst06101/ogst06101.html)

<img src="/Figures/EngineDiag.png" width="500">

