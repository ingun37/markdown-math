//
//  Data.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/27.
//

import Foundation
var initialMarkdown = """
Given a series $` \\sum^\\infin_{n=1}a_n`$ with $` a_n \\neq 0`$, the Ratio Test states that if $`(a_n)`$ satisfies

```math
\\lim \\left| \\frac {a_{n+1}} {a_n} \\right| = r < 1,
```

then the series converges absolutely.

## Question

Now, show that $` \\sum | a_n | `$ converges, and conclude that $` \\sum a_n `$ converges.

## Answer

Let $` r' `$ satisfy $` r < r' < 1 `$.

Sequence

```math
|a_0|, |r'a_0|, |r'^2 a_0|, |r'^3 a_0|, \\dots
```

is (eventually) bigger than the original sequence $`(|a_n|)`$ and has convergent partial sums becasue it's a geometric series.

Therefore by Comparison Test, $`\\sum |a_n|`$ converges and therefore $` \\sum a_n `$ converges too.
"""
