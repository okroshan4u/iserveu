# Decision Log – iSupayX Assessment

## Approach & Prioritization
Started with Phoenix API setup, then core schemas and validation pipeline.

## Clarifications & Assumptions
- Only INR currency supported.
- KYC statuses `verified` and `approved` treated as valid.
- Compliance flags transactions >= 200000 INR.
- Velocity checks applied per merchant per payment method.

## AI Interaction Log
(Will update)

## Validation Layer Analysis
1. Schema Layer – structural and type validation
2. Entity Layer – merchant, payment method, and association checks
3. Business Rule Layer – amount and limits enforcement
4. Compliance Layer – flag-only regulatory checks
5. Risk Layer – velocity and fraud heuristics


## Contradictions Found
(To be filled)

## Hidden Dependencies
- Merchant and PaymentMethod have a many-to-many relationship via MerchantPaymentMethod.
- Junction table carries business fields like min_amount, max_amount, and daily_limit.
- This relationship directly impacts entity and business rule validation.


## Known limitations and fixes
-- Fixed a compile-time struct resolution error by moving schema modules under lib/isupayx/, ensuring they are      compiled by the application.


## Bug Fixes / Learnings
-- - Normalized numeric comparisons by converting request amounts to Decimal to avoid integer–decimal comparison issues in business rule validation.


## Update
-- Added Pub/Sub event module under lib/isupayx/events for transaction lifecycle events.
- Used separate seeders for development (priv/repo/seeds.exs) and test environment to keep production logic isolated from test infrastructure.
- Business rule validation enforces transaction amount limits. While the iSupayX specification defines min/max limits - per payment method with merchant-level overrides, a simplified global limit was implemented for the assessment scope, aligning with the minimum required validations.

