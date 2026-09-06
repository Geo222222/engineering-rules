# Engineering Apprenticeship Labs

The progressive lab track lives in [`docs/apprenticeship/LABS.md`](docs/apprenticeship/LABS.md).

These labs are part of the apprenticeship, not optional examples.

Each one begins with a small script and develops through the same sequence:

```text
Beginning — one understandable script
Next — state and validation appear
Then — responsibilities separate
Then — components cooperate
End — reconstruct and reason about the whole system
```

The five current system-building labs are:

1. [Appointment Booking System](docs/apprenticeship/labs/01-appointment-booking.md)
2. [Package Delivery Tracker](docs/apprenticeship/labs/02-package-delivery.md)
3. [Small Store Checkout System](docs/apprenticeship/labs/03-store-checkout.md)
4. [Smart Building Access System](docs/apprenticeship/labs/04-building-access.md)
5. [Restaurant Order System](docs/apprenticeship/labs/05-restaurant-orders.md)

## Repository Control Specialization

A separate operator-focused course teaches Git, GitHub collaboration, repository state, branch discipline, pull requests, CI evidence, deployability, and Docker runtime identity:

- [Git Repository Control — The Operator's Apprenticeship](docs/apprenticeship/git-repository-control/README.md)
- [Repository Control Command Reference](docs/apprenticeship/git-repository-control/COMMAND_REFERENCE.md)
- [Dirty Worktree to Verified Deployment Lab](docs/apprenticeship/git-repository-control/LAB.md)

This specialization trains the apprentice to answer, with commands and evidence, what branch they are on, whether the working tree is clean, whether GitHub changed, whether history diverged, whether a fix is isolated, whether tests truly passed, what will be pushed, whether a PR is safe to merge, whether `main` is deployable, and whether Docker is actually running the intended code.

The objective across all apprenticeship work is for the student to stop thinking in isolated files and begin seeing systems, contracts, boundaries, evidence, repository state, runtime state, and human outcomes.