# a.DI Diffs Repository

In this repository, we will add the diffs between different revisions of the Aave Delivery Infrastructure deployments.
This way in this repository, there will be a way to search code updates between deployments.

The diffs are done between currently used contracts and newly deployed ones.


## Revision tables
| Revision | Diffs | Updates |
|----------|-------|---------|
| Rev2 | [diffs](./diffs/rev2) | Added name and provider gas limit to bridge adapters. Updated CCC implementation (Receiver) to manage all received messages the same way |


## Generating Diffs

Use the [Makefile](./Makefile) to add new contracts to the diffs.


## License

Copyright © 2024, Aave DAO, represented by its governance smart contracts.

Created by [BGD Labs](https://bgdlabs.com/).

License [MIT](./LICENSE)

