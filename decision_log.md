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
