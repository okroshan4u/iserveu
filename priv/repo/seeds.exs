alias Isupayx.Repo
alias Isupayx.Schemas.{Merchant, PaymentMethod, MerchantPaymentMethod}
import Decimal

# ---------- Merchant ----------
merchant =
  Repo.insert!(%Merchant{
    name: "Test Merchant",
    api_key: "test_api_key_123",
    onboarding_status: "activated",
    kyc_status: "verified",
    is_active: true
  })

# ---------- Payment Methods ----------
upi =
  Repo.insert!(%PaymentMethod{
    name: "UPI",
    code: "upi",
    min_amount: new("1"),
    max_amount: new("100000"),
    is_active: true
  })

credit_card =
  Repo.insert!(%PaymentMethod{
    name: "Credit Card",
    code: "credit_card",
    min_amount: new("100"),
    max_amount: new("500000"),
    is_active: true
  })

debit_card =
  Repo.insert!(%PaymentMethod{
    name: "Debit Card",
    code: "debit_card",
    min_amount: new("100"),
    max_amount: new("200000"),
    is_active: true
  })

net_banking =
  Repo.insert!(%PaymentMethod{
    name: "Net Banking",
    code: "net_banking",
    min_amount: new("100"),
    max_amount: new("1000000"),
    is_active: true
  })

wallet =
  Repo.insert!(%PaymentMethod{
    name: "Wallet",
    code: "wallet",
    min_amount: new("1"),
    max_amount: new("50000"),
    is_active: true
  })

bnpl =
  Repo.insert!(%PaymentMethod{
    name: "BNPL",
    code: "bnpl",
    min_amount: new("500"),
    max_amount: new("100000"),
    is_active: true
  })

# ---------- Merchant ↔ Payment Method ----------
Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: upi.id,
  min_amount: new("1"),
  max_amount: new("200000"),
  daily_limit: new("9000000"),
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: credit_card.id,
  min_amount: new("50"),
  max_amount: new("200000"),
  daily_limit: new("1000000"),
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: debit_card.id,
  min_amount: new("100"),
  max_amount: new("200000"),
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: net_banking.id,
  min_amount: new("100"),
  max_amount: new("1000000"),
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: wallet.id,
  min_amount: new("1"),
  max_amount: new("10000"),
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: bnpl.id,
  min_amount: new("500"),
  max_amount: new("100000"),
  is_active: true
})

IO.puts("✅ Seed data inserted successfully")
