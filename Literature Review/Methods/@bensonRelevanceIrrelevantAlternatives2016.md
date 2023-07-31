# On the Relevance of Irrelevant Alternatives
#### (2016) - Austin R. Benson, Ravi Kumar, Andrew Tomkins
**Journal**: Proceedings of the 25th International Conference on World Wide Web
**Link**:: https://dl.acm.org/doi/10.1145/2872427.2883025
**DOI**:: 10.1145/2872427.2883025
**Links**:: 
**Tags**:: #paper #Methods #IrrelevantAlternatives 
**Cite Key**:: [@bensonRelevanceIrrelevantAlternatives2016]

### Abstract

```
Multinomial logistic regression is a powerful tool to model choice from a finite set of alternatives, but it comes with an underlying model assumption called the independence of irrelevant alternatives, stating that any item added to the set of choices will decrease all other items’ likelihood by an equal fraction. We perform statistical tests of this assumption across a variety of datasets and give results showing how often it is violated.
```

### Notes

“Multinomial logistic regression is a powerful tool to model choice from a finite set of alternatives, but it comes with an underlying model assumption called the independence of irrelevant alternatives, stating that any item added to the set of choices will decrease all other items’ likelihood by an equal fraction.” (Benson et al., 2016, p. 963)

“When this axiom is violated, choice theorists will often invoke a richer model known as nested logistic regression, in which information about competition among items is encoded in a tree structure known as a nest.” (Benson et al., 2016, p. 963)

“A property of the multinomial logit model is the “independence of irrelevant alternatives” (IIA), i.e., the relative probability of someone choosing between two options is independent of any additional alternatives in the choice set” (Benson et al., 2016, p. 964)

“The nested logit model, originally introduced by McFadden [21], encapsulates this process. In the nested logit, the choices are grouped into nests (clusters) such that IIA holds within a nest but not necessarily between nests.” (Benson et al., 2016, p. 965)

“All the tests are of the following flavor: under the null hypothesis that IIA holds, certain random variables should have the same distribution, which can be checked by statistical tests” (Benson et al., 2016, p. 965)

“Small and Hsiao provide a modified version of the McFadden test to avoid asymptotic bias towards accepting the null hypothesis [27]. An alternative test proposed by Hausman and McFadden [13] uses a Hausman test [14] to compare the estimated parameters from the full and restricted models. Cheng and Long survey and empirically evaluate these tests [8].” (Benson et al., 2016, p. 972)