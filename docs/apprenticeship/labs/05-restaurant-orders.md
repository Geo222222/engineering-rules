# Lab 05 — Restaurant Order System

## Human Outcome

A customer chooses food, the restaurant receives an accurate order, the kitchen knows what to prepare, payment state is handled correctly, and the customer is told when the order is ready.

This lab is intentionally broad. It shows how software coordinates several humans performing different jobs toward one outcome.

---

# Beginning — The Script

Start with one script that displays a menu, accepts item selections, and calculates a total.

```text
MENU
Burger  8.00
Fries   3.00
Drink   2.00

CUSTOMER SELECTS
Burger + Fries + Drink

TOTAL
13.00
```

## Apprentice Work

Explain:

- how menu items are represented;
- how selections become line items;
- how quantity affects total;
- what happens when an unknown item is entered;
- what the script knows and what it does not know about a real restaurant.

## Gate

The apprentice can explain the complete script and recognizes that calculation alone does not fulfill an order.

---

# Next — The Order Has a Life Cycle

Introduce:

- order ID;
- customer name or number;
- line items;
- modifiers;
- quantities;
- order total;
- persistent storage;
- order status.

Use an explicit lifecycle such as:

```text
PLACED
  ↓
ACCEPTED
  ↓
PREPARING
  ↓
READY
  ↓
COMPLETED
```

Include failure or cancellation paths where appropriate.

## Apprentice Work

Explain:

- what causes each transition;
- who is allowed to perform it;
- which transitions should be impossible;
- whether status is merely text or part of a domain contract;
- what must be true before an order can be considered complete.

## Gate

The apprentice understands that business processes can be represented as controlled state machines.

---

# Then — Responsibilities Separate

Separate concepts such as:

- menu catalog;
- ordering;
- pricing;
- order lifecycle;
- kitchen workflow;
- payment;
- notification.

Move durable state to a database.

Introduce two different users of the same order:

- the customer cares about what was ordered, price, and readiness;
- the kitchen cares about preparation instructions, queue position, and status transitions.

## Apprentice Work

Trace the same order from both perspectives.

Identify shared facts and role-specific views.

## Gate

The apprentice understands that one domain object may serve multiple workflows without each interface becoming its own source of truth.

---

# Then — Components Cooperate

Introduce:

```text
Customer Ordering UI
        ↓
Order API
        ↓
Order Service ─────→ Payment Adapter
        ↓
Order Database
        ↓
Kitchen Display
        ↓
Status Update API
        ↓
Notification Worker
        ↓
Customer
```

Add:

- customer ordering interface;
- kitchen display system;
- order API;
- database;
- payment adapter;
- status transitions;
- notification worker;
- employee authorization;
- tests.

Investigate:

- customer submits the same order twice;
- payment succeeds but the response times out;
- kitchen display temporarily loses connectivity;
- two kitchen workers update the same order;
- an order is canceled after preparation begins;
- notification fails after the order becomes ready;
- a customer tries to modify an order after a cutoff point;
- menu availability changes while a customer is ordering.

## Gate

The apprentice can trace business intent across multiple user interfaces, services, data stores, external providers, and asynchronous side effects.

---

# End — The Whole System

Give the apprentice components rather than a finished architecture explanation:

- menu service or catalog module;
- customer frontend;
- kitchen frontend;
- order API;
- order lifecycle service;
- payment adapter;
- order database schema and migrations;
- notification worker;
- authorization middleware;
- background/retry configuration;
- tests;
- deployment configuration.

The apprentice must discover how the pieces make the system.

## Final Assignment

Produce:

1. the complete order lifecycle;
2. a system architecture diagram;
3. the path from menu selection to stored order;
4. the path from stored order to kitchen work;
5. the path from kitchen completion to customer notification;
6. payment authority and failure semantics;
7. user and employee authorization boundaries;
8. concurrency risks;
9. important invariants;
10. failure recovery behavior;
11. a verification ladder;
12. one scoped feature implemented without creating a parallel workflow.

Possible feature requests include:

- add pickup-time estimates;
- support an item modifier;
- mark an item temporarily unavailable;
- allow a kitchen worker to report an ingredient shortage;
- add a safe cancellation rule.

## Final Question

> A customer wanted food. Explain how every component in this system cooperated to turn that intent into prepared food in the customer's hands.

A complete answer should include more than code paths.

It should include the customer, restaurant staff, state, contracts, machines, data, payment, failure handling, and evidence.

That is the point of the lab.

The software is not the outcome.

The software coordinates the outcome.
