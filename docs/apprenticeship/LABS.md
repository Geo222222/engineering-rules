# Progressive Engineering Labs

The apprenticeship teaches engineering principles. The labs make the apprentice experience those principles.

These are not demonstrations to read once and forget. Each lab begins as a small, understandable script and grows in controlled stages until the apprentice is looking at a complete system made of cooperating parts.

The same system is revisited as the apprentice's ability grows.

The teaching pattern is deliberate:

```text
BEGINNING
one script
    ↓
NEXT
state and validation
    ↓
THEN
multiple responsibilities
    ↓
THEN
multiple components
    ↓
END
a working system whose parts serve one human outcome
```

The apprentice should never be handed complexity without first understanding the simpler form from which it grew.

## The Five Labs

1. [Appointment Booking System](labs/01-appointment-booking.md)
2. [Package Delivery Tracker](labs/02-package-delivery.md)
3. [Small Store Checkout System](labs/03-store-checkout.md)
4. [Smart Building Access System](labs/04-building-access.md)
5. [Restaurant Order System](labs/05-restaurant-orders.md)

## How to Use the Labs

Each lab has five levels:

- **Beginning — The Script**
- **Next — State Appears**
- **Then — Responsibilities Separate**
- **Then — Components Cooperate**
- **End — The Whole System**

At the beginning, the apprentice should be able to explain nearly every line and every value.

At the end, the apprentice may receive multiple components instead of a finished application. The job changes from "write this function" to questions such as:

- What does each component own?
- Which component is authoritative for each fact?
- How does information move between them?
- What contracts connect them?
- Where are the trust boundaries?
- What can fail?
- What must never happen?
- Which component should change for a given requirement?
- How would you prove that change worked?
- How do all of these pieces produce the outcome the user actually wanted?

That final reconstruction is intentional. The apprentice must learn to see the pie after first learning to recognize the ingredients.

## Lab Rule

Do not solve later stages by hiding complexity behind unexplained frameworks, generated code, or copied solutions.

Tools may be used. Libraries may be used. AI may be used.

But the apprentice remains responsible for understanding the system they submit.

A tool can accelerate engineering work. It cannot substitute for engineering judgment.

## Instructor Use

These labs can be taught sequentially or selected according to the apprentice's interests. The technical surface differs, but the engineering lessons repeat from different angles:

| Lab | Strongest Lessons |
| --- | --- |
| Appointment Booking | time, state, concurrency, APIs, SaaS workflows |
| Package Delivery | events, history, state derivation, distributed updates |
| Store Checkout | money, transactions, idempotency, inventory, external payment state |
| Building Access | physical consequences, authorization, policy, auditability, fail-safe behavior |
| Restaurant Orders | workflow orchestration, status machines, multiple user interfaces, real-world operations |

Repetition is a feature. An apprentice who sees the same engineering principles survive across unrelated domains is beginning to understand the discipline rather than one technology stack.
