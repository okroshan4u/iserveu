# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Isupayx.Repo.insert!(%Isupayx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Isupayx.Repo
alias Isupayx.Schemas.{Merchant, PaymentMethod, MerchantPaymentMethod}

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
    min_amount: 10,
    max_amount: 100_000,
    is_active: true
  })

card =
  Repo.insert!(%PaymentMethod{
    name: "Credit Card",
    code: "credit_card",
    min_amount: 50,
    max_amount: 200_000,
    is_active: true
  })

# ---------- Merchant ↔ Payment Method ----------
Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: upi.id,
  min_amount: 10,
  max_amount: 100_000,
  daily_limit: 500_000,
  is_active: true
})

Repo.insert!(%MerchantPaymentMethod{
  merchant_id: merchant.id,
  payment_method_id: card.id,
  min_amount: 50,
  max_amount: 200_000,
  daily_limit: 1_000_000,
  is_active: true
})

IO.puts("✅ Seed data inserted successfully")
