# Prompt Rules

## Strong Defaults

- One page, one prompt.
- Put exact allowed text lines at the end.
- Tell the model each line appears once only.
- Prefer fewer, larger text groups.

## Repair Rules

- Repeated text -> assign one line to one region.
- Blurry text -> enlarge text blocks and forbid glow or blur.
- Random labels -> replace chart-like shapes with abstract graphics.
- Unwanted numeric markers -> explicitly forbid digits and percent signs.
