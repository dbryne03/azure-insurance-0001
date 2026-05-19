import os
import json
import random
import logging
from datetime import date, timedelta
from faker import Faker
import psycopg2

logger = logging.getLogger(__name__)
fake = Faker("en_GB")

PRODUCT_TYPES = ["buildings", "contents", "combined", "life", "travel", "motor"]
CLAIM_STATUSES = ["open", "under_review", "settled", "rejected", "closed"]
POLICY_STATUSES = ["active", "lapsed", "cancelled", "expired"]


def generate_policyholder() -> dict:
    return {
        "full_name": fake.name(),
        "date_of_birth": fake.date_of_birth(minimum_age=18, maximum_age=85).isoformat(),
        "ni_number": fake.bothify(text="??######?").upper(),
        "address_line_1": fake.street_address(),
        "city": fake.city(),
        "postcode": fake.postcode(),
        "email": fake.email(),
        "telephone": fake.phone_number(),
    }


def generate_policy(policyholder_id: int) -> dict:
    inception = fake.date_between(start_date="-5y", end_date="today")
    return {
        "policyholder_id": policyholder_id,
        "policy_number": fake.bothify(text="POL-########"),
        "product_type": random.choice(PRODUCT_TYPES),
        "inception_date": inception.isoformat(),
        "expiry_date": (inception + timedelta(days=365)).isoformat(),
        "annual_premium": round(random.uniform(150.0, 2500.0), 2),
        "status": random.choice(POLICY_STATUSES),
    }


def generate_claim(policy_id: int) -> dict:
    return {
        "policy_id": policy_id,
        "claim_reference": fake.bothify(text="CLM-########"),
        "incident_date": fake.date_between(start_date="-3y", end_date="today").isoformat(),
        "description": fake.sentence(nb_words=12),
        "settlement_amount": round(random.uniform(500.0, 50000.0), 2),
        "status": random.choice(CLAIM_STATUSES),
    }


def main(n_policyholders: int = 500) -> None:
    # TODO: connect to Azure Database for PostgreSQL and insert generated records
    # conn = psycopg2.connect(...)
    logger.info("Generating %d synthetic policyholder records", n_policyholders)

    for i in range(1, n_policyholders + 1):
        policyholder = generate_policyholder()
        n_policies = random.randint(1, 3)
        for _ in range(n_policies):
            policy = generate_policy(policyholder_id=i)
            if random.random() < 0.3:
                claim = generate_claim(policy_id=i)

    logger.info("Seed complete")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
