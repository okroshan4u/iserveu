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
(To be filled)

## Contradictions Found
(To be filled)

## Hidden Dependencies
- Merchant and PaymentMethod have a many-to-many relationship via MerchantPaymentMethod.
- Junction table carries business fields like min_amount, max_amount, and daily_limit.
- This relationship directly impacts entity and business rule validation.
