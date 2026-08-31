# Lab 01 — Appointment Booking System

## Human Outcome

A person wants to reserve a specific service at a valid time without the business accidentally promising the same capacity to two people.

The system exists to make that agreement reliable.

---

# Beginning — The Script

Start with one script.

It asks for:

- customer name;
- service;
- appointment date;
- appointment time.

It prints a confirmation.

Example mental model:

```text
INPUT
customer + service + date + time
    ↓
PROCESS
format the appointment
    ↓
OUTPUT
booking confirmation
```

## Apprentice Work

Read the script before changing it.

Explain:

- every input;
- every variable;
- every branch;
- every output;
- what would happen with missing or malformed input.

## Gate

The apprentice can explain why the script produces its result without treating any line as magic.

---

# Next — State Appears

A confirmation printed to the terminal is not yet a booking system.

The appointment must survive after the process exits.

Add:

- file persistence;
- service duration;
- business hours;
- basic date/time validation;
- duplicate-slot detection.

Now the apprentice encounters state.

Questions change:

- Where is the appointment stored?
- What is the source of truth?
- Can two records occupy the same slot?
- What happens if the file is malformed?
- How is time represented?

## Gate

The apprentice understands that persistent state creates constraints that a stateless script did not have.

---

# Then — Responsibilities Separate

The single script has too many responsibilities.

Separate concepts such as:

- customer;
- service;
- appointment;
- availability;
- persistence;
- validation.

Move storage from a flat file to a database.

Introduce a database schema and explicit contracts.

The apprentice should now confront an invariant such as:

> A resource cannot be authoritatively booked for overlapping appointments that exceed its capacity.

## Apprentice Work

Trace one booking from input to persistence.

Identify:

- validation boundary;
- scheduling rule;
- persistence boundary;
- authoritative appointment ID;
- failure cases.

## Gate

The apprentice can explain why the system is divided into responsibilities rather than merely listing filenames.

---

# Then — Components Cooperate

Introduce separate components:

```text
Customer Booking UI
        ↓
Booking API
        ↓
Scheduling Service
        ↓
Appointment Database
        ↓
Notification Adapter
```

Add:

- customer-facing booking form;
- staff-facing appointment view;
- HTTP API;
- database persistence;
- notification interface;
- authentication for staff operations;
- tests.

Now ask questions that do not exist in the first script:

- Who is allowed to cancel an appointment?
- Does the UI decide availability, or does the server?
- What happens when two customers submit the same slot simultaneously?
- What happens if the appointment commits but notification delivery fails?
- Is a failed text message the same thing as a failed booking?

## Gate

The apprentice can trace one booking across component boundaries and distinguish domain state from side effects.

---

# End — The Whole System

Do not hand the apprentice a diagram first.

Give them a component pack containing items such as:

- frontend booking application;
- staff schedule interface;
- API routes;
- scheduling service;
- database models and migrations;
- authentication middleware;
- notification adapter;
- configuration;
- tests;
- deployment files.

The apprentice must reconstruct the system.

## Final Assignment

Produce:

1. a system diagram;
2. the booking path from human intent to persisted appointment;
3. the cancellation path;
4. the authoritative source for availability;
5. important contracts and invariants;
6. concurrency risks;
7. authorization boundaries;
8. notification failure behavior;
9. the verification ladder for a scheduling change;
10. one proposed feature implemented using the smallest coherent change.

## Final Question

> How do all of these pieces work together so that a human can confidently reserve time with another human or business?

If the apprentice can answer that with evidence from the system, they are no longer looking at scripts as isolated code. They are thinking about software as coordinated behavior.
