---
permalink: /
title: "About me"
excerpt: "About me"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

<div class="text-justify" markdown="1">

## Research interests

The human brain continuously integrates uncertain information to arrive at a course of action and to form new understanding. 
At a methodological level, this is an instance of inference under uncertainty: combining prior knowledge with noisy, incomplete observations. 
This perspective motivates my interest in building models that connect the mechanisms of complex, 
dynamical systems to the data we can observe and in developing inference tools that 
let us do so reliably.

I use Bayesian inference as a principled framework for this: combining mechanistic models 
with data, propagating uncertainty through the full analysis, and comparing competing hypotheses. 
These strengths matter most when we cannot fully control a system experimentally, 
when data are limited, and when uncertainty itself is an essential part of the result. 

During the COVID-19 pandemic we and other groups used such  
Bayesian approaches to quantify uncertainty in key epidemiological
quantities and to infer changes in spreading dynamics under interventions, precisely
because the system is high-dimensional, partially observed, and only indirectly controllable.

In parallel, I work on methodological improvements that make Bayesian modeling more efficient and easier to apply in practice. 
This includes improving gradient-based sampling (e.g. Hamiltonian Monte Carlo / NUTS) via better parametrization and preconditioning, 
and by exploiting curvature information to adapt metrics and step sizes in challenging posterior geometries. 
I also integrate modern automatic-differentiation and deep-learning tools to enable 
richer models of dynamical processes.

</div>
