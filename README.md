# Multifactorial

This folder contains the code that has been used to estimate the performance of each network inference algorithm for the publication "A multifactorial evaluation framework for gene regulatory network reconstruction", 2019.

To rerun the analysis, please run “main_Inference_Millar.m” for the rhythmic model and "run_Inference_DREAM_wDummy.m" for the DREAM competition models. 

The aforementioned scripts call the "my_algorithm" function that must contain the code for the network inference strategy considered. 

This folder contains the script to run the "All2All" methodology as well as "BINGO". For ARNI, iCheMA and dynGENIE3, please refer to the original papers:


- Casadiego, J., Nitzan, M., Halleberg, S., and Timme, M. (2017). Model-free inference of direct network interactions from nonlinear collective dynamics. Nature Communications, 8(1), 2192.

- Aderhold, A., Husmeier, D., and Grzegorczyk, M. (2017). Approximate Bayesian inference in semi-mechanistic models. Statistics and Computing, 27(4), 1003-1040.

- Huynh-Thu, V.A. and Geurts, P. (2018). dynGENIE3: dynamical GENIE3 for the inference of gene networks from time series expression data. Scientific Reports. 8(1), 3384. doi:10.1038/s41598-018-21715-0.
