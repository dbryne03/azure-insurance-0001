import hashlib
import logging
from typing import Any

logger = logging.getLogger(__name__)


def generate_row_signature(row: dict[str, Any], columns: list[str]) -> str:
    """Generate a deterministic SHA-256 hash for a row.

    Columns are sorted to ensure consistency regardless of query column ordering
    across source and target systems. Values are pipe-delimited.
    """
    raw = "|".join(str(row.get(col, "")) for col in sorted(columns))
    return hashlib.sha256(raw.encode()).hexdigest()


def hash_resultset(rows: list[dict], pk_column: str, columns: list[str]) -> dict[str, str]:
    """Return a mapping of primary key → row hash for a result set."""
    return {
        str(row[pk_column]): generate_row_signature(row, columns)
        for row in rows
    }


def compare_hashes(
    source_hashes: dict[str, str],
    target_hashes: dict[str, str],
) -> dict:
    """Compare source and target hash maps. Returns a summary dict."""
    source_keys = set(source_hashes)
    target_keys = set(target_hashes)

    matched = sum(
        1 for k in source_keys & target_keys
        if source_hashes[k] == target_hashes[k]
    )
    mismatched = [
        {"pk": k, "source_hash": source_hashes[k], "target_hash": target_hashes[k]}
        for k in source_keys & target_keys
        if source_hashes[k] != target_hashes[k]
    ]
    missing_in_target = list(source_keys - target_keys)
    missing_in_source = list(target_keys - source_keys)

    return {
        "total_source_rows": len(source_keys),
        "total_target_rows": len(target_keys),
        "matched": matched,
        "mismatched": mismatched,
        "missing_in_target": missing_in_target,
        "missing_in_source": missing_in_source,
    }
