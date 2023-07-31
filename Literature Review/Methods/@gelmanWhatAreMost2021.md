# What are the Most Important Statistical Ideas of the Past 50 Years?
#### (2021) - Andrew Gelman, Aki Vehtari
**Journal**: Journal of the American Statistical Association
**Link**:: https://www.tandfonline.com/doi/full/10.1080/01621459.2021.1938081
**DOI**:: 10.1080/01621459.2021.1938081
**Links**:: 
**Tags**:: #paper #Methods 
**Cite Key**:: [@gelmanWhatAreMost2021]

### Abstract

```
We review the most important statistical ideas of the past half century, which we categorize as: counterfactual causal inference, bootstrapping and simulation-based inference, overparameterized models and regularization, Bayesian multilevel models, generic computation algorithms, adaptive decision analysis, robust inference, and exploratory data analysis. We discuss key contributions in these subfields, how they relate to modern computing and big data, and how they might be developed and extended in future decades. The goal of this article is to provoke thought and discussion regarding the larger themes of research in statistics and data science.
```

### Notes

“The key idea is that causal identification is possible, under assumptions, and that one can state these assumptions rigorously and address them, in various ways, throughdesignandanalysis” (Gelman and Vehtari, 2021, p. 2087)

“there has been a common thread of modeling causal questions in terms of counterfactuals or potential outcomes” (Gelman and Vehtari, 2021, p. 2087)

“Key developments include Neyman (1923), Welch (1937), Rubin (1974), and Haavelmo (1943); see Heckman and Pinto (2015) for some background and VanderWeele (2015)fora recent review.” (Gelman and Vehtari, 2021, p. 2087)

“purpose of the aforementioned methods is to define and estimate the effect of some specified treatment or exposure, adjusting for biases arising from imbalance, selection, and measurement errors.” (Gelman and Vehtari, 2021, p. 2087)

“There is a long history of such ideas using methods of path analysis, from researchers in various fields of application such as genetics (Wright 1923), economics (Wold 1954), and sociology (Duncan 1975); as discussed by Wermouth (1980), these can be framed in terms of simultaneous equation models.” (Gelman and Vehtari, 2021, p. 2087)

“Perhaps, the purest example of a computationally defined statistical method is the bootstrap, in which some estimator is defined and applied to a set of randomly resampled datasets (Efron 1979;Efronand Tibshirani 1993). The idea is to consider the estimate as an approximate sufficient statistic of the data and to consider the bootstrap distribution as an approximation to the sampling distribution of the data.” (Gelman and Vehtari, 2021, p. 2088)

“Parametric bootstrapping, prior and posterior predictive checking (Box 1980;Rubin1984), and simulation-based calibration all create replicated datasets from a model instead of directly resampling from the data.” (Gelman and Vehtari, 2021, p. 2088)

“A major change in statistics since the 1970s, coming from many different directions, is the idea of fitting a model with a large number of parameters—sometimes more parameters than data points—using some regularization procedure to get stable estimates and good predictions.” (Gelman and Vehtari, 2021, p. 2088)

“Early examples of richly parameterized models include Markov random fields (Besag 1974), splines (Wahba and Wold 1975;Wahba1978), and Gaussian processes (O’Hagan 1978),” (Gelman and Vehtari, 2021, p. 2088)

“The 1970s also saw the start of the development of Bayesian nonparametric priors on infinite dimensional families of probability models (Müller and Mitra 2013),” (Gelman and Vehtari, 2021, p. 2088)

“Many of these models had limited usage until enough computational resources became easily available” (Gelman and Vehtari, 2021, p. 2088)

“Multilevel or hierarchical models have parameters that vary by group, allowing models to adapt to cluster sampling, longitudinal studies, time-series cross-sectional data, meta-analysis, and other structured settings.” (Gelman and Vehtari, 2021, p. 2088)

“MultilevelmodelscanbeseenasBayesianinthattheyinclude probability distributions for unknown latent characteristics or varying parameters. Conversely, Bayesian models have a multilevel structure with distributions for data given parameters and for parameters given hyperparameters” (Gelman and Vehtari, 2021, p. 2088)

“Rather than considering multilevel modeling as a specific statistical model or computational procedure, we prefer to think of it as a framework for combining different sources of information, and as such it arises whenever we wish to make inferences from a subset of data (small-area estimation) or to generalize data to new problems (meta-analysis).” (Gelman and Vehtari, 2021, p. 2089)

“Bayesian inference has been valuable not just as a way of combining prior information with data but also as a way of accounting for uncertainty for inference and decision making.” (Gelman and Vehtari, 2021, p. 2089)

“key component has been advances in statistical algorithms for efficient computing.” (Gelman and Vehtari, 2021, p. 2089)

“Throughout the history of statistics, advances in data analysis, probability modeling, and computing have gone together, with new models motivating innovative computational algorithms and new computing techniques opening the door to more complex models and new inferential ideas, as we have already noted in the context of high-dimensional regularization, multilevel modeling, and the bootstrap. The generic automatic inference algorithms allowed decoupling the development of the models so that changing the model did not require changes to the algorithm implementation.” (Gelman and Vehtari, 2021, p. 2089)

“From the 1940s through the 1960s, decision theory was often framed as foundational to statistics, via utility maximization (Wald 1949;Savage1954), error-rate control (Tukey 1953; Scheffé 1959), and empirical Bayes analysis (Robbins 1956, 1964), and recent decades have seen developments following up this work, in the Bayesian decision theory (Berger 1985)and false discovery rate analysis (Benjamini and Hochberg 1995). Decision theory has also been influenced from the outside by psychology research on heuristics and biases in human decision making (Kahneman, Slovic, and Tversky 1982; Gigerenzer and To dd 1999)” (Gelman and Vehtari, 2021, p. 2089)

“The idea of robustness is central to modern statistics, and it is allabouttheideathatwecanusemodelsevenwhentheyhave assumptions that are not true” (Gelman and Vehtari, 2021, p. 2089)

“In general, though, the main impact of robustness in statistical research is not in the development of particular methods, so much as in the idea of evaluating statistical procedures under what Bernardo and Smith (1994)calltheM-open world in which the data-generating process does not fall within the class of fitted probability models” (Gelman and Vehtari, 2021, p. 2090)