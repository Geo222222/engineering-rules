# Lab 03 — Small Store Checkout System

## Human Outcome

A customer chooses goods, the business calculates what is owed, payment is handled correctly, inventory changes exactly once, and the customer receives a trustworthy receipt.

---

# Beginning — The Script

Start with a script that accepts item prices and calculates:

- subtotal;
- tax;
- total.

Example:

```text
INPUT
8.00, 3.00, 2.00
    ↓
SUBTOTAL
13.00
    ↓
TAX
1.04
    ↓
TOTAL
14.04
```

## Apprentice Work

Explain:

- each arithmetic operation;
- the type used for money;
- rounding behavior;
- why floating-point arithmetic can become dangerous for financial values;
- what happens when an invalid price is supplied.

## Gate

The apprentice understands that even simple arithmetic contains domain rules.

---

# Next — Products and State Appear

Replace raw prices with products.

Introduce:

- SKU or product ID;
- name;
- unit price;
- quantity;
- inventory count;
- discount rules;
- receipt output.

Persist products and sales locally.

Questions now include:

- Is the price taken from the product catalog or trusted from customer input?
- When should inventory decrease?
- Can inventory become negative?
- Is a discount a percentage, fixed amount, or promotion rule?
- What identifies one sale?

## Gate

The apprentice understands that values acquire authority and ownership inside a business system.

---

# Then — Transactions and Responsibilities Separate

Separate:

- catalog;
- cart;
- pricing;
- tax calculation;
- inventory;
- sale record;
- payment state;
- receipt generation.

Move durable state to a database.

Introduce states such as:

```text
SALE_OPEN
PAYMENT_PENDING
PAID
FAILED
REFUNDED
```

Establish invariants such as:

- inventory changes must correspond to a valid sale transition;
- a payment request is not proof of settlement;
- the same successful payment must not be applied twice;
- sale totals must be reproducible from authoritative line items and rules.

## Gate

The apprentice can explain why financial state transitions require stronger evidence than a successful HTTP response.

---

# Then — Components Cooperate

Introduce:

```text
Point-of-Sale UI
      ↓
Checkout API
      ↓
Pricing / Sales Service
      ↓
Payment Adapter ─────→ External Provider
      ↓
Sales Database
      ↓
Inventory Service
      ↓
Receipt Service
```

Add:

- cashier authentication;
- product lookup;
- transaction persistence;
- external payment adapter;
- idempotency keys;
- receipt generation;
- refund flow;
- tests.

Investigate failures such as:

- provider accepts a request but settlement is not complete;
- the API times out after the provider processed the payment;
- a cashier clicks Pay twice;
- inventory update succeeds but receipt generation fails;
- refund request is retried;
- database write fails after an external side effect.

## Gate

The apprentice can reason about exact-once business effects even when underlying networks may retry or fail ambiguously.

---

# End — The Whole System

Give the apprentice:

- POS frontend;
- product catalog code;
- checkout API;
- pricing service;
- payment adapter;
- database schema and migrations;
- inventory service;
- receipt generator;
- refund path;
- provider webhook handler;
- tests;
- configuration and deployment files.

## Final Assignment

Determine:

1. where authoritative product prices originate;
2. how totals are computed;
3. when a sale becomes `PAID`;
4. how provider callbacks affect local state;
5. how duplicate payment requests are prevented from duplicating business effects;
6. when inventory changes;
7. how refunds are represented;
8. what audit history must remain available;
9. what failure modes could lose money or inventory accuracy;
10. how to verify a change to checkout behavior without touching real production payments.

Then implement one scoped feature, such as a discount rule, without weakening financial invariants.

## Final Question

> How do multiple software components cooperate so that a human exchange of goods and money is represented accurately, safely, and audibly?

The apprentice should leave this lab understanding that financial software is not just arithmetic. It is controlled state transition backed by evidence.
