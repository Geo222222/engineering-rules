# Lab 04 — Smart Building Access System

## Human Outcome

A person presents a credential and the system decides whether a physical door should unlock. The decision must be fast, authorized, auditable, and safe when information or infrastructure is unavailable.

---

# Beginning — The Script

Start with one script that checks whether a badge ID appears in an allowed list.

```text
INPUT
badge ID
    ↓
LOOKUP
allowed list
    ↓
DECISION
ACCESS GRANTED / ACCESS DENIED
```

## Apprentice Work

Explain:

- how the badge is represented;
- where the allowed list comes from;
- what happens when the badge is unknown;
- what happens when input is malformed;
- why a printed `ACCESS GRANTED` is not yet the same as opening a real door.

## Gate

The apprentice understands that code can represent a decision before it controls a physical consequence.

---

# Next — Policy Appears

Replace the single allowed list with rules.

Introduce:

- employee identity;
- badge identity;
- door identity;
- building or zone;
- access level;
- time restrictions;
- active/inactive credentials;
- access-attempt logging.

Now the question becomes more than "is this badge listed?"

It becomes:

> Is this credential authorized to open this door under these conditions at this time?

## Apprentice Work

Trace the facts required to make that decision.

Identify which facts should fail closed when missing or ambiguous.

## Gate

The apprentice understands the difference between identity, authentication, policy, and authorization.

---

# Then — Responsibilities Separate

Separate:

- credential reader input;
- identity resolution;
- access policy;
- door state;
- access logs;
- administrative configuration.

Persist users, badges, doors, policies, and access attempts.

Introduce invariants such as:

- an inactive badge cannot authorize entry;
- a user cannot obtain access merely by changing client-supplied role or zone data;
- every physical unlock decision should be attributable to a decision record when the system design supports it;
- loss of connectivity must have an explicit policy rather than an accidental fallback.

## Gate

The apprentice can explain where authorization must occur and why a user interface is not a security boundary.

---

# Then — Components Cooperate

Introduce:

```text
Badge Reader
    ↓
Door Controller
    ↓
Access Decision API
    ↓
Policy Engine
    ↓
Identity / Access Database
    ↓
Audit Log

Admin Dashboard → Policy Management API
```

Add:

- hardware or simulated reader input;
- door controller interface;
- server-side policy evaluation;
- administrator interface;
- audit history;
- alerts for suspicious attempts;
- configuration for offline behavior;
- tests.

Investigate:

- duplicated badge scans;
- revoked badges;
- expired permissions;
- a reader losing network connectivity;
- a door controller receiving a delayed response;
- server unavailable during an emergency;
- malicious client data claiming a different user or zone;
- audit logs failing after a physical action.

## Gate

The apprentice can reason about software where a bug can cause a real physical security event.

---

# End — The Whole System

Give the apprentice a component pack containing:

- badge-reader simulator or device adapter;
- door-controller interface;
- access API;
- policy engine;
- identity models;
- access-policy models;
- database migrations;
- admin dashboard;
- audit subsystem;
- alerting path;
- offline/failure configuration;
- tests;
- deployment files.

## Final Assignment

Determine:

1. how a badge scan becomes a physical unlock decision;
2. which component owns authorization;
3. which data is trusted and which data must be validated;
4. the default behavior when identity or policy cannot be established;
5. how revocation propagates;
6. how offline behavior is controlled;
7. what must be logged;
8. which failures could create unsafe access;
9. which failures could incorrectly deny legitimate access;
10. how to test policy changes without risking a real secured facility.

Then implement one scoped policy change and prove both allowed and denied behavior.

## Final Question

> How does software safely turn digital identity and policy into a physical consequence?

This lab makes the apprenticeship's central point visible: code is everywhere. The screen is only one place where software expresses itself.
