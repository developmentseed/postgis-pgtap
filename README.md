
# PostGIS + PGTap

postgis docker images with pgtap for use un CI

###  Images

`ghcr.io/developmentseed/postgis-pgtap:{9.6|10|11|12|13}-{2.5|3.1}`

### Usage

Example of use with github actions:

```yaml
name: CI

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  test:
    name: test
    runs-on: ubuntu-latest
    services:
      postgres:
        image: ghcr.io/developmentseed/postgis-pgtap:13-3.1
        env:
          POSTGRES_USER: username
          POSTGRES_PASSWORD: password
          POSTGRES_DB: postgres
        ports:
          - 5432:5432
        options: --health-cmd pg_isready --health-interval 10s --health-timeout 5s --health-retries 5

    steps:
      - uses: actions/checkout@v2

      - name: Install Postgres libs
        run: sudo apt-get install libpq-dev

      - name: Run test
        env:
          PGUSER: username
          PGPASSWORD: password
          PGHOST: localhost
          PGDATABASE: postgres
          PGPORT: 5432
        run: |
          TESTOUTPUT=$(psql -X -f test/pgtap.sql)
          echo "Checking if any tests are not ok on db $1"
          if [[ $(echo "$TESTOUTPUT" | grep -e '^not') ]]; then
              echo "PGTap tests failed."
              echo "$TESTOUTPUT"
              exit 1
          else
              echo "All PGTap Tests Passed!"
          fi
```
