# Lab 02 — Package Delivery Tracker

## Human Outcome

A sender or recipient wants to know where a package is, what has happened to it, and whether the system can be trusted when it says the package was delivered.

---

# Beginning — The Script

Start with one script that accepts a tracking number and prints a status.

Example:

```text
INPUT
tracking number
    ↓
LOOKUP
package record
    ↓
OUTPUT
IN TRANSIT
```

Use a small in-memory dictionary or local file.

## Apprentice Work

Explain:

- how the tracking number selects a record;
- where the status comes from;
- what happens when the number does not exist;
- why a printed value is only as trustworthy as its source.

## Gate

The apprentice understands lookup, identity, and the difference between an identifier and the thing it identifies.

---

# Next — History Appears

Replace one mutable status with package events.

Examples:

```text
LABEL_CREATED
PICKED_UP
ARRIVED_AT_FACILITY
DEPARTED_FACILITY
OUT_FOR_DELIVERY
DELIVERED
```

Each event carries:

- tracking number;
- event type;
- timestamp;
- location;
- source.

The current status is now derived from history rather than stored as an unexplained string.

## Apprentice Work

Explain:

- the difference between an event and current state;
- how event ordering matters;
- what happens if an old event arrives late;
- why timestamps and event identity are contracts.

## Gate

The apprentice can derive current package state from a sequence of facts.

---

# Then — Responsibilities Separate

Separate:

- package identity;
- event ingestion;
- event storage;
- state derivation;
- tracking lookup.

Move package and event records into a database.

Introduce rules such as:

- a tracking number is stable;
- historical events are not silently rewritten;
- duplicate scanner submissions should not create duplicate authoritative events;
- a package cannot be considered delivered merely because a request to record delivery was accepted.

## Gate

The apprentice understands that history, current state, and transport requests are different things.

---

# Then — Components Cooperate

Introduce:

```text
Scanner / Driver Device
        ↓
Event Ingestion API
        ↓
Package Event Store
        ↓
Tracking State Projector
        ↓
Customer Tracking API
        ↓
Tracking Web Page
```

Add a notification worker for major events.

Now investigate:

- duplicate scanner submissions;
- offline devices syncing later;
- events arriving out of order;
- a notification failing after an event is safely stored;
- a customer refreshing while a projection is slightly behind;
- audit requirements around delivery confirmation.

## Gate

The apprentice can separate authoritative events from derived views and secondary side effects.

---

# End — The Whole System

Give the apprentice components such as:

- scanner event producer;
- event ingestion API;
- package database schema;
- event table;
- state projection worker;
- customer tracking API;
- tracking frontend;
- notification worker;
- retry configuration;
- tests and deployment artifacts.

Do not initially explain the intended architecture.

## Final Assignment

The apprentice must determine:

1. how a physical scan becomes a customer-visible status;
2. which record is authoritative;
3. how duplicate events are handled;
4. how late events are handled;
5. what evidence supports `DELIVERED`;
6. what happens when notification delivery fails;
7. where idempotency belongs;
8. which components may safely rebuild their state from history;
9. how to diagnose a package whose customer view disagrees with its event history;
10. how to verify a change to delivery-state logic.

## Final Question

> How does a physical event in the world become a trustworthy digital fact that another person can rely on?

This lab teaches that software often does not merely store state. It observes events, preserves evidence, derives meaning, and presents that meaning to people.
