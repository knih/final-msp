# final-msp

An implementation of the LINT (Little Integer) language
in the typed final style with multi-stage programming.

## Interpreters

The final-msp interpreters corresponds to the evaluators of
"A Gentle Introduction to Multi-stage Programming".

| Interpreter                           | Program of the paper |
|---------------------------------------|----------------------|
| `Lint.Simple`                         | `eval1`              |
| `Lint.SimpleStaged`                   | `eval2`              |
| `Lint.ErrorHandling`                  | `eval3`              |
| `Lint.ErrorHandlingStaged`            | `eval4`              |
| `Lint.CpsErrorHandling`               | `eval5`              |
| `Lint.CpsErrorHandlingStaged`         | `eval6`              |
| `Lint.InliningStaged`                 | `eval7`              |
| `Lint.InliningNoDupStaged`            | `eval8`              |
| `Lint.InliningCPSErrorHandlingStaged` | `eval9`              |

## Bibliography

1. Taha, W. (2004). A Gentle Introduction to Multi-stage Programming. In C. Lengauer, D. Batory, C. Consel, & M. Odersky (Eds.), Domain-Specific Program Generation: International Seminar, Dagstuhl Castle, Germany, March 23-28, 2003. Revised Papers (pp. 30–50). Berlin, Heidelberg: Springer Berlin Heidelberg. http://doi.org/10.1007/978-3-540-25935-0_3

