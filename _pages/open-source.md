---
title: "Open Source"
permalink: /open-source/
author_profile: true
---

<div class="text-justify" markdown="1">

These are selected projects I worked on — some on my own, others as a major contributor:

## ICoMo
ICoMo (“Inference of Compartmental Models”) is a toolbox for building and fitting 
compartmental models with differentiable ODE dynamics inside PyMC. Models are 
specified via flows between compartments; ICoMo generates the corresponding ODE 
system and can visualize the compartment graph for sanity checks. The ODEs are 
integrated with Diffrax and derivatives are available for gradient-based fitting and 
Bayesian inference. In practice, this keeps the solver + inference pipeline 
composable as you iterate on model structure, significantly simplifying building 
such models. 
Repository: 
<https://github.com/Priesemann-Group/icomo>

## Mr. Estimator
Mr. Estimator is a toolbox for estimating branching-process parameters from discrete time series. 
It implements estimators and diagnostics aimed at finite-sample effects and typical complications 
such as subsampling and non-stationarities. Repository: <https://github.com/Priesemann-Group/mrestimator>

## PyMC / PyTensor contribution: wrap_jax
In PyTensor (and therefore PyMC), `wrap_jax` wraps JAX-jittable functions as PyTensor Ops, 
so they can be placed inside symbolic graphs and still support automatic differentiation. 
It supports JAX pytrees and separates dynamic (array) inputs/outputs from static 
values, which makes it practical to use structured inputs/outputs 
without manually flattening everything. It also automatically evaluates shape information 
as needed for output type/shape inference. 
Overall, this enables much smoother interoperability between JAX components (e.g. neural networks, ODE solves) 
and PyTensor/PyMC models. Contribution/discussion: <https://github.com/pymc-devs/pytensor/pull/1614>

</div>
