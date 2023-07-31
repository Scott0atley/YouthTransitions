# Optimal Matching Analysis
#### (2020) - Gary Pollock
**Journal**: SAGE Research Methods Foundations
**Link**:: https://methods.sagepub.com/foundations/optimal-matching-analysis
**DOI**:: 10.4135/9781526421036837530
**Links**:: 
**Tags**:: #paper #Methods #OptimalMatchingAnalysis 
**Cite Key**:: [@pollockOptimalMatchingAnalysis2020]

### Abstract

```
Optimal matching analysis (OMA) is used to analyse longitudinal data. It is of particular use when the order of the data is important, for example, the timing of different events. OMA is the most widely used method of analysing sequential data. A typical example is an individual (the case) and their employment status (the variable) measured at discrete points in time (say every year) over a certain period. Not just individuals but organisations, groups, nations, and so on, can constitute the case. The variable for each case is measured over time and thus represents a connected ordered sequence, a historical representation of how that case has evolved. The connectedness of the values that the variable takes over time is important as each sequence is able to articulate complex changes in status—some cases may have a volatile character with many status changes, while others are relatively stable, with low levels of variability from one time point to the next. This procedure can handle longitudinal complexity in distinctive ways: (1) it does not require a focus on a specific event or duration, (2) it uses all available data when processing sequence comparisons (i.e., all time points in the sequence are used and treated as a single dependency), and (3) data processing facilitates the identification of patterns or structures among the sequences. The value of OMA is in being able to process data so as to preserve its longitudinal complexity and to provide a framework for the exploration of structural patterns within sequential data.
```

### Notes

(Pollock, 2020, p. 1) This document was created with Prince, a great way of getting web content onto paper.

“Optimal matching analysis (OMA) is used to analyse longitudinal data. It is of particular use when the order of the data is important, for example, the timing of different events.” (Pollock, 2020, p. 2)

“A typical example is an individual (the case) and their employment status (the variable) measured at discrete points in time (say every year) over a certain period. Not just individuals but organisations, groups, nations, and so on, can constitute the case.” (Pollock, 2020, p. 2)

“This procedure can handle longitudinal complexity in distinctive ways: (1) it does not require a focus on a specific event or duration, (2) it uses all available data when processing sequence comparisons (i.e., all time points in the sequence are used and treated as a single dependency), and (3) data processing facilitates the identification of patterns or structures among the sequences.” (Pollock, 2020, p. 2)

“o process data so as to preserve its longitudinal complexity and to provide a framework for the exploration of structural patterns within sequential data.” (Pollock, 2020, p. 2)

“Optimal matching analysis (OMA) is a technique to compare, or “match,” different strings of data and is “optimal” to the extent that the comparison is done with the aim of finding an efficient way of expressing the closeness of one string to another.” (Pollock, 2020, p. 2)

“Life can be thought of as a series of sequences which can describe what has happened to us over the years. Take any sphere of life, education, employment, where we live, who we have had romantic attachments to, leisure pursuits that we have participated in, and so forth.” (Pollock, 2020, p. 3)

“The importance of time in social science research is implicit. While research undertaken without a temporal dimension is widespread, interest in it generally stems from comparisons with an earlier period or hypotheses about how things may change in the future. So, even when a specific project is a one-off study, there remains an interest in time-based questions.” (Pollock, 2020, p. 4)

“In the early days of social science, life-history methods were argued to be superior to all others (Thomas & Znaniecki, 1927). This assertion was premised upon the importance of a rich contextualised account of a life, where individual experiences, over time, can be placed within a broader context with a view to understanding how and why change occurred.” (Pollock, 2020, p. 4)

“Faced with a large data set, conceivably of thousands of individuals with their employment experience measured every month over a 5-year period, a visual inspection of data or some basic statistical summaries will not adequately represent the data. To be able to find patterns in the data that might be of interest to social scientists, a method that applies a common set of procedures to the whole data set and which has consistent results is needed.” (Pollock, 2020, p. 9)

“Given any sequence pair, OMA is used to work out the “cost” of transforming one sequence into the other using a set of “elementary operations” also known as “edits.” The elementary operations are insertion, deletion (collectively known as indels), and substitutions. The OMA algorithm methodically searches for the cheapest way of transforming one sequence into another using a dynamic algorithm (i.e., one which is recursive and able to select the most efficient solution).” (Pollock, 2020, p. 10)

“There are two strategies for determining substitution costs, firstly a data-driven method where-” (Pollock, 2020, p. 17)

“by the transition rates between different statuses are used to weight the costs such that unlikely transitions have a high cost and frequent transitions have a lower cost. The alternative is a theoretical approach, where it is theorised that some swaps ought to be “cheaper” than others. If marital status is taken as an example (Pollock, 2007), the exact number of transitions between different marital statuses from the data set could be worked out or the costs could be set directly.” (Pollock, 2020, p. 18)

“Data-driven substitution costs are, however, commonly used, typically using the frequency of transitions from one status to another within a data set. This raises an important theoretical issue about the correspondence between the aggregated transition data and the unfolding of an individual sequence. That a transition is common within a data set is arguably not a good reason to set its substitution cost low. Firstly, because substitutions operate across the two sequences being compared and therefore not in terms of a longitudinal process within a sequence. Secondly, it is an ecological error to equate an aggregate statistic to an individual case when much of what is being explored concerns the prevalence of patterns of difference and similarity.” (Pollock, 2020, p. 18)

“When a sequence is linked to a regular temporal pattern and it is important to retain the integrity of the position of the measures, otherwise there is a time shift (or warp), an alternative to the Levenshtein distance can be appropriate. For example, when activity is measured over a 24-hr period, it is important not to artificially shift the timing of activities if one is precisely interested in these timings. Analyses of the workweek require that activities are not shifted from one day into another, or from one time of day into another, as this time shifting undermines the substantive interest in comparisons of working patterns (Lesnard, 2010).” (Pollock, 2020, p. 19)

“OMA is computationally intensive. It has also been criticised for being something of a black box technique, “detecting” patterns in data sets in a purely inductive way.” (Pollock, 2020, p. 20)